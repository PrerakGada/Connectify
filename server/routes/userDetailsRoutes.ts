import express from 'express';
import { authMiddleware } from '../middleware/auth';
import { updateUserDetails, getUserDetails } from '../controllers/userDetailsController';

const router = express.Router();

// Update user details
router.put('/', authMiddleware, updateUserDetails);

// Get user details
router.get('/', authMiddleware, getUserDetails);

export default router; 