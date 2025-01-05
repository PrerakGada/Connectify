import 'package:connectify/core/services/api_service.dart';
import 'package:connectify/features/schedule/models/interview_model.dart';
import 'package:connectify/features/schedule/repositories/interview_repository.dart';
import 'dart:convert';

class InterviewRepositoryImpl implements InterviewRepository {
  final ApiService _apiService;

  InterviewRepositoryImpl(this._apiService);

  @override
  Future<InterviewModel> scheduleInterview({
    required String employeeId,
    required String employerId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final response = await _apiService.request(
      endpoint: '/interviews',
      method: 'POST',
      body: {
        'employeeId': employeeId,
        'employerId': employerId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
      },
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return InterviewModel.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<InterviewModel>> getAllInterviews() async {
    final response = await _apiService.request(
      endpoint: '/interviews',
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => InterviewModel.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  }
}
