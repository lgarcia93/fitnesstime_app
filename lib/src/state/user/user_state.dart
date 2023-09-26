import 'package:fitness_time/src/models/user_dto.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState {}

class InitialUserState extends UserState {}

class IsFetchingInstructorsState extends UserState {}

class FetchInstructorsSuccessState extends UserState {
  final List<UserDto> instructors;

  FetchInstructorsSuccessState({
    @required this.instructors,
  });
}

class FetchInstructorsFailedState extends UserState {}

class IsConnectingWithInstructorState extends UserState {}

class ConnectWithInstructorSuccessState extends UserState {}

class ConnectWithInstructorFailedState extends UserState {}
