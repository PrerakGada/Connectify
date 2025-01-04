import 'package:connectify/features/auth/models/auth_model/auth_model.dart';
import 'package:connectify/features/auth/models/user_model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<AuthModel> signup(String name, String email, String password);
}
