import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';

class ConnectRequest extends FitnessTimeHttpRequest {
  final String userId;

  ConnectRequest({
    this.userId,
  }) : assert(userId != null);

  @override
  String get endpoint => 'profile/$userId/connect';

  @override
  HttpMethod get method => HttpMethod.post;
}
