import 'package:connectify/features/auth/models/user_model/user_model.dart';
import 'package:connectify/features/auth/models/auth_model/auth_model.dart';
import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';
import 'package:connectify/features/auth/repositories/auth_repository.dart';
import 'package:connectify/core/services/api_service.dart';
import 'dart:convert';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await _apiService.request(
      endpoint: '/auth/login',
      method: 'POST',
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = AuthModel.fromJson(json['user']);
      final userDetails = UserDetailsModel.fromJson(json['userDetails']);
      return UserModel(auth: user, userDetails: userDetails);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<AuthModel> signup(String name, String email, String password) async {
    final response = await _apiService.request(
      endpoint: '/auth/signup',
      method: 'POST',
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final user = AuthModel.fromJson(json['user']);
      return user;
    } else {
      throw Exception(response.body);
    }
  }
}
