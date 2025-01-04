import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';
import 'package:connectify/features/auth/repositories/user_details_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectify/core/hive/hive_config.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final UserDetailsRepository _userDetailsRepository;
  late final Box<UserDetailsModel> _userDetailsBox;

  UserDetailsCubit(this._userDetailsRepository) : super(UserDetailsInitial()) {
    _userDetailsBox = Hive.box<UserDetailsModel>(HiveConfig.userDetailsBox);
  }

  Future<void> postUserDetails(UserDetailsModel userDetails) async {
    emit(UserDetailsLoading());
    try {
      final updatedUserDetails =
          await _userDetailsRepository.updateUserDetails(userDetails);
      await _userDetailsBox.put(0, updatedUserDetails);
      emit(UserDetailsLoaded(updatedUserDetails));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }

  Future<void> updateUserDetails(UserDetailsModel? userDetails) async {
    emit(UserDetailsLoading());
    try {
      if (userDetails != null) {
        await _userDetailsBox.put(0, userDetails);
        emit(UserDetailsLoaded(userDetails));
      } else {
        emit(UserDetailsNotLoaded());
      }
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }

  Future<void> checkUserDetails() async {
    emit(UserDetailsLoading());
    try {
      UserDetailsModel? userDetails = _userDetailsBox.get(0);
      if (userDetails != null) {
        emit(UserDetailsLoaded(userDetails));
      } else {
        emit(UserDetailsNotLoaded());
      }
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }

  Future<void> clearUserDetails() async {
    await _userDetailsBox.delete(0);
    emit(UserDetailsNotLoaded());
  }

  Future<void> getUserDetails() async {
    emit(UserDetailsLoading());
    try {
      final userDetails = await _userDetailsRepository.getUserDetails();
      await _userDetailsBox.put(0, userDetails);
      emit(UserDetailsLoaded(userDetails));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }
}
