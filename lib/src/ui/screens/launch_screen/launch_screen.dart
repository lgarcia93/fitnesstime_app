import 'package:fitness_time/src/shared_prefs/shared_prefs.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/auth/auth_event.dart';
import 'package:fitness_time/src/state/auth/auth_state.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(milliseconds: 20),
      () async {
        final String email =
            await SharedPrefsUtils.getString(SharedPrefsUtils.userName);
        final String password =
            await SharedPrefsUtils.getString(SharedPrefsUtils.password);

        if ((email ?? '').isEmpty || (password ?? '').isEmpty) {
          Navigator.of(context).pushReplacementNamed(
            RoutesNames.WelcomeScreen,
          );

          return;
        }

        _authBloc.listen(_authBlocListener);

        _authBloc.add(
          SignInEvent(
            email: email,
            password: password,
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Image.asset('assets/images/logo_size_invert.jpg'),
      ),
    );
  }

  void _authBlocListener(AuthState state) {
    if (state is SignInSuccess) {
      Navigator.of(context).pushReplacementNamed(
        RoutesNames.AppointmentsScreen,
      );
    }

    if (state is SignInFailed) {
      Navigator.of(context).pushReplacementNamed(
        RoutesNames.WelcomeScreen,
      );
    }
  }
}
