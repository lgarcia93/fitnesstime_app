import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_time/src/models/schedule.dart';
import 'package:fitness_time/src/models/schedule_item.dart';
import 'package:fitness_time/src/service/schedule/schedule_service.dart';
import 'package:fitness_time/src/state/fetching_data.dart';

import './bloc.dart';

class UserScheduleBloc extends Bloc<UserScheduleEvent, UserScheduleState> {
  final ScheduleServiceProtocol scheduleService;

  PageFetchingData<Schedule> scheduleFetchingData =
      PageFetchingData<Schedule>();

  PageFetchingData<ScheduleItem> scheduleItemsFetchingData =
      PageFetchingData<ScheduleItem>();
  PageFetchingData<Schedule> pendingFetchingData = PageFetchingData<Schedule>();

  UserScheduleBloc({
    this.scheduleService,
  }) : super(InitialScheduleState());

  @override
  UserScheduleState get initialState => InitialScheduleState();

  @override
  Stream<UserScheduleState> mapEventToState(
    UserScheduleEvent event,
  ) async* {
    if (event is FetchSchedules) {
      yield* _handleFetchSchedule(event);
    }

    if (event is FetchPendingScheduleEvent) {
      yield* _handleFetchPendingSchedule(event);
    }

    if (event is AcceptOrRejectScheduleEvent) {
      yield* _handleAcceptOrRejectSchedule(event);
    }
  }

  Stream<UserScheduleState> _handleFetchSchedule(FetchSchedules event) async* {
    try {
      yield IsFetchingSchedulesState();

      if (event.dayOfWeek == 0) {
        final pagedResponse = await scheduleService.fetchSchedules<Schedule>(
          dayOfWeek: 0,
        );

        if (event.cleanData) {
          scheduleFetchingData.reset();
        }

        scheduleFetchingData.updateData(pagedResponse);

        yield FetchWeeklySchedulesSuccessState(
          schedules: scheduleFetchingData.data,
        );
      } else {
        final pagedResponse =
            await scheduleService.fetchSchedules<ScheduleItem>(
          dayOfWeek: event.dayOfWeek,
        );

        if (event.cleanData) {
          scheduleItemsFetchingData.reset();
        }
        scheduleItemsFetchingData.updateData(pagedResponse);

        yield FetchDailySchedulesSuccessState(
          scheduleItems: scheduleItemsFetchingData.data,
        );
      }
    } on Exception catch (e) {
      yield FetchSchedulesFailedState();
    }
  }

  Stream<UserScheduleState> _handleFetchPendingSchedule(
      FetchPendingScheduleEvent event) async* {
    try {
      yield IsFetchingPendingSchedulesState();
//
//      final pagedResponse =
//          await scheduleService.fetchPendingScheduleRequests();

      // final schedules = await scheduleService.fetchPendingScheduleRequests();
      //
      // //   pendingFetchingData.updateData(pagedResponse);
      //
      // print('heeere');
      // yield FetchPendingSchedulesSuccessState(
      //   // schedules: pendingFetchingData.data,
      //   schedules: schedules,
      // );
    } on Exception catch (e) {
      print(e);
      yield FetchPendingScheduleEventsFailedState();
    }
  }

  Stream<UserScheduleState> _handleAcceptOrRejectSchedule(
      AcceptOrRejectScheduleEvent event) async* {
    try {
      yield IsAcceptingOrRejectingScheduleState();

      await scheduleService.acceptOrRejectScheduleRequest(
        scheduleId: event.scheduleId,
        accepted: event.accepted,
      );

      yield AcceptOrRejectScheduleSuccessState();
    } on Exception catch (e) {
      yield AcceptOrRejectScheduleFailedState();
    }
  }
}
