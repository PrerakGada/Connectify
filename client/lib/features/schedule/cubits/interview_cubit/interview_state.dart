part of 'interview_cubit.dart';

abstract class InterviewState extends Equatable {
  const InterviewState();

  @override
  List<Object> get props => [];
}

class InterviewInitial extends InterviewState {}

class InterviewLoading extends InterviewState {}

class InterviewLoaded extends InterviewState {
  final List<InterviewModel> interviews;

  const InterviewLoaded(this.interviews);

  @override
  List<Object> get props => [interviews];
}

class InterviewError extends InterviewState {
  final String message;

  const InterviewError(this.message);

  @override
  List<Object> get props => [message];
}
