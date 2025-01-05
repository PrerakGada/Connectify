import express from "express";
import { generateToken } from "../controllers/videoCallController";
import { authMiddleware } from "../middleware/auth";

const router = express.Router();

router.post("/token", authMiddleware, generateToken);

export default router;
