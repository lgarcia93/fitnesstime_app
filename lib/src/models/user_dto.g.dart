// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return UserDto(
    id: json['id'] as int,
    username: json['username'] as String,
    password: json['password'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    description: json['description'] as String,
    profilePicture: json['profilePicture'] as String,
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    isInstructor: json['isInstructor'] as bool,
    skills: (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..isConnection = json['isConnection'] as bool;
}

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'description': instance.description,
      'profilePicture': instance.profilePicture,
      'city': instance.city,
      'isInstructor': instance.isInstructor,
      'skills': instance.skills,
      'isConnection': instance.isConnection,
    };
