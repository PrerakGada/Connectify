import 'dart:convert';

import 'package:connectify/features/jobs/models/job_model/job_model.dart';
import 'package:connectify/features/bluetooth/repositories/nearby_jobs_repository.dart';
import 'package:connectify/core/services/api_service.dart';

class NearbyJobsRepositoryImpl implements NearbyJobsRepository {
  final ApiService _apiService;

  NearbyJobsRepositoryImpl(this._apiService);

  @override
  Future<List<Job>> fetchNearbyJobs(String employerId) async {
    final response = await _apiService.request(
      endpoint: '/jobs/nearby/${employerId}',
      method: 'GET',
    );
    final json = jsonDecode(response.body);
    return (json['jobs'] as List)
        .map((jobJson) => Job.fromJson(jobJson))
        .toList();
  }
}
