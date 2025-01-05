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

// Sanitize input before saving
jobSchema.pre("save", function (next) {
  const doc = this.toObject();
  for (const [key, value] of Object.entries(doc)) {
    if (typeof value === "string") {
      this.set(key, value.trim());
    }
  }
  next();
});

export const Job: IJobModel = mongoose.model<IJob, IJobModel>("Job", jobSchema);
