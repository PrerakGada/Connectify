import { Request, Response, NextFunction } from "express";
import { UserDetails } from "../models/UserDetails";
import { AuthRequest } from "./auth";

export interface RoleRequest extends AuthRequest {
  isEmployee?: boolean;
}

type RoleType = "employee" | "employer";

export const roleMiddleware = (requiredRole: RoleType) => {
  return async (req: RoleRequest, res: Response, next: NextFunction) => {
    try {
      if (!req.user) {
        return res.status(401).json({ message: "User not authenticated" });
      }
      const userDetails = await UserDetails.findOne({
        userId: req.user.userId,
      });
      if (!userDetails) {
        return res.status(404).json({ message: "User details not found" });
      }

      req.isEmployee = userDetails.isEmployee;

      if (
        (requiredRole === "employee" && !userDetails.isEmployee) ||
        (requiredRole === "employer" && userDetails.isEmployee)
      ) {
        return res.status(403).json({
          message: `Only ${requiredRole}s can access this resource`,
        });
      }

      next();
    } catch (error) {
      res.status(500).json({ message: "Error checking user role" });
    }
  };
};
