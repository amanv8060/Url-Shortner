import { verifyToken } from "./../middlewares/auth";
import urlController from "../controllers/urlController";

import { Router } from "express";
const urlRoutes = Router();
urlRoutes.get("/api/v1/all", verifyToken, urlController.getAllURLS);

urlRoutes.post("/api/v1/editUrl", verifyToken, urlController.editUrl);

urlRoutes.get("/:code", urlController.redirect);

urlRoutes.put("/api/v1/createUrl" , verifyToken, urlController.createUrl);

urlRoutes.delete("/api/v1/deleteUrl", urlController.deleteUrl);

export default urlRoutes;
