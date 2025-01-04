import 'package:connectify/core/hive/hive_config.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_details_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConfig.userDetailsTypeId)
class UserDetailsModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final bool isEmployee;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final double latitude;

  @HiveField(5)
  final double longitude;

  @HiveField(6)
  final String address;

  @HiveField(7)
  final String? imageLink;

  // Employee specific fields
  @HiveField(8)
  final String? contactNumber;

  @HiveField(9)
  final List<ExperienceModel>? experiences;

  @HiveField(10)
  final List<EducationModel>? educations;

  @HiveField(11)
  final List<String>? skills;

  @HiveField(12)
  final List<String>? desiredRoles;

  @HiveField(13)
  final String? extraCurriculars;

  @HiveField(14)
  final String? achievements;

  @HiveField(15)
  final String? portfolioLinks;

  // Employer specific fields
  @HiveField(16)
  final String? companyName;

  UserDetailsModel({
    required this.userId,
    required this.isEmployee,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.imageLink,
    this.contactNumber,
    this.experiences,
    this.educations,
    this.skills,
    this.desiredRoles,
    this.extraCurriculars,
    this.achievements,
    this.portfolioLinks,
    this.companyName,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsModelToJson(this);

  @override
  List<Object?> get props => [
        userId,
        isEmployee,
        email,
        latitude,
        longitude,
        address,
        imageLink,
        contactNumber,
        experiences,
        educations,
        skills,
        desiredRoles,
        extraCurriculars,
        achievements,
        portfolioLinks,
        companyName
      ];
}

@JsonSerializable()
@HiveType(typeId: HiveConfig.experienceModelId)
class ExperienceModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String role;

  @HiveField(1)
  final String company;

  @HiveField(2)
  final String duration;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String description;

  ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);

  @override
  List<Object?> get props => [role, company, duration, location, description];
}

@JsonSerializable()
@HiveType(typeId: HiveConfig.educationModelId)
class EducationModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String instituteName;

  @HiveField(1)
  final String duration;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String? courseName;

  EducationModel({
    required this.instituteName,
    required this.duration,
    required this.type,
    this.courseName,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);

  @override
  List<Object?> get props => [instituteName, duration, type, courseName];
}
