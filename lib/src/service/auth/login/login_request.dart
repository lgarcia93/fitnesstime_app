import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';
import 'package:meta/meta.dart';

class LoginRequest extends FitnessTimeHttpRequest {
  final String userName;
  final String password;
  final String fcmToken;

  LoginRequest({
    @required this.userName,
    @required this.password,
    @required this.fcmToken,
  });

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  String get endpoint => 'user/login';

  @override
  bool get authorized => false;

  @override
  Map<String, dynamic> get headers => {
        'email': userName,
        'password': password,
        'fcmToken': fcmToken,
      };
}
