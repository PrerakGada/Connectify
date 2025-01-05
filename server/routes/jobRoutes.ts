import express from 'express';
import { getEmployerJobs, createJob, getJobsByDistance } from '../controllers/jobController';

const router = express.Router();

router.get('/employer/:employerId', getEmployerJobs);
router.post('/', createJob);
router.get('/distance/:userId', getJobsByDistance);

export default router; 