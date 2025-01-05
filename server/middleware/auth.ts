import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";

interface JwtPayload {
  userId: string;
  username: string;
  email: string;
  iat: number;
  exp: number;
}
export interface AuthRequest extends Request {
  user?: JwtPayload;
}

export const authMiddleware = (
  req: AuthRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const token = req.header("Authorization")?.replace("Bearer ", "");
    if (!token) throw new Error("No token provided");

    const decoded = jwt.verify(token, process.env.JWT_SECRET || "");
    req.user = decoded as unknown as JwtPayload;
    next();
  } catch (error: unknown) {
    res.status(401).json({ message: "Please authenticate" });
  }
};
