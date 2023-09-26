import 'dart:convert';

import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/base/base_service.dart';
import 'package:fitness_time/src/service/paged_response.dart';
import 'package:fitness_time/src/service/user/connect/connect_request.dart';
import 'package:fitness_time/src/service/user/fetch_instructors/fetch_instructors_request.dart';
import 'package:fitness_time/src/service/user/fetch_user/fetch_user_request.dart';
import 'package:fitness_time/src/shared_prefs/shared_prefs.dart';
import 'package:meta/meta.dart';

abstract class UserServiceProtocol {
  Future<UserDto> fetchCurrentUser();
  Future<PagedResponse<UserDto>> fetchInstructors({
    String cityCode,
  });
  Future<void> connectWithInstructor({
    @required String userId,
  });
}

class UserService extends BaseService implements UserServiceProtocol {
  @override
  Future<UserDto> fetchCurrentUser() async {
    final request = FetchUserRequest();

    final response = await this.execute(request);

    final user = UserDto.fromJson(
      response.data,
    );

    SharedPrefsUtils.setString(
      SharedPrefsUtils.userProfileJson,
      jsonEncode(
        user.toJson(),
      ),
    );

    return user;
  }

  @override
  Future<PagedResponse<UserDto>> fetchInstructors({
    @required String cityCode,
  }) async {
    final request = FetchInstructorsRequest(
      cityCode: cityCode,
    );

    final response = await this.execute(request);

    final PagedResponse<UserDto> pagedResponse = PagedResponse.fromJson(
      response.data,
      (e) => UserDto.fromJson(e),
    );

    return pagedResponse;
  }

  @override
  Future<void> connectWithInstructor({
    @required String userId,
  }) async {
    final request = ConnectRequest(
      userId: userId,
    );

    await this.execute(request);
  }
}
