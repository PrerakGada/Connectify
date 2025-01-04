import 'package:connectify/features/auth/models/user_model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/auth/models/auth_model/auth_model.dart';
import 'package:connectify/features/auth/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectify/core/hive/hive_config.dart';
import 'package:connectify/features/auth/cubits/user_details_cubit/user_details_cubit.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  late final Box<AuthModel> _userBox;
  final UserDetailsCubit _userDetailsCubit;

  AuthCubit(this._authRepository, this._userDetailsCubit)
      : super(AuthInitial()) {
    _userBox = Hive.box<AuthModel>(HiveConfig.userBox);
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      UserModel user = await _authRepository.login(email, password);
      await _userBox.put(0, user.auth);
      _userDetailsCubit.updateUserDetails(user.userDetails);
      emit(AuthAuthenticated(user.auth));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      AuthModel auth = await _authRepository.signup(name, email, password);
      await _userBox.put(0, auth);
      emit(AuthAuthenticated(auth));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      AuthModel? auth = _userBox.get(0);
      if (auth != null) {
        emit(AuthAuthenticated(auth));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _userBox.delete(0);
    emit(AuthUnauthenticated());
  }
}
