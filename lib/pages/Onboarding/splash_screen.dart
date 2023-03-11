import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';

import 'package:flutter/material.dart';

import '../../logic/state_management/user_store.dart';
import '../home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splashscreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool isLoggedIn = false;
  late bool isAdmin = false;
  late bool isProvider = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // final styleinformation = BigPictureStyleInformation();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await UserStore().refreshTheToken();
      // await UserStore().fetchNearbyUsers();
      // await UserStore().fetchNearbyJourneys();
      // await UserStore().getLocationsByRadius();
      await _getLocation();
      await handleNavigation();
      initMessaging();

      // await UserStore().callApis();
      // await UserStore().queryNews();
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn);
    _animationController.forward();
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => (UserStore().tokenData != null)
              ? const HomeScreen()
              : const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      ),
    );
  }

  handleNavigation() async {
    print(UserStore().tokenData);
  }

  Future _getLocation() async {
    Location location = Location();
    LocationData pos = await location.getLocation();
    final String newLocation = '${pos.latitude},${pos.longitude}';
    UserStore().lat = pos.latitude!;
    UserStore().long = pos.longitude!;
    // await UserStore().sendSOS(lat: pos.latitude!, long: pos.longitude!);
    print(
        "=============================================Current position: $newLocation=============================================");
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void initMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin fltNotification =
        FlutterLocalNotificationsPlugin();
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification.initialize(initSetting);
    var androidDetails = const AndroidNotificationDetails(
      "default",
      "channel name",
      color: Colors.red,
      priority: Priority.high,
      importance: Importance.max,
      // styleInformation: styleinformation,
    );
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    // _firebaseMessaging.requestPermission();
    _firebaseMessaging.subscribeToTopic("sos");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image(
            image: const AssetImage(
              'assets/logo.png',
            ),
            // height: 480,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
      ),
    );
  }
}
