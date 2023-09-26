// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    id: json['id'] as int,
    user: json['user'] == null
        ? null
        : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    scheduleItems: (json['scheduleItems'] as List)
        ?.map((e) =>
            e == null ? null : ScheduleItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    accepted: json['accepted'] as bool,
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'scheduleItems': instance.scheduleItems,
      'accepted': instance.accepted,
      'updated': instance.updated?.toIso8601String(),
    };
