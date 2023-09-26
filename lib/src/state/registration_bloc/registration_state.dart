import 'package:meta/meta.dart';

@immutable
abstract class RegistrationState {}

class InitialRegistrationState extends RegistrationState {}

class IsValidatingEmailState extends RegistrationState {}

class ValidateEmailSuccess extends RegistrationState {}

class ValidateEmailFailed extends RegistrationState {}

class IsProcessingRegistrationState extends RegistrationState {}

class FinishRegistrationSuccessState extends RegistrationState {}

class FinishRegistrationFailedState extends RegistrationState {}
