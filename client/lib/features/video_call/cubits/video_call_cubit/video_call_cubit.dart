import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/video_call_model.dart';
import '../../repositories/video_call_repository.dart';
part 'video_call_state.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  final VideoCallRepository _repository;

  VideoCallCubit(this._repository) : super(VideoCallInitial());

  Future<void> generateToken({
    required String channelName,
    required String uid,
    required String token,
  }) async {
    try {
      emit(VideoCallLoading());
      final videoCallToken = await _repository.generateToken(
        channelName: channelName,
        uid: uid,
        token: token,
      );
      emit(VideoCallTokenGenerated(videoCallToken));
    } catch (e) {
      emit(VideoCallError(e.toString()));
    }
  }
}
