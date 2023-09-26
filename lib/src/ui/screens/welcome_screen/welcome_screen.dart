import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/outline_button/custom_outline_button.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomPadding: false,
      body: ScreenContainer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
            SizedBox(
              height: 50,
            ),
            _buildButtons(),
            //  _buildFacebookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: <Widget>[
        CustomOutlineButton(
          darkVariant: false,
          text: 'Entrar',
          onPressed: _onLoginButtonPressed,
        ),
        SizedBox(
          height: 8.0,
        ),
        CustomOutlineButton(
          darkVariant: false,
          text: 'Criar conta',
          onPressed: _onCreateAccountButtonPressed,
        ),
      ],
    );
  }

  void _onCreateAccountButtonPressed() async {
    final result = await Navigator.of(context)
        .pushNamed(RoutesNames.RegistrationFormScreen);

    if (result ?? false) {}
  }

  void _onLoginButtonPressed() {
    Navigator.of(context).pushNamed(RoutesNames.LoginScreen);
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100.0,
      ),
      child: Center(
        child: Image.asset('assets/images/logo_size_invert.jpg'),
      ),
    );
  }
}
