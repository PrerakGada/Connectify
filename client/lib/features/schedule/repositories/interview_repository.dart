import 'package:connectify/features/schedule/models/interview_model.dart';

abstract class InterviewRepository {
  Future<InterviewModel> scheduleInterview({
    required String employeeId,
    required String employerId,
    required DateTime startTime,
    required DateTime endTime,
  });

  Future<List<InterviewModel>> getAllInterviews();
}
