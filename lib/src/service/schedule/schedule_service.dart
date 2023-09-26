import 'package:fitness_time/src/models/schedule.dart';
import 'package:fitness_time/src/models/schedule_item.dart';
import 'package:fitness_time/src/service/base/base_service.dart';
import 'package:fitness_time/src/service/paged_response.dart';
import 'package:fitness_time/src/service/schedule/pending/pending_request.dart';
import 'package:fitness_time/src/service/schedule/schedule/schedule_request.dart';

import 'accept_reject/accept_reject_request.dart';

abstract class ScheduleServiceProtocol {
  Future<PagedResponse> fetchSchedules<T>({
    int dayOfWeek = 0,
    int page = 0,
    int size = 10,
    int week = 0,
  });
  Future<List<Schedule>> fetchPendingScheduleRequests();

  Future<void> acceptOrRejectScheduleRequest({
    int scheduleId,
    bool accepted,
  });
}

class ScheduleService extends BaseService implements ScheduleServiceProtocol {
  @override
  Future<PagedResponse> fetchSchedules<T>({
    int dayOfWeek = 0,
    int page = 0,
    int size = 10,
    int week = 0,
  }) async {
    final request = ScheduleRequest(
      dayOfWeek: dayOfWeek,
      page: page,
      size: size,
      week: week,
    );

    final response = await this.execute(request);

    if (T == Schedule) {
      PagedResponse<Schedule> pagedResponse = PagedResponse.fromJson(
        response.data,
        (e) => Schedule.fromJson(e),
      );

      return pagedResponse;
    }

    if (T == ScheduleItem) {
      PagedResponse<ScheduleItem> pagedResponse = PagedResponse.fromJson(
        response.data,
        (e) => ScheduleItem.fromJson(e),
      );

      return pagedResponse;
    }
  }

  @override
  Future<List<Schedule>> fetchPendingScheduleRequests() async {
    final request = PendingRequest();

    final response = await this.execute(request);

//    PagedResponse<Schedule> pagedResponse = PagedResponse.fromJson(
//      response.data,
//      (e) => Schedule.fromJson(e),
//    );

    final items = List<Schedule>();

    for (var schedule in response.data) {
      items.add(Schedule.fromJson(schedule));
    }

    //  return pagedResponse;
    return items;
  }

  @override
  Future<void> acceptOrRejectScheduleRequest({
    int scheduleId,
    bool accepted,
  }) async {
    final request = AcceptRejectRequest(
      scheduleId: scheduleId,
      accepted: accepted,
    );

    await this.execute(request);
  }
}
