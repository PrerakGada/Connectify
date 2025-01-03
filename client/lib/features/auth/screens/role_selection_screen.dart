import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:connectify/core/router/app_router.dart';

@RoutePage()
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What brings you to Connectify?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.router.push(const EmployeeInfoRoute());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('I\'m looking for a job'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.router.push(const EmployerInfoRoute());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('I want to hire people'),
            ),
          ],
        ),
      ),
    );
  }
}
