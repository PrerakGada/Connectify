import 'package:connectify/features/jobs/models/job_model/job_model.dart';

abstract class NearbyJobsRepository {
  Future<List<Job>> fetchNearbyJobs(String employerId);
}
