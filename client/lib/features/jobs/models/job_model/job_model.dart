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

  Job({
    required this.id,
    required this.role,
    required this.pay,
    required this.requiredSkills,
    required this.description,
    required this.employerId,
    required this.latitude,
    required this.longitude,
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
        longitude
      ];
}

class JobApplication {
  final String id;
  final String applicantId;
  final String applicantName;
  final String applicantEmail;
  final String coverLetter;
  final String status; // 'pending', 'interviewed', 'rejected', 'accepted'

  JobApplication({
    required this.id,
    required this.applicantId,
    required this.applicantName,
    required this.applicantEmail,
    required this.coverLetter,
    this.status = 'pending',
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['_id'],
      applicantId: json['applicantId'],
      applicantName: json['applicantName'],
      applicantEmail: json['applicantEmail'],
      coverLetter: json['coverLetter'],
      status: json['status'],
    );
  }
}
