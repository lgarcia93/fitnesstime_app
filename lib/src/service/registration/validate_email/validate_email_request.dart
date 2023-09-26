import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';
import 'package:meta/meta.dart';

class ValidateEmailRequest extends FitnessTimeHttpRequest {
  final String email;

  ValidateEmailRequest({
    @required this.email,
  });

  @override
  String get endpoint => 'auth/validate';

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  Map<String, dynamic> get parameters => {
        'email': email,
      };

  @override
  bool get authorized => false;
}
