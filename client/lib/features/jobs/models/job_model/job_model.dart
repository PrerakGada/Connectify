import 'package:connectify/features/auth/models/user_details_model/user_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'job_model.g.dart';

@JsonSerializable()
class Job with EquatableMixin {
  @JsonKey(name: '_id')
  final String id;
  final String role;
  final String pay;
  final List<String> requiredSkills;
  final String description;
  final String employerId;
  final double latitude;
  final double longitude;
  final List<JobApplication> applications;

  Job({
    required this.id,
    required this.role,
    required this.pay,
    required this.requiredSkills,
    required this.description,
    required this.employerId,
    required this.latitude,
    required this.longitude,
    this.applications = const [],
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  List<Object?> get props => [
        id,
        role,
        pay,
        requiredSkills,
        description,
        employerId,
        latitude,
        longitude,
        applications,
      ];
}

@JsonSerializable()
class JobApplication with EquatableMixin {
  @JsonKey(name: '_id')
  final String id;
  final String jobId;
  final String employeeId;
  final String coverLetter;
  final String status;
  final ApplicantDetails? applicantDetails;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.employeeId,
    required this.coverLetter,
    this.status = 'pending',
    this.applicantDetails,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);
  Map<String, dynamic> toJson() => _$JobApplicationToJson(this);

  @override
  List<Object?> get props => [
        id,
        jobId,
        employeeId,
        coverLetter,
        status,
        applicantDetails,
      ];
}

@JsonSerializable()
class ApplicantDetails with EquatableMixin {
  final String email;
  final String address;
  final String? contactNumber;
  final List<ExperienceModel>? experiences;
  final List<EducationModel>? education;
  final List<String>? skills;
  final String? extraCurriculars;
  final String? achievements;
  final String? portfolioLinks;

  ApplicantDetails({
    required this.email,
    required this.address,
    this.contactNumber,
    this.experiences,
    this.education,
    this.skills,
    this.extraCurriculars,
    this.achievements,
    this.portfolioLinks,
  });

  factory ApplicantDetails.fromJson(Map<String, dynamic> json) =>
      _$ApplicantDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicantDetailsToJson(this);

  @override
  List<Object?> get props => [
        email,
        address,
        contactNumber,
        experiences,
        education,
        skills,
        extraCurriculars,
        achievements,
        portfolioLinks,
      ];
}
