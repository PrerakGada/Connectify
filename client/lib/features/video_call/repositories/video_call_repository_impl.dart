import 'dart:convert';
import 'package:connectify/features/video_call/models/video_call_model.dart';
import 'package:connectify/features/video_call/repositories/video_call_repository.dart';
import 'package:connectify/core/services/api_service.dart';

class VideoCallRepositoryImpl implements VideoCallRepository {
  final ApiService _apiService;

  VideoCallRepositoryImpl(this._apiService);

  @override
  Future<VideoCallToken> generateToken({
    required String channelName,
    required String uid,
    required String token,
  }) async {
    final response = await _apiService.request(
      endpoint: '/video-call/token',
      method: 'POST',
      body: {
        'channelName': channelName,
        'uid': uid,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['success']) {
        return VideoCallToken(
          token: json['token'],
          appId: json['appId'],
        );
      }
    }

    throw Exception(response.body);
  }
}
