import 'package:connectify/features/auth/models/user_model/user_model.dart';

abstract class AuthRepository {
  final String baseUrl = 'http://localhost:5000/api/auth';

  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
}
