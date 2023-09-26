import 'package:fitness_time/src/models/user_dto.dart';
import 'package:meta/meta.dart';

class InstructorDetailScreenArgs {
  final UserDto instructor;

  InstructorDetailScreenArgs({
    @required this.instructor,
  });
}
