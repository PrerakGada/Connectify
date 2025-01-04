import express, { Request, Response, Router } from "express";
import jwt from "jsonwebtoken";
import User from "../models/User";
import { UserDetails } from "../models/UserDetails";

const router: Router = express.Router();

interface SignupRequestBody {
  name: string;
  email: string;
  password: string;
}

interface LoginRequestBody {
  email: string;
  password: string;
}

// Signup route
router.post(
  "/signup",
  async (req: Request<{}, {}, SignupRequestBody>, res: Response) => {
    try {
      const { name: username, email, password } = req.body;

      // Check if user already exists
      const existingUser = await User.findOne({ $or: [{ email }] });
      if (existingUser) {
        return res.status(400).json({ message: "User already exists" });
      }

      // Create new user
      const user = new User({ username, email, password });
      await user.save();

      // Generate JWT
      const token = jwt.sign(
        { userId: user._id, username: user.username, email: user.email },
        process.env.JWT_SECRET || "",
        { expiresIn: "24h" }
      );

      res.status(201).json({
        user: {
          id: user._id,
          name: user.username,
          email: user.email,
          token,
        },
      });
    } catch (error) {
      res
        .status(500)
        .json({
          message: "Error creating user",
          error: error instanceof Error ? error.message : "Unknown error",
        });
    }
  }
);

// Login route
router.post(
  "/login",
  async (req: Request<{}, {}, LoginRequestBody>, res: Response) => {
    try {
      const { email, password } = req.body;

      // Find user
      const user = await User.findOne({ email });
      if (!user) {
        return res.status(401).json({ message: "Invalid credentials" });
      }

      // Check password
      const isMatch = await user.comparePassword(password);
      if (!isMatch) {
        return res.status(401).json({ message: "Invalid credentials" });
      }

      // Get user details
      const userDetails = await UserDetails.findOne({ userId: user._id });

      // Generate JWT
      const token = jwt.sign(
        { userId: user._id, username: user.username, email: user.email },
        process.env.JWT_SECRET || "",
        { expiresIn: "24h" }
      );

      res.json({
        user: {
          id: user._id,
          name: user.username,
          email: user.email,
          token,
        },
        userDetails: userDetails || null
      });
    } catch (error) {
      res
        .status(500)
        .json({
          message: "Error logging in",
          error: error instanceof Error ? error.message : "Unknown error",
        });
    }
  }
);

export default router;
