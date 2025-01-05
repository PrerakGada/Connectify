import { Request, Response } from "express";
import { Interview } from "../models/Interview";
import User from "../models/User";
import { RoleRequest } from "../middleware/role";
import { UserDetails } from "../models/UserDetails";

export const scheduleInterview = async (req: RoleRequest, res: Response) => {
  try {
    const { employeeId, startTime, endTime } = req.body;
    const employerId = req.user?.userId;

    // Check for overlapping interviews for both employee and employer
    const overlappingInterviews = await Interview.find({
      $or: [{ employeeId }, { employerId }],
      startTime: { $lt: new Date(endTime) },
      endTime: { $gt: new Date(startTime) },
    });

    if (overlappingInterviews.length > 0) {
      return res.status(400).json({
        message:
          "There is an overlapping interview scheduled for either the employee or employer",
      });
    }

    const interview = new Interview({
      employeeId,
      employerId,
      startTime: new Date(startTime),
      endTime: new Date(endTime),
    });

    await interview.save();

    const employee = await User.findById(employeeId);
    const otherPartyName = employee?.username || "Unknown";

    const response = {
      ...interview.toObject(),
      otherPartyName,
    };

    res.status(201).json(response);
  } catch (error) {
    res.status(500).json({ message: "Error scheduling interview", error });
  }
};

export const returnAllInterviews = async (req: RoleRequest, res: Response) => {
  try {
    const userId = req.user?.userId;
    const user = await UserDetails.findOne({ userId });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    let interviews;
    let otherPartyIds: string[] = [];

    if (user.isEmployee) {
      interviews = await Interview.find({ employeeId: userId });
      otherPartyIds = interviews.map((interview) =>
        interview.employerId.toString()
      );
    } else {
      interviews = await Interview.find({ employerId: userId });
      otherPartyIds = interviews.map((interview) =>
        interview.employeeId.toString()
      );
    }
    const otherPartyUsers = await User.find({ _id: { $in: otherPartyIds } });
    const userMap = new Map(
      otherPartyUsers.map((user) => [user.id.toString(), user.username])
    );

    const transformedInterviews = interviews.map((interview) => {
      const otherPartyId = user.isEmployee
        ? interview.employerId.toString()
        : interview.employeeId.toString();
      const otherPartyName = userMap.get(otherPartyId) || "Unknown";

      return {
        ...interview.toObject(),
        otherPartyName,
      };
    });
    res.status(200).json(transformedInterviews);
  } catch (error) {
    res.status(500).json({ message: "Error fetching interviews", error });
  }
};
