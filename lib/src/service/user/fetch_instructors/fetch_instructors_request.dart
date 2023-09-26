import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:meta/meta.dart';

class FetchInstructorsRequest extends FitnessTimeHttpRequest {
  final String cityCode;

  FetchInstructorsRequest({
    @required this.cityCode,
  });

  @override
  String get endpoint => 'user/$cityCode/instructors';
}
