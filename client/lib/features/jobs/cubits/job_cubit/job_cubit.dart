import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/job_model/job_model.dart';
import '../../repositories/job_repository.dart';
part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final JobRepository _repository;

  JobCubit(this._repository) : super(JobInitial());

  Future<void> getEmployerJobs(String employerId) async {
    try {
      emit(JobLoading());
      final jobs = await _repository.getEmployerJobs(employerId);
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }

  Future<void> createJob({
    required String role,
    required String pay,
    required List<String> requiredSkills,
    required String description,
    required String employerId,
    required double latitude,
    required double longitude,
  }) async {
    try {
      List<Job> currentJobs = [];
      if (state is JobLoaded) {
        currentJobs = (state as JobLoaded).jobs;
      }
      final job = await _repository.createJob(
        role: role,
        pay: pay,
        requiredSkills: requiredSkills,
        description: description,
        employerId: employerId,
        latitude: latitude,
        longitude: longitude,
      );
      emit(JobLoaded([...currentJobs, job]));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }

  Future<void> getJobsByDistance(String userId) async {
    try {
      emit(JobLoading());
      final jobs = await _repository.getJobsByDistance(userId);
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }

  Future<void> applyToJob({
    required String jobId,
    required String employeeId,
    required String coverLetter,
  }) async {
    try {
      await _repository.applyToJob(
        jobId: jobId,
        employeeId: employeeId,
        coverLetter: coverLetter,
      );

      // Remove the job from the list if it exists
      if (state is JobLoaded) {
        final currentJobs = (state as JobLoaded).jobs;
        final updatedJobs =
            currentJobs.where((job) => job.id != jobId).toList();
        emit(JobLoaded(updatedJobs));
      }
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
