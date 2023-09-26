// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetupResponse _$SetupResponseFromJson(Map<String, dynamic> json) {
  return SetupResponse(
    cities: (json['cities'] as List)
        ?.map(
            (e) => e == null ? null : City.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    skills: (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SetupResponseToJson(SetupResponse instance) =>
    <String, dynamic>{
      'cities': instance.cities,
      'skills': instance.skills,
    };
