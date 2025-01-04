import '../../../core/constants/job_constants.dart';

class Job {
  final String id;
  final String role;
  final String pay;
  final List<String> requiredSkills;
  final String description;
  final List<JobApplication> applications;

  Job({
    required this.id,
    required this.role,
    required this.pay,
    required this.requiredSkills,
    required this.description,
    this.applications = const [],
  });
}

class JobApplication {
  final String id;
  final String applicantName;
  final String applicantEmail;
  final String coverLetter;
  final String status; // 'pending', 'interviewed', 'rejected', 'accepted'

  JobApplication({
    required this.id,
    required this.applicantName,
    required this.applicantEmail,
    required this.coverLetter,
    this.status = 'pending',
  });
}

// Sample data for testing
final List<Job> sampleJobs = [
  Job(
    id: '1',
    role: JobConstants.possibleRoles[0],
    pay: '\$80,000 - \$100,000',
    requiredSkills: [
      JobConstants.technicalSkills[0],
      JobConstants.technicalSkills[1],
      JobConstants.technicalSkills[2],
    ],
    description: 'We are looking for a Software Engineer to join our team...',
    applications: [
      JobApplication(
        id: '1',
        applicantName: 'John Doe',
        applicantEmail: 'john@example.com',
        coverLetter: 'I am excited to apply for this position...',
      ),
    ],
  ),
  Job(
    id: '2',
    role: JobConstants.possibleRoles[1],
    pay: '\$70,000 - \$90,000',
    requiredSkills: [
      JobConstants.technicalSkills[8],
      JobConstants.technicalSkills[9],
    ],
    description: 'Join our frontend team to build amazing user experiences...',
  ),
];
