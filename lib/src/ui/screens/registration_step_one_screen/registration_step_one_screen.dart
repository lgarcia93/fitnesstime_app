import 'dart:io';

import 'package:fitness_time/src/state/registration_bloc/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/icon_text_button/forward_text_button.dart';
import 'package:fitness_time/src/ui/widgets/photo_picker/photo_picker.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationStepOneScreen extends StatefulWidget {
  @override
  _RegistrationStepOneScreenState createState() =>
      _RegistrationStepOneScreenState();
}

class _RegistrationStepOneScreenState extends State<RegistrationStepOneScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> firstTextOpacity;
  Animation<double> secondTextOpacity;
  Animation<double> nameInputOpacity;

  final FocusNode focusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  File choosenPicture;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      value: 0,
      duration: Duration(milliseconds: 4000),
    );

    firstTextOpacity = new Tween<double>(begin: 0.0, end: 1.0).animate(
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

    nameInputOpacity = new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.75,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        focusNode.requestFocus();
      }
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ForwardTextButton(
            onTap: () {
              _submitForm(textEditingController.text);
            },
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ScreenContainer(
          top: 0,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildFirstText(),
                  _buildSecondText(),
                  _buildNameInput(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildPhotoPicker(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return Opacity(
      opacity: nameInputOpacity.value,
      child: PhotoPicker(
        onPictureChoosen: (File fileImage) {
          this.choosenPicture = fileImage;
        },
      ),
    );
  }

  Widget _buildFirstText() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Opacity(
        opacity: firstTextOpacity.value,
        child: Text(
          'Olá, ',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  Widget _buildSecondText() {
    return Opacity(
      opacity: secondTextOpacity.value,
      child: Text(
        'como podemos chamar você?',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildNameInput() {
    return Opacity(
      opacity: nameInputOpacity.value,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
                hintText: 'Digite seu nome e sobrenome',
                helperText: 'O nome deve conter pelo menos 3 caracteres'),
            validator: (String content) {
              if (content.length < 3) {
                return 'Nome inválido';
              }

              return null;
            },
            onFieldSubmitted: (String value) {
              _submitForm(value);
            },
          ),
        ),
      ),
    );
  }

  void _submitForm(String nameInputText) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _navigateToStepTwo(nameInputText);
    }
  }

  void _navigateToStepTwo(String choosenName) {
    final RegistrationBloc bloc = BlocProvider.of<RegistrationBloc>(context);

    bloc.add(SetUserFileImageEvent(
      fileImage: this.choosenPicture,
    ));

    bloc.add(
      SetChoosenNameEvent(
        name: choosenName,
      ),
    );

    Navigator.of(context).pushNamed(RoutesNames.RegistrationStepTwoScreen);
  }
}
