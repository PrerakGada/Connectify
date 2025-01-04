import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectify/features/auth/models/user_model/user_model.dart';

class HiveConfig {
  // Box names
  static const String userBox = 'userBox';

  // Type IDs
  static const int userModelTypeId = 0;

  // Initialize Hive and register adapters
  static Future<void> initHive() async {
    await Hive.initFlutter();
    _registerAdapters();
    await openBoxes();
  }

  // Register all Hive adapters
  static void _registerAdapters() {
    Hive.registerAdapter(UserModelAdapter());
  }

  // Open all boxes
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<UserModel>(userBox),
    ]);
  }

  // Close all boxes
  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}
