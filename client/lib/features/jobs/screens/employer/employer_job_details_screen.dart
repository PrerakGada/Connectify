import 'package:connectify/features/schedule/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import '../../models/job_model/job_model.dart';

class EmployerJobDetailsScreen extends StatelessWidget {
  final Job job;

  const EmployerJobDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.role),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.role,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Pay: ${job.pay}'),
                    const SizedBox(height: 8),
                    const Text('Required Skills:'),
                    Wrap(
                      spacing: 8.0,
                      children: job.requiredSkills.map((skill) {
                        return Chip(label: Text(skill));
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Text('Description: ${job.description}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Applications List
            const Text(
              'Applications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // ...job.applications.map((application) {
            //   return Card(
            //     child: ListTile(
            //       title: Text(application.applicantName),
            //       subtitle: Text(application.applicantEmail),
            //       trailing: Chip(
            //         label: Text(application.status),
            //         backgroundColor: _getStatusColor(application.status),
            //       ),
            //       onTap: () {
            //         _showApplicationDetails(context, application);
            //       },
            //     ),
            //   );
            // }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'interviewed':
        return Colors.blue;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showApplicationDetails(
      BuildContext context, JobApplication application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    application.applicantName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('Email: ${application.applicantEmail}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Cover Letter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(application.coverLetter),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CalendarScreen(
                            isEmployee: false,
                            jobId: job.id,
                            applicantId: application.id,
                          ),
                        ));
                      },
                      child: const Text('Schedule Interview'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
