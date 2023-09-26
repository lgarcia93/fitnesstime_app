import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';

class Unavailable extends FitnessTimeHttpRequest {
  final String instructorId;

  Unavailable({
    this.instructorId,
  }) : assert(instructorId != null);

  @override
  String get endpoint => 'schedule/instructor/$instructorId/unavailable';
}
