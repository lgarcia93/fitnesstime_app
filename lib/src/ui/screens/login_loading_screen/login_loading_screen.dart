import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/auth/auth_state.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/message_dialog/message_dialog.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginLoadingScreen extends StatefulWidget {
  @override
  _LoginLoadingScreenState createState() => _LoginLoadingScreenState();
}

class _LoginLoadingScreenState extends State<LoginLoadingScreen> {
  AuthBloc authBloc;

  @override
  void initState() {
    Future.delayed(
        Duration(
          milliseconds: 20,
        ), () {
      authBloc.listen(
        (AuthState state) async {
          if (state is SignInSuccess) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Login success'),
              ),
            );
          }

          if (state is SignInFailed) {
            await showDialog(
              context: context,
              builder: (_) => MessageDialog(
                title: 'Falha no login',
                message: 'Parece que a tentativa de login falhou :(',
              ),
            );

            Navigator.of(context)
                .popUntil(ModalRoute.withName(RoutesNames.WelcomeScreen));
          }
        },
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenContainer(
        child: Center(
          child: DefaultLoader(),
        ),
      ),
    );
  }
}
