import 'package:fitness_time/src/models/schedule_item.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  final int id;
  final UserDto user;

  final List<ScheduleItem> scheduleItems;
  final bool accepted;
  final DateTime updated;

  Schedule({
    this.id,
    this.user,
    this.scheduleItems,
    this.accepted,
    this.updated,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
