import * as jwt from "jsonwebtoken";
import argon2 from "argon2";
import { Request, Response } from "express";
import { UserModel } from "../models/userModel";
import env from "../config";
import { CallbackError } from "mongoose";

const userSignin = async (req: Request, res: Response) => {
  let user = await UserModel.findOne({ email: req.body.email });
  // .populate(
  //   "urls",
  //   "-__v"
  // );

  if (!user) {
    return res.status(404).send({ message: "Email Not found." });
  }

  if (!(await argon2.verify(user.password, req.body.password))) {
    return res.status(401).send({ message: "Invalid Password" });
  }

  const token = jwt.sign({ id: user.id }, env.SECRET_KEY, {
    expiresIn: 86400, // 1 day (in sec)
  });

  res.status(200).send({
    id: user._id,
    email: user.email,
    name: user.name,
    token: token,
  });
};

const createUser = async (req: Request, res: Response) => {
  if (req.body.email === undefined) {
    return res.status(400).send({ message: "Email is required" });
  }
  if (req.body.password === undefined) {
    return res.status(400).send({ message: "Password is required" });
  }

  if (req.body.name === undefined) {
    return res.status(400).send({ message: "Name is required" });
  }
  const hash = await argon2.hash(req.body.password, {
    type: argon2.argon2id,
  });

  const user = new UserModel({
    email: req.body.email,
    password: hash,
    name: req.body.name,
    urls: [],
  });

  user.save((err: CallbackError, user: any) => {
    if (err) {
      return res.status(500).send({ message: err.message });
    } else {
      return res.status(200).send({ message: "User Registered Successfully" });
    }
  });
};
const tokenVerify = async (req: Request, res: Response) => {
  res.status(200).send({ message: "Token Verified" });
};

export default { userSignin, createUser , tokenVerify};
