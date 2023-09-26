import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InstructorDetail extends StatelessWidget {
  static const double default_margin = 8;

  final double borderWidth = 1;
  final double height = 150;
  final double fontSizeTitle = 24;
  final double fontSizeDescription = 18;
  final double fontSizeSkills = 12;
  final double pictureSize = 180;
  final BorderRadius borderRadius = BorderRadius.all(Radius.circular(7));
  final Color borderColor = Colors.grey;
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF303030);

  final UserDto instructor;
  final VoidCallback onTap;

  InstructorDetail({this.instructor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        this._renderInstructorName(),
        Hero(
          tag: 'avatar${instructor.username}',
          child: DefaultAvatar(
            url: this.instructor.profilePicture,
            size: this.pictureSize,
          ),
        ),
        this._renderDescription(),
        this._renderSkills(),
      ],
    );
  }

  Widget _renderSkills() {
    List<Widget> skillsWidgets = new List();
    for (Skill skill in this.instructor.skills) {
      skillsWidgets.add(
        Container(
          margin: const EdgeInsets.only(left: 6, right: 3),
          child: new Chip(
            label: Align(
              alignment:
                  Alignment.lerp(Alignment.topCenter, Alignment.center, 0.5),
              child: Text(
                skill.name,
                style: TextStyle(
                  color: this.textColor,
                  fontStyle: FontStyle.italic,
                  fontSize: this.fontSizeSkills,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      height: 60,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 8, top: 16),
        shrinkWrap: true,
        children: skillsWidgets,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _renderInstructorName() {
    return Container(
      margin: const EdgeInsets.only(
          top: default_margin * 3, bottom: 3 * default_margin),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          this.instructor.firstName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: this.textColor,
            fontWeight: FontWeight.bold,
            fontSize: this.fontSizeTitle,
          ),
        ),
      ),
    );
  }

  Widget _renderDescription() {
    return Container(
      margin: const EdgeInsets.all(default_margin * 2),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          this.instructor.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: this.textColor,
            fontStyle: FontStyle.italic,
            fontSize: this.fontSizeDescription,
          ),
        ),
      ),
    );
  }
}
