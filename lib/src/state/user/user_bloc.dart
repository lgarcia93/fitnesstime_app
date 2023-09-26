import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/paged_response.dart';
import 'package:fitness_time/src/service/user/user_service.dart';
import 'package:fitness_time/src/state/fetching_data.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserServiceProtocol userService;

  PageFetchingData<UserDto> instructorsFetchingData =
      PageFetchingData<UserDto>();

  UserBloc({
    this.userService,
  }) : super(InitialUserState());

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchInstructorsEvent) {
      yield* _handleFetchInstructorsEvent(event);
    }

    if (event is ConnectWithInstructorEvent) {
      yield* _handleConnectWithInstructorEvent(event);
    }
  }

  Stream<UserState> _handleFetchInstructorsEvent(
    FetchInstructorsEvent event,
  ) async* {
    try {
      if (event.resetPaging) {
        instructorsFetchingData.reset();
      }

      yield IsFetchingInstructorsState();

      final PagedResponse<UserDto> instructorsPage =
          await userService.fetchInstructors(
        cityCode: event.cityCode,
      );

      instructorsFetchingData.updateData(instructorsPage);

      yield FetchInstructorsSuccessState(
        instructors: instructorsFetchingData.data,
      );
    } on Exception catch (e) {
      yield FetchInstructorsFailedState();
    }
  }

  Stream<UserState> _handleConnectWithInstructorEvent(
      ConnectWithInstructorEvent event) async* {
    try {
      yield IsConnectingWithInstructorState();

      await userService.connectWithInstructor(
        userId: event.userId,
      );

      yield ConnectWithInstructorSuccessState();
    } on Exception catch (e) {
      yield ConnectWithInstructorFailedState();
    }
  }
}
