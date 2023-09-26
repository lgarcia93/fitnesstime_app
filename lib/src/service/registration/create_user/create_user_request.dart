import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/base/fitness_time_http_request.dart';
import 'package:fitness_time/src/service/http_method.dart';
import 'package:meta/meta.dart';

class CreateUserRequest extends FitnessTimeHttpRequest {
  final UserDto userDto;

  CreateUserRequest({
    @required this.userDto,
  });

  @override
  String get endpoint => 'auth/register';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  Map<String, dynamic> get body => userDto.toJson();

  @override
  bool get authorized => false;
}
