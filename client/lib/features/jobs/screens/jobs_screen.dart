import 'package:auto_route/auto_route.dart';
import 'package:connectify/core/router/app_router.dart';
import 'package:flutter/material.dart';
import '../models/job.dart';

class JobsScreen extends StatelessWidget {
  final bool isEmployee;

  const JobsScreen({
    super.key,
    required this.isEmployee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: isEmployee
            ? null
            : [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context.router.push(const CreateJobRoute());
                  },
                ),
              ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleJobs.length,
        itemBuilder: (context, index) {
          final job = sampleJobs[index];
          return Card(
            child: ListTile(
              title: Text(job.role),
              subtitle: Text(job.pay),
              trailing: isEmployee
                  ? null
                  : Text('${job.applications.length} applications'),
              onTap: () {
                if (isEmployee) {
                  context.router.push(EmployeeJobDetailsRoute(job: job));
                } else {
                  context.router.push(EmployerJobDetailsRoute(job: job));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
