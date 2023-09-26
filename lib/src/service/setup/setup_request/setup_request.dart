import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';

class SetupRequest extends FitnessTimeHttpRequest {
  @override
  HttpMethod get method => HttpMethod.get;

  @override
  String get endpoint => 'config/setup';

  @override
  bool get authorized => false;
}
