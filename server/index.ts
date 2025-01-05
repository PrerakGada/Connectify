import express, { Application } from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';
import authRoutes from './routes/authRoutes';
import userDetailsRoutes from './routes/userDetailsRoutes';
import jobRoutes from './routes/jobRoutes';
import jobApplicationRoutes from './routes/jobApplicationRoutes';
import interviewRoutes from './routes/interviewRoutes';

dotenv.config();

const app: Application = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/user-details', userDetailsRoutes);
app.use('/api/jobs', jobRoutes);
app.use('/api/job-applications', jobApplicationRoutes);
app.use('/api/interviews', interviewRoutes);

// MongoDB Connection
const MONGODB_URI: string = process.env.MONGODB_URI || "";

mongoose.connect(MONGODB_URI)
  .then(() => console.log('Connected to MongoDB'))
  .catch((err: Error) => console.error('MongoDB connection error:', err));

const PORT: number = parseInt(process.env.PORT || '5000', 10);
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
}); 