import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/base/base_service.dart';
import 'package:fitness_time/src/service/registration/create_user/create_user_request.dart';
import 'package:fitness_time/src/service/registration/validate_email/validate_email_request.dart';
import 'package:meta/meta.dart';

abstract class RegistrationServiceProtocol {
  Future<void> registerUser({
    @required UserDto userDto,
  });

  Future<void> validateEmail({@required String email});
}

class RegistrationService extends BaseService
    implements RegistrationServiceProtocol {
  Future<void> registerUser({
    @required UserDto userDto,
  }) async {
    final request = CreateUserRequest(
      userDto: userDto,
    );

    var result = await this.execute(request);
  }

  @override
  Future<void> validateEmail({
    @required String email,
  }) async {
    final request = ValidateEmailRequest(
      email: email,
    );

    return this.execute(request);
  }
}
