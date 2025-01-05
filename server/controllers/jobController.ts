import { Request, Response } from 'express';
import { Job, IJob } from '../models/Job';
import { UserDetails } from '../models/UserDetails';
import { JobApplication } from '../models/JobApplication';
import { calculateDistance } from '../utils/geoUtils';
import { RoleRequest } from '../middleware/role';

export const getEmployerJobs = async (req: RoleRequest, res: Response) => {
  try {
    const jobs = await Job.find({ employerId: req.user?.userId });
    
    const jobsWithApplications = await Promise.all(jobs.map(async job => {
      const applications = await JobApplication.find({ jobId: job._id });
      
      const applicationsWithUserDetails = await Promise.all(applications.map(async (application) => {
        const applicantDetails = await UserDetails.findOne({ userId: application.employeeId });
        return {
          ...application.toObject(),
          applicantDetails: applicantDetails ? {
            email: applicantDetails.email,
            address: applicantDetails.address,
            contactNumber: applicantDetails.contactNumber,
            experiences: applicantDetails.experiences,
            education: applicantDetails.education,
            skills: applicantDetails.skills,
            extraCurriculars: applicantDetails.extraCurriculars,
            achievements: applicantDetails.achievements,
            portfolioLinks: applicantDetails.portfolioLinks
          } : null
        };
      }));

      return {
        ...job.toObject(),
        applications: applicationsWithUserDetails
      };
    }));

    return res.json({ jobs: jobsWithApplications });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching jobs', error });
  }
};

export const createJob = async (req: RoleRequest, res: Response) => {
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

export const getJobsByDistance = async (req: RoleRequest, res: Response) => {
  try {
    const userDetails = await UserDetails.findOne({ userId: req.user?.userId });
    
    if (!userDetails) {
      return res.status(404).json({ message: 'User details not found' });
    }

    const jobs = await Job.find({}) as IJob[];
    
    const userApplications = await JobApplication.find({ employeeId: req.user?.userId });
    const appliedJobIds = userApplications.map(app => app.jobId.toString());

    const jobsWithDistance = jobs
      .filter(job => !appliedJobIds.includes(job.toObject()._id.toString()))
      .map(job => {
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
      })
      .sort((a, b) => a.distance - b.distance);

    return res.json({ jobs: jobsWithDistance });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching jobs by distance', error });
  }
}; 