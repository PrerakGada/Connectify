import { Request, Response } from 'express';
import { JobApplication } from '../models/JobApplication';
import { RoleRequest } from '../middleware/role';

export const createJobApplication = async (req: RoleRequest, res: Response) => {
  try {
    const { jobId, coverLetter } = req.body;
    
    const application = new JobApplication({
      jobId,
      employeeId: req.user?.userId,
      coverLetter
    });

    await application.save();
    res.status(201).json(application);
  } catch (error) {
    res.status(500).json({ message: 'Error creating job application', error });
  }
}; 