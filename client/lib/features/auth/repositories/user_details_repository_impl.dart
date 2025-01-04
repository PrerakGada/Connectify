import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';
import 'package:connectify/features/auth/repositories/user_details_repository.dart';
import 'package:connectify/core/services/api_service.dart';
import 'dart:convert';

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final ApiService _apiService;

  UserDetailsRepositoryImpl(this._apiService);

  @override
  Future<UserDetailsModel> getUserDetails() async {
    final response = await _apiService.request(
      endpoint: '/user-details',
      method: 'GET',
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserDetailsModel.fromJson(json);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  @override
  Future<UserDetailsModel> updateUserDetails(
      UserDetailsModel userDetails) async {
    final response = await _apiService.request(
      endpoint: '/user-details',
      method: 'PUT',
      body: userDetails.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return UserDetailsModel.fromJson(json);
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }
}
