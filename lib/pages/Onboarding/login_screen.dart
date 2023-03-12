import 'package:connectify/pages/Onboarding/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_colors.dart';
import '../../logic/state_management/user_store.dart';
import '../../widgets/LabeledTextFormField.dart';
import 'register_screen.dart';
import 'splash_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final prefs = SharedPreferences.getInstance();

  // final LogInService _logInService = LogInService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // void logInUser() {
  //   _logInService.logIn(
  //     email: _emailController.text,
  //     password: _passwordController.text,
  //     context: context,
  //   );
  // }
  //
  // final NavigationService _navigationService =
  // get_it_instance_const<NavigationService>();

  final UserStore _userStore = UserStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    // height: 300,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyDark),
                      borderRadius: BorderRadius.circular(16),
                      // color: AppColors.grey,
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LabeledTextFormField(
                            controller: _emailController,
                            title: 'Email',
                            hintTitle: 'Enter your username'),
                        const SizedBox(height: 16),
                        LabeledTextFormField(
                            controller: _passwordController,
                            title: 'Password',
                            hintTitle: 'Enter your password'),
                        const SizedBox(height: 24),
                        MaterialButton(
                          color: AppColors.primary,
                          minWidth: 200,
                          padding: const EdgeInsets.all(16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          onPressed: () async {
                            // Navigator.popAndPushNamed(context, HomeScreen.id);
                            final status = await UserStore().logIn(
                                email: _emailController.text,
                                password: _passwordController.text);
                            if (status) {
                              Navigator.popAndPushNamed(context, SplashScreen.id);
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'New here?',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Sign Up!',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.popAndPushNamed(
                                      context, SignupPage.id),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
