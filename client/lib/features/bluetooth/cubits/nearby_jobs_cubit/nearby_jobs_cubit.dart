import 'package:connectify/features/bluetooth/repositories/nearby_jobs_repository.dart';
import 'package:connectify/features/jobs/models/job_model/job_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'nearby_jobs_state.dart';

class NearbyJobsCubit extends Cubit<NearbyJobsState> {
  final NearbyJobsRepository _repository;
  Map<String, List<Job>> _deviceJobs = {};

  NearbyJobsCubit(this._repository) : super(NearbyJobsInitial());

  Future<void> fetchNearbyJobs(String employerId) async {
    emit(NearbyJobsLoading());
    try {
      final jobs = await _repository.fetchNearbyJobs(employerId);
      _deviceJobs[employerId] = jobs;
      emit(NearbyJobsLoaded(_deviceJobs));
    } catch (e) {
      emit(NearbyJobsError(e.toString()));
    }
  }
}
