import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectify/features/auth/models/user_model/user_model.dart';
import 'package:connectify/features/auth/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = 'http://localhost:5000/api/auth';
  final http.Client _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserModel.fromJson(json['user']);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/signup'),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return UserModel.fromJson(json['user']);
    } else {
      throw Exception('Failed to signup');
    }
  }
}
