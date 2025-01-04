import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectify/core/hive/hive_config.dart';
import 'package:connectify/features/auth/models/auth_model/auth_model.dart';
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://192.168.0.109:5000/api';
  final http.Client _client;

  ApiService(this._client);

  Future<http.Response> request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    // Get token from Hive if available
    final authBox = Hive.box<AuthModel>(HiveConfig.userBox);
    final authModel = authBox.get(0);
    if (authModel != null) {
      headers['Authorization'] = 'Bearer ${authModel.token}';
    }

    switch (method.toUpperCase()) {
      case 'GET':
        return await _client.get(uri, headers: headers);
      case 'POST':
        return await _client.post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'PUT':
        return await _client.put(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'DELETE':
        return await _client.delete(uri, headers: headers);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
}
