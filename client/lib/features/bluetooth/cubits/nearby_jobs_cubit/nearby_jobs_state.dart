part of 'nearby_jobs_cubit.dart';

abstract class NearbyJobsState {}

class NearbyJobsInitial extends NearbyJobsState {}

class NearbyJobsLoading extends NearbyJobsState {}

class NearbyJobsLoaded extends NearbyJobsState {
  final Map<String, List<Job>> deviceJobs;

  NearbyJobsLoaded(this.deviceJobs);
}

class NearbyJobsError extends NearbyJobsState {
  final String message;

  NearbyJobsError(this.message);
}
