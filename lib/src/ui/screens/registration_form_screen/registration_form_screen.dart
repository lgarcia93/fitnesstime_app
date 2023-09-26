import 'package:fitness_time/src/extensions/string_extension.dart';
import 'package:fitness_time/src/state/registration_bloc/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/default_button/default_button.dart';
import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/message_dialog/message_dialog.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationFormScreen extends StatefulWidget {
  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isInstructor = false;
  bool obscurePassword = true;

  final FocusNode emailFocusNode = FocusNode();

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();

  bool emailAvailable = false;

  RegistrationBloc _registrationBloc;

  String emailBeforeFocus = '';

  Widget get _blankIcon {
    return SizedBox(
      height: 0,
      width: 0,
    );
  }

  Widget get _invalidEmailIcon {
    return Icon(
      Icons.clear,
      color: Colors.red,
    );
  }

  Widget get _validEmailIcon {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Widget get _isValidatingEmailLoader {
    return Container(
      height: 0,
      width: 0,
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          child: DefaultLoader(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    emailTextEditingController.addListener(() {
      emailAvailable = false;
    });

    Future.delayed(Duration(milliseconds: 20), () {
      _registrationBloc.listen(_registrationBlocListener);
    });

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        emailTextEditingController.text =
            emailTextEditingController.text.trim();
      }
    });
  }

  void _registrationBlocListener(RegistrationState state) async {
    if (state is ValidateEmailSuccess) {
      _registrationBloc.add(
        SetUserDtoEvent(
          userDto: _registrationBloc.user
            ..password = passwordTextEditingController.text
            ..isInstructor = isInstructor
            ..firstName = firstNameTextEditingController.text
            ..username = emailTextEditingController.text
            ..lastName = lastNameTextEditingController.text,
        ),
      );

      Navigator.of(context).pushNamed(
        RoutesNames.RegistrationProfileEditionScreen,
      );
    }

    if (state is ValidateEmailFailed) {
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return MessageDialog(
            title: 'Ops',
            message: 'O e-mail digitado não está disponível.',
          );
        },
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  void _validateEmailOnServer() {
    if (emailTextEditingController.text.isAValidEmail) {
      if (emailBeforeFocus != emailTextEditingController.text) {
        emailAvailable = false;

        _registrationBloc.add(
          ValidateEmailEvent(
            email: emailTextEditingController.text,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ScreenContainer(
          top: 64.0,
          child: Column(
            children: <Widget>[
              Text('Criar conta'),
              SizedBox(
                height: 24.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildForm(),
                ),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildEmailInput(),
          SizedBox(
            height: 16,
          ),
          _buildPasswordInput(),
          SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _buildFirstNameInput(),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: _buildLastNameInput(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _buildInstructorCheckbox(),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      cubit: _registrationBloc,
      builder: (context, state) {
        Widget inputSuffix = _blankIcon;

        emailAvailable = true;

        if (state is IsValidatingEmailState) {
          inputSuffix = _isValidatingEmailLoader;
        }

        if (state is ValidateEmailSuccess) {
          inputSuffix = _validEmailIcon;

          emailAvailable = true;
        }

        if (state is ValidateEmailFailed) {
          inputSuffix = _invalidEmailIcon;
        }

        return TextFormField(
          focusNode: emailFocusNode,
          controller: emailTextEditingController,
          autofocus: true,
          validator: (String value) {
            if (!value.isAValidEmail) {
              return 'E-mail inválido';
            }

            return null;
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (_) {
            emailFocusNode.focusInDirection(TraversalDirection.down);
          },
          decoration: InputDecoration(
            hintText: 'Digite seu e-mail',
            suffixIcon: inputSuffix,
          ),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    Widget suffixIcon = IconButton(
      icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
    );

    return TextFormField(
      validator: (String value) {
        if (value.length >= 8 && value.length <= 14) {
          return null;
        }

        return 'Senha inválida';
      },
      focusNode: passwordFocusNode,
      textInputAction: TextInputAction.next,
      controller: passwordTextEditingController,
      onFieldSubmitted: (_) {
        passwordFocusNode.focusInDirection(TraversalDirection.down);
      },
      decoration: InputDecoration(
        hintText: 'Digite uma senha',
        helperText: 'A senha deve conter de 8 a 14 caracteres',
        suffixIcon: suffixIcon,
      ),
      maxLength: 14,
      obscureText: obscurePassword,
    );
  }

  Widget _buildFirstNameInput() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nome inválido';
        }

        return null;
      },
      focusNode: nameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        nameFocusNode.focusInDirection(TraversalDirection.right);
      },
      controller: firstNameTextEditingController,
      decoration: InputDecoration(
        hintText: 'Nome',
      ),
    );
  }

  Widget _buildLastNameInput() {
    return TextFormField(
      controller: lastNameTextEditingController,
      textInputAction: TextInputAction.next,
      focusNode: lastNameFocusNode,
      onFieldSubmitted: (_) {
        lastNameFocusNode.focusInDirection(TraversalDirection.down);
      },
      decoration: InputDecoration(
        hintText: 'Sobrenome',
      ),
    );
  }

  Widget _buildInstructorCheckbox() {
    return Row(
      children: <Widget>[
        Switch(
          value: isInstructor,
          onChanged: (checked) {
            setState(() {
              isInstructor = checked;
            });
          },
        ),
        Expanded(
          child: Text(
            'Sou instrutor',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      cubit: _registrationBloc,
      builder: (context, state) {
        return DefaultButton(
          text: 'Continuar',
          isLoading: state is IsValidatingEmailState,
          onTap: _onContinueButtonPressed,
        );
      },
    );
  }

  void _onContinueButtonPressed() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _validateEmailOnServer();
    }
  }
}
