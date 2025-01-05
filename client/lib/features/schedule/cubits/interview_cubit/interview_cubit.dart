import 'package:connectify/features/schedule/models/interview_model.dart';
import 'package:connectify/features/schedule/repositories/interview_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
  final InterviewRepository _repository;

  InterviewCubit(this._repository) : super(InterviewInitial());

  Future<void> scheduleInterview({
    required String employeeId,
    required String employerId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    List<InterviewModel> interviews = [];
    if (state is InterviewLoaded) {
      interviews = (state as InterviewLoaded).interviews;
    }
    emit(InterviewLoading());
    try {
      final interview = await _repository.scheduleInterview(
        employeeId: employeeId,
        employerId: employerId,
        startTime: startTime,
        endTime: endTime,
      );
      emit(InterviewLoaded([...interviews, interview]));
    } catch (e) {
      emit(InterviewError(e.toString()));
    }
  }

  Future<void> getAllInterviews() async {
    emit(InterviewLoading());
    try {
      final interviews = await _repository.getAllInterviews();
      emit(InterviewLoaded(interviews));
    } catch (e) {
      emit(InterviewError(e.toString()));
    }
  }
}
