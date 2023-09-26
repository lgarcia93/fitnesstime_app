import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';

import '../../http_method.dart';

class AcceptRejectRequest extends FitnessTimeHttpRequest {
  final int scheduleId;
  final bool accepted;

  AcceptRejectRequest({
    this.scheduleId,
    this.accepted,
  });

  @override
  String get endpoint => 'schedule/pending/$scheduleId';

  @override
  HttpMethod get method => HttpMethod.put;

  @override
  Map<String, dynamic> get parameters => {
        'accept': accepted,
      };
}
