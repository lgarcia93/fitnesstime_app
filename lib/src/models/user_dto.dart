import 'package:fitness_time/src/models/skill.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'city.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  int id;
  String username;
  String password;
  String firstName;
  String lastName;
  String description;
  String profilePicture;
  City city;
  bool isInstructor;
  List<Skill> skills;
  bool isConnection;

  UserDto({
    @required this.id,
    @required this.username,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
    @required this.description,
    @required this.profilePicture,
    @required this.city,
    @required this.isInstructor,
    @required this.skills,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  String get completeName {
    return '${this.firstName} ${this.lastName}';
  }
}
