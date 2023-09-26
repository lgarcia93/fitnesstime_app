import 'package:fitness_time/src/enums/week_day.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/ui/widgets/custom_drawer/custom_drawer.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:fitness_time/src/ui/widgets/screen_container/screen_container.dart';
import 'package:flutter/material.dart';

class ScheduleLessonScreenArgs {
  final UserDto instructor;

  ScheduleLessonScreenArgs({
    @required this.instructor,
  });
}

class ScheduleLessonScreen extends StatefulWidget {
  @override
  _ScheduleLessonScreenState createState() => _ScheduleLessonScreenState();
}

const TimeOfDay initialTimeOfDay = const TimeOfDay(
  hour: 6,
  minute: 0,
);

class WeekDaySelection {
  bool selected;
  TimeOfDay timeOfDay;

  WeekDaySelection({
    this.selected = false,
    this.timeOfDay = initialTimeOfDay,
  });
}

class _ScheduleLessonScreenState extends State<ScheduleLessonScreen> {
  Skill selectedSkill;

  Map<WeekDay, WeekDaySelection> weekDaysTime = <WeekDay, WeekDaySelection>{
    WeekDay.monday: WeekDaySelection(),
    WeekDay.tuesday: WeekDaySelection(),
    WeekDay.wednesday: WeekDaySelection(),
    WeekDay.thursday: WeekDaySelection(),
    WeekDay.friday: WeekDaySelection(),
    WeekDay.saturday: WeekDaySelection(),
    WeekDay.sunday: WeekDaySelection(),
  };

  @override
  void initState() {
    super.initState();
  }

  void _updateWeekDaysTime(WeekDay weekDay, TimeOfDay timeOfDay) {
    setState(() {
      weekDaysTime[weekDay].timeOfDay = timeOfDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      drawer: CustomDrawer(),
      body: ScreenContainer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _buildInstructorName(),
                          _buildInstructorAvatar(),
                          _buildSkillsChips(),
                          _buildDaysTable(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildScheduleButton(),
          ],
        ),
      ),
    );
  }

  UserDto get _instructor {
    final ScheduleLessonScreenArgs scheduleLessonArgs =
        ModalRoute.of(context).settings.arguments as ScheduleLessonScreenArgs;
    return scheduleLessonArgs.instructor;
  }

  Widget _buildInstructorName() {
    return Container(
      child: Text(
        _instructor.firstName,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildInstructorAvatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DefaultAvatar(
        url: _instructor.profilePicture,
      ),
    );
  }

  Widget _buildSkillsChips() {
    final bool Function(Skill) isChipSelected = (skill) {
      return (selectedSkill?.id ?? '') == skill.id;
    };

    final Widget Function(Skill) chipBuilder = (skill) {
      return FilterChip(
        onSelected: (selected) {
          setState(
            () {
              if (selected) {
                selectedSkill = skill;
              } else {
                selectedSkill = null;
              }
            },
          );
        },
        label: Text(
          skill.name,
          style: TextStyle(
            color: isChipSelected(skill)
                ? Theme.of(context).chipTheme.secondaryLabelStyle.color
                : Theme.of(context).primaryColor,
          ),
        ),
        selected: isChipSelected(skill),
      );
    };

    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 16.0,
      ),
      child: Wrap(
        spacing: 12,
        alignment: WrapAlignment.center,
        children: _instructor.skills
            .map(
              (Skill skill) => chipBuilder(skill),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDaysTable() {
    return DataTable(
      columnSpacing: 20,
      columns: [
        DataColumn(label: Text('')),
        DataColumn(
          label: Center(child: Text('Dia')),
        ),
        DataColumn(
          label: Center(child: Text('Horário')),
        ),
      ],
      rows: weekDaysNames.entries.map(
        (MapEntry<WeekDay, String> entry) {
          return DataRow(
            cells: [
              DataCell(
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      weekDaysTime[entry.key].selected = value;
                    });

                    if (value) {
                      _showTimePicker(entry.key);
                    }
                  },
                  value: weekDaysTime[entry.key].selected,
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
              DataCell(Text(entry.value)),
              DataCell(
                InkWell(
                  onTap: () => _showTimePicker(entry.key),
                  child: Center(
                    child: Text(
                      '${weekDaysTime[entry.key].timeOfDay.hour.toString().padLeft(2, '0')}:${weekDaysTime[entry.key].timeOfDay.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }

  void _showTimePicker(WeekDay weekDay) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: initialTimeOfDay,
    );

    if (timeOfDay != null) {
      _updateWeekDaysTime(weekDay, timeOfDay);
    }
  }

  Widget _buildScheduleButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('CONFIRMAR'),
        textColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
