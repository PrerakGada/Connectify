import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { IUser } from '../models/User';

interface JwtPayload {
  _id: string;
  username: string;
  email: string;
}

export interface AuthRequest extends Request {
  user?: IUser;
}

export const authMiddleware = (req: AuthRequest, res: Response, next: NextFunction) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    if (!token) throw new Error('No token provided');

    const decoded = jwt.verify(token, process.env.JWT_SECRET || '') as JwtPayload;
    req.user = decoded as unknown as IUser;
    next();
  } catch (error: unknown) {
    res.status(401).json({ message: 'Please authenticate' });
  }
}; 