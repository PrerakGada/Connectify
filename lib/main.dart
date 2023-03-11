import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/Chat/ChatScreen.dart';
import 'pages/Onboarding/login_screen.dart';
import 'pages/Onboarding/onboarding_screen.dart';
import 'pages/Onboarding/register_screen.dart';
import 'pages/Onboarding/splash_screen.dart';
import 'pages/Profile/edit_profile.dart';
import 'pages/Profile/profile_page.dart';
import 'pages/Settings/settings.dart';
import 'pages/home_screen.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'firebase_options.dart';
import 'logic/state_management/user_store.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // final db = FirebaseFirestore.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserStore>(
          create: (_) => UserStore(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        theme: light_theme(),
        darkTheme: dark_theme(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          EditProfile.id: (context) => const EditProfile(),
          Settings.id: (context) => const Settings(),
          // LocationScreen.id: (context) => const LocationScreen(),
          ChatScreen.id: (context) => const ChatScreen(),
        },
      ),
    );
  }
}
