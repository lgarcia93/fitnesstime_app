import 'package:fitness_time/src/service/auth/login/login_request.dart';
import 'package:fitness_time/src/service/base/base_service.dart';
import 'package:fitness_time/src/shared_prefs/shared_prefs.dart';

abstract class AuthServiceProtocol {
  Future<void> signIn({
    String userName,
    String password,
    String fcmToken,
  });
}

class AuthService extends BaseService implements AuthServiceProtocol {
  @override
  Future<void> signIn({
    String userName,
    String password,
    String fcmToken,
  }) async {
    final request = LoginRequest(
      userName: userName,
      password: password,
      fcmToken: fcmToken,
    );

    final response = await this.execute(request);

    final String authorization = response.headers.value('Authorization');

    SharedPrefsUtils.setString(
      SharedPrefsUtils.AuthorizationHeader,
      authorization,
    );

    SharedPrefsUtils.setString(
      SharedPrefsUtils.userName,
      userName,
    );

    SharedPrefsUtils.setString(
      SharedPrefsUtils.password,
      password,
    );
  }
}
