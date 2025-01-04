import 'package:connectify/features/auth/models/auth_model/auth_model.dart';
import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';

class UserModel {
  final AuthModel auth;
  final UserDetailsModel? userDetails;

  UserModel({
    required this.auth,
    this.userDetails,
  });
}
