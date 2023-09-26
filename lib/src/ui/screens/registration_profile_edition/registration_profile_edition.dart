import 'dart:io';

import 'package:fitness_time/src/models/city.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/state/auth/auth_bloc.dart';
import 'package:fitness_time/src/state/auth/auth_event.dart';
import 'package:fitness_time/src/state/auth/auth_state.dart';
import 'package:fitness_time/src/state/registration_bloc/bloc.dart';
import 'package:fitness_time/src/state/setup/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/default_button/default_button.dart';
import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:fitness_time/src/ui/widgets/message_dialog/message_dialog.dart';
import 'package:fitness_time/src/ui/widgets/photo_picker/photo_picker.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationProfileEditionScreen extends StatefulWidget {
  @override
  _RegistrationProfileEditionScreenState createState() =>
      _RegistrationProfileEditionScreenState();
}

class _RegistrationProfileEditionScreenState
    extends State<RegistrationProfileEditionScreen> {
  File choosenPicture;
  RegistrationBloc _registrationBloc;
  SetupBloc _setupBloc;
  AuthBloc authBloc;

  final TextEditingController cityInputTextEditingController =
      TextEditingController();
  final FocusNode skillInputFocusNode = FocusNode();
  final TextEditingController skillsInputTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  List<String> skillsList = <String>[];

  Map<Skill, bool> checkedSkills = <Skill, bool>{};
  City selectedCity;

  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(
          milliseconds: 20,
        ), () {
      _setupBloc.add(LoadCitiesAndSkillsEvent());
      _registrationBloc.listen(_registrationBlocListener);
      authBloc.listen(_authBlocListener);
    });
  }

  void _registrationBlocListener(RegistrationState state) async {
    if (state is FinishRegistrationSuccessState) {
      authBloc.add(SignInEvent(
        email: _registrationBloc.user.username,
        password: _registrationBloc.user.password,
      ));
    }

    if (state is FinishRegistrationFailedState) {
      await showDialog(
        context: context,
        builder: (context) => MessageDialog(
          title: 'Ops ',
          message: 'Parece que algo deu errado ao criar seu cadastro :(',
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    _setupBloc = BlocProvider.of<SetupBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ScreenContainer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 24.0,
                      ),
                      _buildPhotoPicker(),
                      SizedBox(
                        height: 32.0,
                      ),
                      _buildHeading('Selecione sua cidade'),
                      SizedBox(
                        height: 8.0,
                      ),
                      _buildCityDropDown(),
                      SizedBox(
                        height: 16.0,
                      ),
                      _registrationBloc.user.isInstructor
                          ? _buildHeading('Quais são suas especialidades?')
                          : Container(),
                      SizedBox(
                        height: 8.0,
                      ),
                      _buildSkillsCheckBoxes(),
                      SizedBox(
                        height: 16.0,
                      ),
                      _buildDescriptionInput(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              _buildFinishButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityDropDown() {
    return BlocBuilder<SetupBloc, SetupState>(
      cubit: _setupBloc,
      builder: (context, state) {
        final List<City> citiesList =
            state is LoadCitiesAndSkillsSuccessState ? state.cities : [];

        if (state is IsLoadingCitiesAndSkillsState) {
          return DefaultLoader();
        }

        if (state is LoadCitiesAndSkillsSuccessState) {
          return Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton(
              onChanged: (City city) {
                setState(() {
                  selectedCity = city;
                });
              },
              value: selectedCity,
              items: citiesList.map(
                (City _city) {
                  return DropdownMenuItem<City>(
                    value: _city,
                    child: Container(
                      child: Text(
                        '${_city.name} - ${_city.uf}',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildHeading(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _updateCheckedSkill(Skill skill, bool checked) {
    setState(() {
      checkedSkills[skill] = checked;
    });
  }

  Widget _buildSkillsCheckBoxes() {
    if (!_registrationBloc.user.isInstructor) {
      return Container();
    }

    return BlocBuilder<SetupBloc, SetupState>(
      cubit: _setupBloc,
      builder: (context, state) {
        if (state is LoadCitiesAndSkillsSuccessState) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                alignment: WrapAlignment.start,
                children: state.skills.map(
                  (Skill skill) {
                    return Container(
                      width: constraints.biggest.width / 2,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 32.0,
                            height: 32.0,
                            child: Checkbox(
                              value: checkedSkills[skill] ?? false,
                              onChanged: (bool checked) {
                                _updateCheckedSkill(skill, checked);
                              },
                            ),
                          ),
                          Text(
                            skill.name,
                            style: TextStyle(fontSize: 14.0),
                          )
                        ],
                      ),
                    );
                  },
                ).toList(),
              );
            },
          );
        }

        return Container(
          height: 100.0,
          child: Center(
            child: DefaultLoader(),
          ),
        );
      },
    );
  }

  Widget _buildPhotoPicker() {
    return PhotoPicker(
      onPictureChoosen: (File fileImage) {
        this.choosenPicture = fileImage;
      },
    );
  }

  Widget _buildDescriptionInput() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      maxLength: 300,
      controller: _descriptionTextController,
      decoration: InputDecoration(hintText: 'Insira uma breve descrição'),
    );
  }

  List<Skill> _getCheckedSkills() {
    return checkedSkills.keys
        .where((Skill skill) => checkedSkills[skill] ?? false)
        .toList();
  }

  void _finishRegistration() {
    final checkedSkills = _getCheckedSkills();

    if (_registrationBloc.user.isInstructor) {
      if (checkedSkills.length < 1) {
        showDialog(
          context: context,
          builder: (_) => MessageDialog(
            title: 'Selecione suas especialidades',
            message:
                'Como instrutor, você deve selecionar pelo menos uma área de atuação.',
          ),
        );
        return;
      }
    }

    if (selectedCity == null) {
      showDialog(
        context: context,
        builder: (_) => MessageDialog(
          title: 'Sem cidade selecionada',
          message: 'Selecione a cidade onde você se encontra.',
        ),
      );

      return;
    }

    _registrationBloc.add(
      SetUserDtoEvent(
        userDto: _registrationBloc.user
          ..skills = checkedSkills
          ..city = City(code: selectedCity.code)
          ..description = _descriptionTextController.text,
      ),
    );

    _registrationBloc.add(SetUserFileImageEvent(fileImage: choosenPicture));

    _registrationBloc.add(FinishRegistrationEvent());
  }

  Widget _buildFinishButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      cubit: _registrationBloc,
      builder: (context, state) {
        return DefaultButton(
          text: 'Concluir',
          isLoading: state is IsProcessingRegistrationState ||
              authBloc.state is IsSigningInState,
          onTap: _finishRegistration,
        );
      },
    );
  }

  void _authBlocListener(AuthState authState) async {
    if (authState is SignInSuccess) {
      Navigator.of(context).pushReplacementNamed(
        RoutesNames.AppointmentsScreen,
      );
    }

    if (authState is SignInFailed) {
      Navigator.of(context).popUntil(
        ModalRoute.withName(
          RoutesNames.WelcomeScreen,
        ),
      );
    }
  }
}
