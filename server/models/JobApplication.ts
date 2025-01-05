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

// Sanitize input before saving
jobApplicationSchema.pre('save', function(next) {
  const doc = this.toObject();
  for (const [key, value] of Object.entries(doc)) {
    if (typeof value === 'string') {
      this.set(key, value.trim());
    }
  }
  next();
});

export const JobApplication: IJobApplicationModel = mongoose.model<IJobApplication, IJobApplicationModel>(
  "JobApplication",
  jobApplicationSchema
); 