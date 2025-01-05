import { Response } from 'express';
import { UserDetails } from '../models/UserDetails';
import { AuthRequest } from '../middleware/auth';

export const updateUserDetails = async (req: AuthRequest, res: Response) => {
  try {
    const userId = req.user!._id;
    const userDetails = await UserDetails.findOne({ userId });

    if (!userDetails) {
      // Create new user details if they don't exist
      const newUserDetails = new UserDetails({
        userId,
        ...req.body
      });
      await newUserDetails.save();
      return res.status(201).json(newUserDetails);
    }

    // Update existing user details
    Object.assign(userDetails, req.body);
    await userDetails.save();
    return res.status(201).json(userDetails);
  } catch (error: unknown) {
    if (error instanceof Error) {
      res.status(400).json({ message: error.message });
    } else {
      res.status(400).json({ message: 'An unknown error occurred' });
    }
  }
};

export const getUserDetails = async (req: AuthRequest, res: Response) => {
  try {
    const userId = req.user!._id;
    const userDetails = await UserDetails.findOne({ userId });
    if (!userDetails) {
      return res.status(404).json({ message: 'User details not found' });
    }
    return res.json(userDetails);
  } catch (error: unknown) {
    if (error instanceof Error) {
      res.status(400).json({ message: error.message });
    } else {
      res.status(400).json({ message: 'An unknown error occurred' });
    }
  }
}; 