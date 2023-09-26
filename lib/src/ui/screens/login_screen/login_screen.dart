import 'package:fitness_time/src/extensions/string_extension.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/auth/auth_event.dart';
import 'package:fitness_time/src/state/auth/auth_state.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/default_button/default_button.dart';
import 'package:fitness_time/src/ui/widgets/message_dialog/message_dialog.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthBloc authBloc;
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _passwordFieldController = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authBloc.add(ResetBlocEvent());
      authBloc.listen(_handleAuthBlocListener);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void _handleAuthBlocListener(AuthState authState) async {
    if (authState is SignInSuccess) {
      Navigator.of(context).pushReplacementNamed(
        RoutesNames.AppointmentsScreen,
      );
    }

    if (authState is SignInFailed) {
      await showDialog(
        context: context,
        builder: (_) => MessageDialog(
          title: 'Falha no login',
          message:
              'Parece que a tentativa de login falhou. Verifique suas credenciais.',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ScreenContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Entrar'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    Widget passwordSuffixIcon = IconButton(
      icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
    );

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Digite seu e-mail',
            ),
            autofocus: true,
            controller: _emailFieldController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (String value) {
              if (!value.isAValidEmail) {
                return 'E-mail inválido';
              }

              return null;
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Digite sua senha',
              suffixIcon: passwordSuffixIcon,
            ),
            controller: _passwordFieldController,
            obscureText: obscurePassword,
            onFieldSubmitted: (_) {
              _onLoginButtonPressed();
            },
            validator: (String value) {
              if (value.length < 6) {
                return 'Senha inválida.';
              }

              return null;
            },
          ),
          SizedBox(
            height: 42.0,
          ),
          _buildLoader(),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return BlocBuilder<AuthBloc, AuthState>(
      cubit: authBloc,
      builder: (context, state) {
        final isLoading = (state is IsSigningInState);

        return DefaultButton(
          text: 'Entrar',
          onTap: _onLoginButtonPressed,
          isLoading: isLoading,
        );
      },
    );
  }

  void _onLoginButtonPressed() {
    FocusScope.of(context).unfocus();

    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      authBloc.add(
        SignInEvent(
          email: _emailFieldController.text,
          password: _passwordFieldController.text,
        ),
      );
    }
  }
}
