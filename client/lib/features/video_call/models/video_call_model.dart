import 'package:equatable/equatable.dart';

class VideoCallToken extends Equatable {
  final String token;
  final String appId;

  const VideoCallToken({
    required this.token,
    required this.appId,
  });

  @override
  List<Object?> get props => [token, appId];
}
