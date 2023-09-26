// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleItem _$ScheduleItemFromJson(Map<String, dynamic> json) {
  return ScheduleItem(
    id: json['id'] as int,
    weekDay: json['weekDay'] as int,
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
    duration: json['duration'] as int,
    user: json['user'] == null
        ? null
        : UserDto.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ScheduleItemToJson(ScheduleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekDay': instance.weekDay,
      'hour': instance.hour,
      'minutes': instance.minutes,
      'duration': instance.duration,
      'user': instance.user,
    };
