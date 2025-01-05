import express, { Router } from "express";
import { signup, login } from "../controllers/authController";

const router: Router = express.Router();

// Signup route
router.post("/signup", signup);

// Login route
router.post("/login", login);

export default router;
