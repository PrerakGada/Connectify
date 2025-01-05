import express from 'express';
import { scheduleInterview, returnAllInterviews } from '../controllers/interviewController';
import { authMiddleware } from '../middleware/auth';
import { roleMiddleware } from '../middleware/role';

const router = express.Router();

router.use(authMiddleware);

router.post('/', roleMiddleware('employer'), scheduleInterview);

router.get('/', returnAllInterviews);

export default router; 