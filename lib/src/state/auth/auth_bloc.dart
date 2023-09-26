import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/service/auth/auth_service.dart';
import 'package:fitness_time/src/service/user/user_service.dart';
import 'package:fitness_time/src/shared_prefs/shared_prefs.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _facebookLogin = FacebookLogin();

  FirebaseUser firebaseUser;
  UserDto user;
  AuthServiceProtocol authService;
  UserServiceProtocol userService;

  AuthBloc({
    @required this.authService,
    @required this.userService,
  }) : super(InitialAuthState());

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is ResetBlocEvent) {
      yield InitialAuthState();
    }

    if (event is LoginWithFacebookEvent) {
      yield* _handleFacebookLoginEvent();
    }

    if (event is SignInEvent) {
      yield* _handleSignInEvent(event);
    }

    if (event is SignOutEvent) {
      yield* _handleSignOutEvent();
    }
  }

  Stream<AuthState> _handleSignInEvent(SignInEvent event) async* {
    try {
      yield IsSigningInState();

      await authService.signIn(
        userName: event.email,
        password: event.password,
        fcmToken: await (FirebaseMessaging().getToken()),
      );

      final UserDto _user = await userService.fetchCurrentUser();

      this.user = _user;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      yield SignInSuccess();
    } on Exception catch (e) {
      yield SignInFailed();
    }
  }

  Stream<AuthState> _handleSignOutEvent() async* {
    try {
      await FirebaseAuth.instance.signOut();

      await SharedPrefsUtils.setString(SharedPrefsUtils.password, '');
      await SharedPrefsUtils.setString(SharedPrefsUtils.userName, '');
      await SharedPrefsUtils.setString(
          SharedPrefsUtils.AuthorizationHeader, '');
      await SharedPrefsUtils.setString(SharedPrefsUtils.userProfileJson, '');

      yield SignOutSuccess();
    } on Exception catch (e) {
      yield SignOutFailed();
    }
  }

  Stream<AuthState> _handleFacebookLoginEvent() async* {
    final FacebookLoginResult facebookLoginResult = await _facebookLogin.logIn(
      [
        'email',
        'public_profile',
      ],
    );

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        {
          final AuthCredential authCredential =
              FacebookAuthProvider.getCredential(
            accessToken: facebookLoginResult.accessToken.token,
          );

          final AuthResult authResult =
              await FirebaseAuth.instance.signInWithCredential(authCredential);

          firebaseUser = authResult.user;

          yield LoginWithFacebookSuccessState();

          break;
        }
      case FacebookLoginStatus.cancelledByUser:
        {
          yield LoginWithFacebookCanceledByUserState();

          break;
        }
      case FacebookLoginStatus.error:
        {
          yield LoginWithFacebookErrorState(
            errorMessage: facebookLoginResult.errorMessage,
          );
          break;
        }
    }
  }
}
