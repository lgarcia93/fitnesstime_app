import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';

class PendingRequest extends FitnessTimeHttpRequest {
  @override
  String get endpoint => 'schedule/pending';
}
