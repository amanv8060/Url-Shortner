import authController from "../controllers/authController";

const authRoutes = require("express").Router();

authRoutes.post("/api/v1/login", authController.userSignin);
// authRoutes.put("/api/v1/signup", authController.createUser);

export default authRoutes;
