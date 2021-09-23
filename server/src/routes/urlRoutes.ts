import { verifyToken } from "./../middlewares/auth";
import urlController from "../controllers/urlController";

import { Router } from "express";
import env from "../config";
const urlRoutes = Router();
// urlRoutes.get("/api/v1/all", urlController.getAllURLS);

urlRoutes.post("/api/v1/editUrl", verifyToken, urlController.editUrl);

urlRoutes.get("/", (req, res) => res.redirect(env.APP));

urlRoutes.get("/:code", urlController.redirect);

urlRoutes.put("/api/v1/createUrl", verifyToken, urlController.createUrl);

urlRoutes.delete("/api/v1/deleteUrl", verifyToken, urlController.deleteUrl);

urlRoutes.get("/api/v1/getUserUrls", verifyToken, urlController.getUserUrls);

export default urlRoutes;
