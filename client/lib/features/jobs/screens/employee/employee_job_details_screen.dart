import 'package:flutter/material.dart';
import '../../models/job_model/job_model.dart';

class EmployeeJobDetailsScreen extends StatefulWidget {
  final Job job;

  const EmployeeJobDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  State<EmployeeJobDetailsScreen> createState() =>
      _EmployeeJobDetailsScreenState();
}

class _EmployeeJobDetailsScreenState extends State<EmployeeJobDetailsScreen> {
  final _coverLetterController = TextEditingController();

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.role),
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
                      widget.job.role,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Pay: ${widget.job.pay}'),
                    const SizedBox(height: 8),
                    const Text('Required Skills:'),
                    Wrap(
                      spacing: 8.0,
                      children: widget.job.requiredSkills.map((skill) {
                        return Chip(label: Text(skill));
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Text('Description: ${widget.job.description}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Application Form
            const Text(
              'Apply for this Position',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _coverLetterController,
              decoration: const InputDecoration(
                labelText: 'Cover Letter',
                hintText: 'Explain why you are a good fit for this position...',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement job application submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application submitted successfully!'),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Submit Application'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
