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
      print('Using token: ${authModel.token.substring(0, 10)}...'); // Debug log
    } else {
      print('No auth token found in Hive'); // Debug log
    }

    print('Making $method request to $uri'); // Debug log
    print('Headers: $headers'); // Debug log
    if (body != null) {
      print('Body: $body'); // Debug log
    }

    try {
      switch (method.toUpperCase()) {
        case 'GET':
          final response = await _client.get(uri, headers: headers);
          print('Response status: ${response.statusCode}'); // Debug log
          print('Response body: ${response.body}'); // Debug log
          return response;
        case 'POST':
          final response = await _client.post(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          print('Response status: ${response.statusCode}'); // Debug log
          print('Response body: ${response.body}'); // Debug log
          return response;
        case 'PUT':
          final response = await _client.put(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          print('Response status: ${response.statusCode}'); // Debug log
          print('Response body: ${response.body}'); // Debug log
          return response;
        case 'DELETE':
          final response = await _client.delete(uri, headers: headers);
          print('Response status: ${response.statusCode}'); // Debug log
          print('Response body: ${response.body}'); // Debug log
          return response;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
    } catch (e) {
      print('Error making request: $e'); // Debug log
      rethrow;
    }
  }
}
