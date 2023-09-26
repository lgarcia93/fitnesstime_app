import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';

class ScheduleRequest extends FitnessTimeHttpRequest {
  int dayOfWeek;
  int week;
  int page;
  int size;

  ScheduleRequest({
    this.dayOfWeek = 0,
    this.week = 0,
    this.page = 0,
    this.size = 10,
  });
  @override
  String get endpoint => 'schedule';

  @override
  Map<String, dynamic> get parameters => {
        'dayOfWeek': dayOfWeek,
        'size': size,
        'week': week,
        'page': page,
      };
}
