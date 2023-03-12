import 'package:connectify/pages/Onboarding/register_screen.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../logic/state_management/user_store.dart';
import '../../widgets/LabeledTextFormField.dart';
import 'splash_screen.dart';

class SignupPage extends StatefulWidget {
  static const String id = '/signup';

  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Text Editing Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyDark),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LabeledTextFormField(
                          controller: _nameController,
                          title: "Name",
                          hintTitle: "Enter your name"),
                      const SizedBox(height: 18.0),
                      LabeledTextFormField(
                          controller: _emailController,
                          title: "Email",
                          hintTitle: "Enter your Email ID"),
                      const SizedBox(height: 18.0),
                      LabeledTextFormField(
                          controller: _passwordController,
                          title: "Password",
                          hintTitle: "Enter your Password"),
                      const SizedBox(height: 18.0),
                      LabeledTextFormField(
                          controller: _confirmPasswordController,
                          title: "Confirm Password",
                          hintTitle: "Confirm your password"),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool success = await UserStore().register(
                              password1: _passwordController.text,
                              password2: _confirmPasswordController.text,
                              email: _emailController.text,
                              username: _nameController.text,
                              lat: 00.00,
                              lon: 0.0,
                              macId: '123123123',
                            );
                            if (success) {
                              Navigator.pushReplacementNamed(
                                  context, RegisterScreen.id);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: const TextStyle(
                              color: AppColors.black,
                              fontSize: 20,
                            ),
                          ),
                          child: const Text('Register',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
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
    );
  }
}
