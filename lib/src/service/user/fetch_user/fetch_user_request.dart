import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';

class FetchUserRequest extends FitnessTimeHttpRequest {
  @override
  String get endpoint => 'profile/myself';

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  bool get authorized => true;
}
