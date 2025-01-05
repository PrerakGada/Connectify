import 'package:connectify/features/jobs/models/job_model/job_model.dart';

abstract class JobRepository {
  Future<List<Job>> getEmployerJobs(String employerId);
  Future<Job> createJob({
    required String role,
    required String pay,
    required List<String> requiredSkills,
    required String description,
    required String employerId,
    required double latitude,
    required double longitude,
  });
  Future<List<Job>> getJobsByDistance(String userId);
  Future<void> applyToJob({
    required String jobId,
    required String employeeId,
    required String coverLetter,
  });
}
