import { URLModel } from "../models/urlModel";

import { Request, Response } from "express";
import { UserModel } from "../models/userModel";

const getAllURLS = async (req: Request, res: Response) => {
  let urls = await URLModel.find({});
  res.status(200).send({ urls: urls });
};

const getUserUrls = async (req: Request, res: Response) => {
  let urls = await UserModel.findById(req.body.docId, "urls").populate(
    "urls"
  );
  if (!urls) {
    return res.status(404).json({ message: "Failed to fetch urls" });
  }
  return res.status(200).json( urls );
};
const createUrl = async (req: Request, res: Response) => {
  if (req.body.shortUrl === undefined) {
    return res.status(400).json({ message: "Please provide a short url" });
  }
  if (req.body.longUrl === undefined) {
    return res.status(400).json({ message: "Please provide a long url" });
  }
  const exists = await URLModel.findOne({ shortUrl: req.body.shortUrl });
  if (exists) {
    return res.status(400).json({ message: "Short url already exists" });
  }
  const user = await UserModel.findOne({ _id: req.body.docId });
  if (!user) {
    return res.status(400).json({ message: "User not found" });
  }
  const url = new URLModel({
    shortUrl: req.body.shortUrl,
    longUrl: req.body.longUrl,
  });

  url.save(async (err, newurl) => {
    if (err) {
      res.status(500).json({ message: "Internal Server Error" });
    }
    const updatedUser = await UserModel.findOneAndUpdate(
      { _id: req.body.docId },
      { $push: { urls: [url._id] } }
    );
    if (!updatedUser) {
      await URLModel.findByIdAndRemove(url._id);
      return res.status(500).json({ message: "Internal Server Error" });
    }
    return res.status(200).json(newurl);
  });
};

const editUrl = async (req: Request, res: Response) => {
  if (req.body.id === undefined) {
    return res.status(400).json({ message: "Please provide a id" });
  }
  if (req.body.longUrl === undefined) {
    return res.status(400).json({ message: "Please provide a long url" });
  }
  await URLModel.findByIdAndUpdate(
    req.body.id,
    {
      longUrl: req.body.longUrl,
    },
    //return the updated url
    { new: true }
  )
    .then((url) => {
      return res.status(200).json(url);
    })
    .catch((err) => {
      return res.status(404).send({ message: err });
    });
};

const redirect = async (req: Request, res: Response) => {
  const url = await URLModel.findOne({ shortUrl: req.params.code });
  if (url) {
    res.redirect(url.longUrl);
    url.clicks += 1;
    await url.save();
    return;
  } else {
    res.status(404).json({ message: "URL not found" });
    return;
  }
};

const deleteUrl = async (req: Request, res: Response) => {
  if (req.body.id === undefined) {
    return res.status(400).json({ message: "Please provide a id" });
  }

  const user = await UserModel.findOneAndUpdate(
    { _id: req.body.docId },
    { $pull: { cars: req.query.cId } }
  );
  await URLModel.findByIdAndRemove(req.body.id)
    .then((url) => {
      return res.status(200).json(url);
    })
    .catch((err) => {
      return res.status(500).send({ message: err });
    });
};
export default {
  createUrl,
  getAllURLS,
  editUrl,
  redirect,
  deleteUrl,
  getUserUrls,
};
