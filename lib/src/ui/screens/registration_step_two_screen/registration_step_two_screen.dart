import 'package:fitness_time/src/enums/user_type.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/registration_bloc/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:fitness_time/src/ui/widgets/default_button/default_button.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationStepTwoScreen extends StatefulWidget {
  @override
  _RegistrationStepTwoScreenState createState() =>
      _RegistrationStepTwoScreenState();
}

class _RegistrationStepTwoScreenState extends State<RegistrationStepTwoScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> headingText;
  Animation<double> secondTextOpacity;
  Animation<double> userTypeOptionsOpacity;

  RegistrationBloc bloc;
  AuthBloc authBloc;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      value: 0,
      duration: Duration(milliseconds: 4000),
    );

    headingText = new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.2,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    secondTextOpacity = new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.5,
          0.75,
          curve: Curves.ease,
        ),
      ),
    );

    userTypeOptionsOpacity = new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _animationController.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          focusNode.requestFocus();
        }
      },
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bloc = BlocProvider.of<RegistrationBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScreenContainer(
        child: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildUserAvatar(),
                  _buildFirstText(),
                  _buildSecondText(),
                  _buildOptionButtons(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return DefaultAvatar(
      fileImage: bloc?.fileImage,
    );
  }

  Widget _buildFirstText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Opacity(
        opacity: headingText.value,
        child: Text(
          'Seja bem vindo, ${bloc.choosenName}',
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSecondText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Opacity(
        opacity: secondTextOpacity.value,
        child: Text(
          'Você gostaria de se cadastrar como instrutor ou aluno?',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildOptionButtons() {
    return Opacity(
      opacity: userTypeOptionsOpacity.value,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: <Widget>[
            DefaultButton(
              text: 'Instrutor',
              onTap: () {
                _navigateToStepThree(UserType.Instructor);
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16,
              ),
              child: DefaultButton(
                text: 'Aluno',
                onTap: () {
                  _navigateToStepThree(UserType.Student);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToStepThree(UserType userType) {
    bloc.add(
      SetUserTypeEvent(
        userType: userType,
      ),
    );

    Navigator.of(context).pushNamed(
      RoutesNames.RegistrationStepThreeScreen,
    );
  }
}
