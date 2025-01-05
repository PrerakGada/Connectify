import { Request, Response } from 'express';
import { Job } from '../models/Job';
import { UserDetails } from '../models/UserDetails';
import { calculateDistance } from '../utils/geoUtils';

export const getEmployerJobs = async (req: Request, res: Response) => {
  try {
    const { employerId } = req.params;
    
    const employerDetails = await UserDetails.findOne({ 
      userId: employerId,
      isEmployee: false 
    });
    
    if (!employerDetails) {
      return res.status(403).json({ message: 'Invalid employer ID or user is not an employer' });
    }

    const jobs = await Job.find({ employerId });
    return res.json({ jobs });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching jobs', error });
  }
};

export const createJob = async (req: Request, res: Response) => {
  try {
    const { role, pay, requiredSkills, description, employerId, latitude, longitude } = req.body;
    
    const job = new Job({
      role,
      pay,
      requiredSkills,
      description,
      employerId,
      latitude,
      longitude,
    });

    await job.save();
    res.status(201).json(job);
  } catch (error) {
    res.status(500).json({ message: 'Error creating job', error });
  }
};

export const getJobsByDistance = async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;
    
    // Get user's location from UserDetails
    const userDetails = await UserDetails.findOne({ userId });
    
    if (!userDetails) {
      return res.status(404).json({ message: 'User details not found' });
    }

    // Get all jobs
    const jobs = await Job.find({});
    
    // Calculate distance for each job and sort
    const jobsWithDistance = jobs.map(job => {
      const distance = calculateDistance(
        userDetails.latitude,
        userDetails.longitude,
        job.latitude,
        job.longitude
      );
      return {
        ...job.toObject(),
        distance
      };
    }).sort((a, b) => a.distance - b.distance);

    return res.json({ jobs: jobsWithDistance });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching jobs by distance', error });
  }
}; 