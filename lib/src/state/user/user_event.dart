import 'package:meta/meta.dart';

@immutable
abstract class UserEvent {}

class FetchInstructorsEvent extends UserEvent {
  final String cityCode;
  final bool resetPaging;

  FetchInstructorsEvent({
    @required this.cityCode,
    this.resetPaging = true,
  });
}

class ConnectWithInstructorEvent extends UserEvent {
  final String userId;

  ConnectWithInstructorEvent({
    this.userId,
  });
}
