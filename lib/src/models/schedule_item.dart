import 'package:fitness_time/src/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_item.g.dart';

@JsonSerializable()
class ScheduleItem {
  final int id;
  final int weekDay;
  final int hour;
  final int minutes;
  final int duration;
  UserDto user;

  ScheduleItem({
    this.id,
    this.weekDay,
    this.hour,
    this.minutes,
    this.duration,
    this.user,
  });

  bool get isToday {
    //  return DateUtils.weekDayFromString(this.weekDay) == DateTime.now().weekday;
    return this.weekDay == DateTime.now().weekday;
  }

  factory ScheduleItem.fromJson(Map<String, dynamic> json) =>
      _$ScheduleItemFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleItemToJson(this);
}
