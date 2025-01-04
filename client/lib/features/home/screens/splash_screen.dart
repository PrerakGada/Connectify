import 'package:connectify/features/auth/cubits/auth_cubit.dart';
import 'package:connectify/features/auth/screens/login_screen.dart';
import 'package:connectify/features/auth/screens/role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const RoleSelectionScreen(),
          ));
        } else if (state is AuthUnauthenticated) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
