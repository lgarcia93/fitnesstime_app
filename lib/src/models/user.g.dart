// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    firebaseId: json['firebaseId'] as String,
    firstName: json['firstName'] as String,
    cityCode: json['cityCode'] as String,
    lastName: json['lastName'] as String,
    isInstructor: json['isInstructor'] as bool,
    photoUrl: json['photoUrl'] as String,
    skills: (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firebaseId': instance.firebaseId,
      'firstName': instance.firstName,
      'cityCode': instance.cityCode,
      'photoUrl': instance.photoUrl,
      'lastName': instance.lastName,
      'isInstructor': instance.isInstructor,
      'skills': instance.skills,
    };
