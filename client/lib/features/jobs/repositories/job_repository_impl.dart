import 'dart:convert';

import 'package:connectify/features/jobs/models/job_model/job_model.dart';
import 'package:connectify/features/jobs/repositories/job_repository.dart';
import 'package:connectify/core/services/api_service.dart';

class JobRepositoryImpl implements JobRepository {
  final ApiService _apiService;

  JobRepositoryImpl(this._apiService);

  @override
  Future<List<Job>> getEmployerJobs(String employerId) async {
    final response = await _apiService.request(
      endpoint: '/jobs/employer',
      method: 'GET',
    );
    final json = jsonDecode(response.body);
    return (json['jobs'] as List)
        .map((jobJson) => Job.fromJson(jobJson))
        .toList();
  }

  @override
  Future<Job> createJob({
    required String role,
    required String pay,
    required List<String> requiredSkills,
    required String description,
    required String employerId,
    required double latitude,
    required double longitude,
  }) async {
    final response = await _apiService.request(
      endpoint: '/jobs',
      method: 'POST',
      body: {
        'role': role,
        'pay': pay,
        'requiredSkills': requiredSkills,
        'description': description,
        'employerId': employerId,
        'latitude': latitude,
        'longitude': longitude,
      },
    );
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Job.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<Job>> getJobsByDistance(String userId) async {
    final response = await _apiService.request(
      endpoint: '/jobs/distance',
      method: 'GET',
    );
    final json = jsonDecode(response.body);
    return (json['jobs'] as List)
        .map((jobJson) => Job.fromJson(jobJson))
        .toList();
  }

  @override
  Future<void> applyToJob({
    required String jobId,
    required String employeeId,
    required String coverLetter,
  }) async {
    final response = await _apiService.request(
      endpoint: '/job-applications',
      method: 'POST',
      body: {
        'jobId': jobId,
        'employeeId': employeeId,
        'coverLetter': coverLetter,
      },
    );
    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
  }
}
