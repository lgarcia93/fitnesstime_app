import 'package:fitness_time/src/enums/week_day.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  Appointment({
    this.weekDay,
    this.time,
  });

  final WeekDay weekDay;
  @JsonKey(
    fromJson: _timeOfDayFromJson,
    toJson: _timeOfDayToJson,
  )
  final TimeOfDay time;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}

TimeOfDay _timeOfDayFromJson(Map<String, dynamic> json) =>
    TimeOfDay(hour: json['hour'], minute: json['minute']);

Map<String, dynamic> _timeOfDayToJson(TimeOfDay timeOfDay) => {
      'hour': timeOfDay.hour,
      'minute': timeOfDay.minute,
    };
