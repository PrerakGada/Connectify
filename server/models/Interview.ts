import mongoose, { Document, Model, Schema } from "mongoose";

export interface IInterview extends Document {
  employeeId: mongoose.Types.ObjectId;
  employerId: mongoose.Types.ObjectId;
  startTime: Date;
  endTime: Date;
  createdAt: Date;
  updatedAt: Date;
}

interface IInterviewModel extends Model<IInterview> {}

const interviewSchema = new mongoose.Schema(
  {
    employeeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    employerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    startTime: {
      type: Date,
      required: true,
    },
    endTime: {
      type: Date,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

interviewSchema.pre("save", function (next) {
  const doc = this.toObject();
  for (const [key, value] of Object.entries(doc)) {
    if (typeof value === "string") {
      this.set(key, (value as string).trim());
    }
  }
  next();
});

export const Interview: IInterviewModel = mongoose.model<
  IInterview,
  IInterviewModel
>("Interview", interviewSchema);
