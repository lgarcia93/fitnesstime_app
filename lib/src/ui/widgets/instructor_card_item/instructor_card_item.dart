import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:fitness_time/src/ui/widgets/skill_chip/skill_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InstructorCardItem extends StatelessWidget {
  static const double default_margin = 8;

  final double borderWidth = 1;
  final double height = 150;
  final double fontSizeTitle = 16;
  final double fontSizeDescription = 12;
  final double fontSizeSkills = 8;
  final BorderRadius borderRadius = BorderRadius.all(Radius.circular(7));
  final Color borderColor = Colors.grey;
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF303030);

  final UserDto instructor;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  InstructorCardItem({
    this.instructor,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'avatar${instructor.id}',
                    child: DefaultAvatar(
                      url: instructor.profilePicture,
                      size: 65,
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    instructor.completeName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Wrap(
                spacing: 4.0,
                runSpacing: 8.0,
                children: instructor.skills
                    .map(
                      (e) => SkillChip(
                        text: e.name,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLongPress() {}

  List<Widget> _renderSkills() {
    List<Widget> skillsWidgets = new List();
    for (Skill skill in this.instructor.skills) {
      skillsWidgets.add(
        Container(
          margin: const EdgeInsets.only(left: 4, right: 2),
          child: new Chip(
            label: Align(
              alignment: Alignment.lerp(
                Alignment.topCenter,
                Alignment.center,
                0.5,
              ),
              child: Text(
                skill.name,
                style: TextStyle(
                  color: this.textColor,
                  fontStyle: FontStyle.italic,
                  fontSize: this.fontSizeDescription,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return skillsWidgets;
  }
}
