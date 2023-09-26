import 'package:fitness_time/src/models/skill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String firebaseId;
  final String firstName;
  final String cityCode;
  final String photoUrl;
  final String lastName;
  final bool isInstructor;
  final List<Skill> skills;

  User({
    this.id,
    this.firebaseId,
    this.firstName,
    this.cityCode,
    this.lastName,
    this.isInstructor,
    this.photoUrl,
    this.skills,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
