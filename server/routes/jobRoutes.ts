import express from 'express';
import { getEmployerJobs, createJob, getJobsByDistance } from '../controllers/jobController';
import { authMiddleware } from '../middleware/auth';
import { roleMiddleware } from '../middleware/role';

const router = express.Router();

router.use(authMiddleware);

router.post('/', roleMiddleware('employer'), createJob);

router.get('/employer', roleMiddleware('employer'), getEmployerJobs);

router.get('/distance', roleMiddleware('employee'), getJobsByDistance);

export default router; 