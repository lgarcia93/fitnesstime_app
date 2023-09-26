import 'package:meta/meta.dart';

@immutable
abstract class UserScheduleEvent {}

class FetchSchedules extends UserScheduleEvent {
  int dayOfWeek;
  int week;
  int page;
  int size;
  bool cleanData;

  FetchSchedules({
    this.dayOfWeek = 0,
    this.week = 0,
    this.page = 0,
    this.size = 0,
    this.cleanData = false,
  });
}

class FetchPendingScheduleEvent extends UserScheduleEvent {}

class AcceptOrRejectScheduleEvent extends UserScheduleEvent {
  final int scheduleId;
  final bool accepted;

  AcceptOrRejectScheduleEvent({
    this.scheduleId,
    this.accepted,
  });
}
