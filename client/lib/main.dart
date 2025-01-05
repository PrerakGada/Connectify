import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:connectify/features/auth/cubits/user_details_cubit/user_details_cubit.dart';
import 'package:connectify/features/auth/repositories/auth_repository_impl.dart';
import 'package:connectify/features/auth/repositories/user_details_repository_impl.dart';
import 'package:connectify/features/home/screens/splash_screen.dart';
import 'package:connectify/features/jobs/cubits/job_cubit/job_cubit.dart';
import 'package:connectify/features/jobs/repositories/job_repository_impl.dart';
import 'package:connectify/features/schedule/cubits/interview_cubit/interview_cubit.dart';
import 'package:connectify/features/schedule/repositories/interview_repository_impl.dart';
import 'package:connectify/features/video_call/cubits/video_call_cubit/video_call_cubit.dart';
import 'package:connectify/features/video_call/repositories/video_call_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'core/hive/hive_config.dart';
import 'core/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final apiService = ApiService(httpClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserDetailsCubit(
            UserDetailsRepositoryImpl(apiService),
          )..checkUserDetails(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            AuthRepositoryImpl(apiService),
            context.read<UserDetailsCubit>(),
          )..checkAuthStatus(),
        ),
        BlocProvider(
          create: (context) => JobCubit(
            JobRepositoryImpl(apiService),
          ),
        ),
        BlocProvider(
          create: (context) => InterviewCubit(
            InterviewRepositoryImpl(apiService),
          ),
        ),
        BlocProvider(
          create: (context) => VideoCallCubit(
            VideoCallRepositoryImpl(apiService),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Connectify',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
