import 'package:connectify/pages/AudioVideo/audio_recording_page.dart';
import 'package:connectify/pages/AudioVideo/video_recording_page.dart';
import 'package:connectify/pages/Onboarding/signup_page.dart';
import 'package:connectify/pages/Profile/profile_screen.dart';
import 'package:connectify/pages/Profile/profile_view.dart';
import 'package:connectify/pages/Search/search.dart';
import 'package:connectify/pages/ats/ats.dart';
import 'package:connectify/pages/calendar/calendar_view.dart';
import 'package:connectify/pages/createCompany/create_company.dart';
import 'package:connectify/pages/createJob/create_job.dart';
import 'package:connectify/pages/employeeDashBoard/employee_dashboard.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/Chat/ChatScreen.dart';
import 'pages/Onboarding/login_screen.dart';
import 'pages/Onboarding/onboarding_screen.dart';
import 'pages/Onboarding/register_screen.dart';
import 'pages/Onboarding/splash_screen.dart';
// import 'pages/Profile/edit_profile.dart';
import 'pages/Profile/profile_page.dart';
import 'pages/Settings/settings.dart';
import 'pages/bluetooth.dart';
import 'pages/home_screen.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'firebase_options.dart';
import 'logic/state_management/user_store.dart';
import 'theme/dark_theme.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<void> requestCameraPermission() async {
    await Permission.bluetoothAdvertise.isGranted;
    await Permission.bluetooth.isGranted;
    await Permission.bluetoothConnect.isGranted;
    await Permission.bluetoothScan.isGranted;
  }

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
        // home: ShiftScheduler(),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          SignupPage.id: (context) => const SignupPage(),
          Profile.id: (context) => const Profile(),
          // EditProfile.id: (context) => const EditProfile(),
          Settings.id: (context) => const Settings(),
          // LocationScreen.id: (context) => const LocationScreen(),
          ChatScreen.id: (context) => const ChatScreen(),
          // Bluetooth.id: (context) => Bluetooth(),
          CreateBusinessScreen.id: (context) => const CreateBusinessScreen(),
          EmployeeDashBoard.id: (context) => const EmployeeDashBoard(),
          AtsView.id: (context) => const AtsView(),
          CreateJob.id: (context) => const CreateJob(),
          // VideoRecordingPage.id: (context) => VideoRecordingPage(),
          Bluetooth.id: (context) => Bluetooth(),
          CreateBusinessScreen.id: (context) => CreateBusinessScreen(),
          EmployeeDashBoard.id: (context) => EmployeeDashBoard(),
          AtsView.id: (context) => AtsView(),
          CreateJob.id: (context) => CreateJob(),
          // VideoRecordingPage.id: (context) => VideoRecordingPage(),
          AudioRecordingPage.id: (context) => AudioRecordingPage(),
          SearchScreen.id: (context) => SearchScreen(),
          ProfileView.id: (context) => ProfileView(),
          ShiftScheduler.id: (context) => ShiftScheduler(),
          // CompanyDetails.id:(context) => CompanyDetails(details: ,)
        },
      ),
    );
  }
}
