import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectify/features/auth/models/auth_model/auth_model.dart';
import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';

class HiveConfig {
  // Box names
  static const String userBox = 'userBox';
  static const String userDetailsBox = 'userDetailsBox';

  // Type IDs
  static const int userModelTypeId = 0;
  static const int userDetailsTypeId = 1;
  static const int experienceModelId = 2;
  static const int educationModelId = 3;

  // Initialize Hive and register adapters
  static Future<void> initHive() async {
    await Hive.initFlutter();
    _registerAdapters();
    await openBoxes();
  }

  // Register all Hive adapters
  static void _registerAdapters() {
    Hive.registerAdapter(AuthModelAdapter());
    Hive.registerAdapter(UserDetailsModelAdapter());
    Hive.registerAdapter(ExperienceModelAdapter());
    Hive.registerAdapter(EducationModelAdapter());
  }

  // Open all boxes
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<AuthModel>(userBox),
      Hive.openBox<UserDetailsModel>(userDetailsBox),
    ]);
  }

  // Close all boxes
  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}
