import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoginWithFacebookSuccessState extends AuthState {}

class LoginWithFacebookCanceledByUserState extends AuthState {}

class LoginWithFacebookErrorState extends AuthState {
  final String errorMessage;

  LoginWithFacebookErrorState({
    @required this.errorMessage,
  });
}

class IsSigningInState extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInFailed extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutFailed extends AuthState {}
