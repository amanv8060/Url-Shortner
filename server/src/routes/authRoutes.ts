import authController from "../controllers/authController";
import { verifyToken } from "./../middlewares/auth";

const authRoutes = require("express").Router();

authRoutes.post("/api/v1/login", authController.userSignin);
authRoutes.put("/api/v1/signup", authController.createUser);
authRoutes.get("/api/v1/verify", verifyToken, authController.tokenVerify);

export default authRoutes;
