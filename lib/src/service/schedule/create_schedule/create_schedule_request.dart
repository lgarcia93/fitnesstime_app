import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';

class CreateScheduleRequest extends FitnessTimeHttpRequest {
  final String instructorId;

  CreateScheduleRequest({
    this.instructorId,
  }) : assert(instructorId != null);

  @override
  String get endpoint => 'schedule/instructor/$instructorId';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  Map<String, dynamic> get body => {};
}
