import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectify/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:connectify/features/auth/cubits/user_details_cubit/user_details_cubit.dart';
import 'package:connectify/features/auth/screens/role_selection_screen.dart';
import 'package:connectify/features/auth/screens/signup_screen.dart';
import 'package:connectify/features/home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() {
    Future.delayed(Duration.zero, () {
      if (!mounted) return;

      final authCubit = context.read<AuthCubit>();
      final userDetailsCubit = context.read<UserDetailsCubit>();

      if (authCubit.state is AuthUnauthenticated) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          ),
          (route) => false,
        );
      } else if (userDetailsCubit.state is UserDetailsNotLoaded) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const RoleSelectionScreen(),
          ),
          (route) => false,
        );
      } else if (authCubit.state is AuthAuthenticated &&
          userDetailsCubit.state is UserDetailsLoaded) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
                isEmployee: (userDetailsCubit.state as UserDetailsLoaded)
                    .userDetails
                    .isEmployee),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
