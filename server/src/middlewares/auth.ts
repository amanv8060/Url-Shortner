import jwt from "jsonwebtoken";

import env  from "../config";

import { Request, Response } from "express";


const verifyToken = (req: Request, res: Response, next: any) => {
  const token  = req.headers.authorization ;

  if (!token) {
    return res.status(403).send({ message: "No token provided!" });
  }

  jwt.verify(token, env.SECRET_KEY, (err: any, decoded: any) => {
    if (err) {
      return res.status(401).send({ message: "Unauthorized!" });
    }
    req.body.docId = decoded.id;
    next();
  });
};

export { verifyToken };
