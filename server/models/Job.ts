import mongoose, { Document, Model, Schema } from "mongoose";

export interface IJob extends Document {
  role: string;
  pay: string;
  requiredSkills: string[];
  description: string;
  employerId: mongoose.Types.ObjectId;
  latitude: number;
  longitude: number;
  createdAt: Date;
  updatedAt: Date;
}

interface IJobModel extends Model<IJob> {}

const jobSchema = new mongoose.Schema(
  {
    role: {
      type: String,
      required: true,
    },
    pay: {
      type: String,
      required: true,
    },
    requiredSkills: [
      {
        type: String,
        required: true,
      },
    ],
    description: {
      type: String,
      required: true,
    },
    employerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    latitude: {
      type: Number,
      required: true,
    },
    longitude: {
      type: Number,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

export const Job: IJobModel = mongoose.model<IJob, IJobModel>("Job", jobSchema);
