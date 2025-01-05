import express from 'express';
import { createJobApplication } from '../controllers/jobApplicationController';
import { authMiddleware } from '../middleware/auth';
import { roleMiddleware } from '../middleware/role';

const router = express.Router();

router.use(authMiddleware);

router.post('/', roleMiddleware('employee'), createJobApplication);

export default router; 