import 'package:connectify/features/video_call/models/video_call_model.dart';

abstract class VideoCallRepository {
  Future<VideoCallToken> generateToken({
    required String channelName,
    required String uid,
    required String token,
  });
}
