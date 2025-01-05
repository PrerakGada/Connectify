import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_model.g.dart';

@JsonSerializable()
class InterviewModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String employeeId;
  final String employerId;
  final DateTime startTime;
  final String otherPartyName;
  final DateTime endTime;

  const InterviewModel({
    required this.id,
    required this.employeeId,
    required this.employerId,
    required this.startTime,
    required this.endTime,
    required this.otherPartyName,
  });

  factory InterviewModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employerId,
        startTime,
        endTime,
        otherPartyName,
      ];
}
