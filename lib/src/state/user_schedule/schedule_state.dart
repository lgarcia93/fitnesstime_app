import 'package:fitness_time/src/models/schedule.dart';
import 'package:fitness_time/src/models/schedule_item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserScheduleState {}

class InitialScheduleState extends UserScheduleState {}

class IsFetchingSchedulesState extends UserScheduleState {}

class FetchWeeklySchedulesSuccessState extends UserScheduleState {
  final List<Schedule> schedules;

  FetchWeeklySchedulesSuccessState({
    this.schedules,
  });
}

class FetchDailySchedulesSuccessState extends UserScheduleState {
  final List<ScheduleItem> scheduleItems;

  FetchDailySchedulesSuccessState({
    this.scheduleItems,
  });
}

class FetchSchedulesFailedState extends UserScheduleState {}

class IsFetchingPendingSchedulesState extends UserScheduleState {}

class FetchPendingSchedulesSuccessState extends UserScheduleState {
  final List<Schedule> schedules;

  FetchPendingSchedulesSuccessState({
    this.schedules,
  });
}

class FetchPendingScheduleEventsFailedState extends UserScheduleState {}

class IsAcceptingOrRejectingScheduleState extends UserScheduleState {}

class AcceptOrRejectScheduleSuccessState extends UserScheduleState {}

class AcceptOrRejectScheduleFailedState extends UserScheduleState {}
