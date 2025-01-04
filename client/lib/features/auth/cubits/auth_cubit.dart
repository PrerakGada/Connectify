import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/auth/models/user_model/user_model.dart';
import 'package:connectify/features/auth/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectify/core/hive/hive_config.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  late final Box<UserModel> _userBox;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    _userBox = Hive.box<UserModel>(HiveConfig.userBox);
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(email, password);
      await _userBox.put(0, user);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signup(name, email, password);
      await _userBox.put(0, user);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      UserModel? user = _userBox.get(0);
      if (user != null) {
        emit(AuthAuthenticated(user));
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
