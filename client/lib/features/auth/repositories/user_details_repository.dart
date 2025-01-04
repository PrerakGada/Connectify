import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';

abstract class UserDetailsRepository {
  Future<UserDetailsModel> getUserDetails();
  Future<UserDetailsModel> updateUserDetails(UserDetailsModel userDetails);
}
