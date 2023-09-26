import 'package:fitness_time/src/enums/user_type.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/state/registration_bloc/bloc.dart';
import 'package:fitness_time/src/ui/routes/app_routes.dart';
import 'package:fitness_time/src/ui/widgets/icon_text_button/forward_text_button.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class RegistrationStepThreeScreen extends StatefulWidget {
  @override
  _RegistrationStepThreeScreenState createState() =>
      _RegistrationStepThreeScreenState();
}

class _RegistrationStepThreeScreenState
    extends State<RegistrationStepThreeScreen> {
  List<String> skillsList = <String>[];

  RegistrationBloc registrationBloc;

  final TextEditingController cityInputTextEditingController =
      TextEditingController();

  final TextEditingController skillsInputTextEditingController =
      TextEditingController();

  final FocusNode skillInputFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final UserType userType = registrationBloc.userType;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ForwardTextButton(
            onTap: _navigateToInstructorSearchScreen,
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildCitySection(),
                userType == UserType.Instructor
                    ? _buildSkillsSection()
                    : Container(),
                RaisedButton(
                  child: Text('Finish'),
                  onPressed: () {
                    registrationBloc.add(FinishRegistrationEvent());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCitySection() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 128.0,
      ),
      child: Column(
        children: <Widget>[
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: cityInputTextEditingController,
              onSubmitted: (_) {
                _focusSkillInput();
              },
              decoration: InputDecoration(
                hintText: 'Em qual cidade você está?',
              ),
            ),
            suggestionsCallback: (String city) async {
              return <String>[
                'Montenegro',
                'Porto Alegre',
                'Parobé',
                'São Leopoldo'
              ].where(
                (element) => element.toLowerCase().contains(
                      city.toLowerCase(),
                    ),
              );
            },
            itemBuilder: (context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              cityInputTextEditingController.text = suggestion;

              _setUserCityInBloc();

              _focusSkillInput();
            },
          )
        ],
      ),
    );
  }

  void _focusSkillInput() {
    skillInputFocusNode.requestFocus();
  }

  void _setUserCityInBloc() {
    registrationBloc.add(
      SetUserCityEvent(city: cityInputTextEditingController.text),
    );
  }

  Widget _buildSkillsSection() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32.0,
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: skillsInputTextEditingController,
            focusNode: skillInputFocusNode,
            onFieldSubmitted: (String value) {
              if (addNewSkill(value)) {
                // Força a renderização novamente.
                setState(() {});
              }

              skillsInputTextEditingController.clear();
              _focusSkillInput();
            },
            decoration: InputDecoration(
              hintText: 'Quais suas habilidades?',
              helperText: 'Musculação, Funcional etc',
            ),
          ),
          Wrap(
            children: skillsList
                .map((String skill) => _buildSkillChip(skill))
                .toList(),
          ),
        ],
      ),
    );
  }

  ///Retorna true se a skill passou pelas validações e foi adicionada
  bool addNewSkill(String skill) {
    final String _skill = skill.trim();

    if (_skill != '') {
      //verificar se a skill ja nao está na lista
      String result = skillsList.firstWhere(
          (element) => element.toLowerCase() == _skill.toLowerCase(),
          orElse: () => null);

      if (result == null) {
        skillsList.add(_skill);

        return true;
      }
    }

    return false;
  }

  Widget _buildSkillChip(String skillName) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        deleteIcon: Icon(
          Icons.close,
          size: 12,
        ),
        onDeleted: () {
          setState(() {
            skillsList.removeWhere((_skill) => _skill == skillName);
          });

          registrationBloc.add(
            SetUserSkillsEvent(
              skills: skillsList.map(
                (_skillName) => Skill(
                  name: _skillName,
                ),
              ),
            ),
          );
        },
        label: Text(
          skillName,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  void _navigateToInstructorSearchScreen() {
    Navigator.of(context).pushNamed(RoutesNames.InstructorSearchScreen);
  }
}
