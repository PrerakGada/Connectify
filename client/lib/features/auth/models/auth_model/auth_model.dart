import 'package:connectify/core/hive/hive_config.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConfig.userModelTypeId)
class AuthModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String token;

  AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  @override
  List<Object?> get props => [id, name, email, token];
}
