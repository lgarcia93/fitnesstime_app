import 'dart:io';

import 'package:fitness_time/src/enums/user_type.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationEvent {}

class SetUserDtoEvent extends RegistrationEvent {
  final UserDto userDto;

  SetUserDtoEvent({
    @required this.userDto,
  });
}

class SetChoosenNameEvent extends RegistrationEvent {
  final String name;

  SetChoosenNameEvent({
    @required this.name,
  });
}

class SetUserTypeEvent extends RegistrationEvent {
  final UserType userType;

  SetUserTypeEvent({
    @required this.userType,
  });
}

class SetUserCityEvent extends RegistrationEvent {
  final String city;

  SetUserCityEvent({
    @required this.city,
  });
}

class SetUserSkillsEvent extends RegistrationEvent {
  final List<Skill> skills;

  SetUserSkillsEvent({
    @required this.skills,
  });
}

class FinishRegistrationEvent extends RegistrationEvent {}

class SetUserFileImageEvent extends RegistrationEvent {
  final File fileImage;

  SetUserFileImageEvent({
    this.fileImage,
  });
}

class ValidateEmailEvent extends RegistrationEvent {
  final String email;

  ValidateEmailEvent({
    this.email,
  });
}
