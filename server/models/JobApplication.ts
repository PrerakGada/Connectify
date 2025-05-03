import mongoose, { Document, Model, Schema } from 'mongoose';

export interface IJobApplication extends Document {
  jobId: mongoose.Types.ObjectId;
  employeeId: mongoose.Types.ObjectId;
  coverLetter: string;
  createdAt: Date;
  updatedAt: Date;
}

interface IJobApplicationModel extends Model<IJobApplication> {}

const jobApplicationSchema = new mongoose.Schema({
  jobId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Job',
    required: true
  },
  employeeId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  coverLetter: {
    type: String,
    required: true
  },
}, {
  timestamps: true
});

export const JobApplication: IJobApplicationModel = mongoose.model<IJobApplication, IJobApplicationModel>(
  "JobApplication",
  jobApplicationSchema
); 