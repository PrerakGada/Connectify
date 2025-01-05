import 'package:connectify/features/schedule/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectify/features/jobs/models/job_model/job_model.dart';

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
            ...job.applications.map((application) {
              return Card(
                child: ListTile(
                  title: Text(application.applicantDetails?.email ?? ''),
                  onTap: () {
                    _showApplicationDetails(context, application);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
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
                  const Text(
                    'Applicant Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Email', application.applicantDetails?.email),
                  _buildInfoRow(
                      'Address', application.applicantDetails?.address),
                  _buildInfoRow('Contact Number',
                      application.applicantDetails?.contactNumber),
                  if (application.applicantDetails?.skills != null &&
                      application.applicantDetails!.skills!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Skills',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: application.applicantDetails!.skills!
                          .map((skill) => Chip(label: Text(skill)))
                          .toList(),
                    ),
                  ],
                  if (application.applicantDetails?.experiences != null &&
                      application
                          .applicantDetails!.experiences!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Experience',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...application.applicantDetails!.experiences!.map(
                      (exp) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${exp.role} at ${exp.company}'),
                            Text('${exp.duration} - ${exp.location}'),
                            Text(exp.description),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (application.applicantDetails?.education != null &&
                      application.applicantDetails!.education!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Education',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...application.applicantDetails!.education!.map(
                      (edu) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${edu.type}${edu.courseName != null ? ' in ${edu.courseName}' : ''}'),
                            Text('${edu.instituteName} - ${edu.duration}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Text(
                    'Cover Letter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(application.coverLetter),
                  if (application.applicantDetails?.extraCurriculars !=
                      null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Extra Curricular Activities',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(application.applicantDetails!.extraCurriculars!),
                  ],
                  if (application.applicantDetails?.achievements != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Achievements',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(application.applicantDetails!.achievements!),
                  ],
                  if (application.applicantDetails?.portfolioLinks != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Portfolio Links',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(application.applicantDetails!.portfolioLinks!),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CalendarScreen(
                              isEmployee: false,
                              jobId: job.id,
                              applicantId: application.employeeId,
                            ),
                          ),
                        );
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

  Widget _buildInfoRow(String label, String? value) {
    if (value == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
