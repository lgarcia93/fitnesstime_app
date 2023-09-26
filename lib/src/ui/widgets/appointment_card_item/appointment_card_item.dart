import 'package:fitness_time/src/models/appointment.dart';
import 'package:fitness_time/src/models/skill.dart';
import 'package:fitness_time/src/models/user_dto.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppointmentCardItem extends StatelessWidget {
  static const double default_margin = 8;

  final double borderWidth = 1;
  final double height = 100;
  final double fontSizeTitle = 20;
  final double fontSizeDescription = 16;
  final double fontSizeSkills = 12;
  final double avatarSize = 80;
  final BorderRadius borderRadius = BorderRadius.all(Radius.circular(7));
  final Color borderColor = Colors.grey;
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF303030);

  final Appointment appointment;
  final UserDto instructor;
  final Skill skill;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  AppointmentCardItem({
    this.appointment,
    this.instructor,
    this.skill,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        borderRadius: this.borderRadius,
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: this.onTap,
            onLongPress: this._onLongPress,
            child: Row(
              children: [
                this._renderTime(context),
                this._renderClassDetails(),
                this._renderInstructorAvatar()
              ],
            ),
          ),
        ));
  }

  _renderTime(BuildContext context) {
    return Flexible(
      flex: 5,
      child: new Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topRight,
              child: Text(
                this.appointment.time.format(context),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: this.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              )),
          Align(
              alignment: Alignment.topRight,
              child: Text(
                this.appointment.time.format(context),
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: this.textColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              )),
        ],
      ),
    );
  }

  _renderClassDetails() {
    return Flexible(
      flex: 11,
      child: Container(
        margin: const EdgeInsets.only(left: 2, right: 4),
        child: new Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Text(
                this.instructor.firstName,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                this.skill.name,
                style: TextStyle(
                  color: this.textColor,
                  fontStyle: FontStyle.italic,
                  fontSize: this.fontSizeSkills,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _renderInstructorAvatar() {
    return Flexible(
        flex: 6,
        child: Align(
          alignment: Alignment.topRight,
          child: DefaultAvatar(
            url: this.instructor.profilePicture,
            size: this.avatarSize,
          ),
        ));
  }

  void _onLongPress() {}
}
