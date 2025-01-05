part of 'video_call_cubit.dart';

abstract class VideoCallState extends Equatable {
  const VideoCallState();

  @override
  List<Object?> get props => [];
}

class VideoCallInitial extends VideoCallState {}

class VideoCallLoading extends VideoCallState {}

class VideoCallTokenGenerated extends VideoCallState {
  final VideoCallToken token;

  const VideoCallTokenGenerated(this.token);

  @override
  List<Object?> get props => [token];
}

class VideoCallError extends VideoCallState {
  final String message;

  const VideoCallError(this.message);

  @override
  List<Object?> get props => [message];
}
