import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class ResetBlocEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    this.email,
    this.password,
  });
}

class SignOutEvent extends AuthEvent {}

class LoginWithFacebookEvent extends AuthEvent {}
