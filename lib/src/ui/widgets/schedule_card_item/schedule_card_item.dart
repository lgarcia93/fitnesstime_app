import 'package:fitness_time/src/models/schedule.dart';
import 'package:fitness_time/src/ui/widgets/default_avatar/default_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ScheduleCardItem extends StatelessWidget {
  static const double default_margin = 8;

  final double borderWidth = 1;
  final double height = 220;
  final double fontSizeTitle = 20;
  final double fontSizeDescription = 16;
  final double fontSizeSkills = 12;
  final double avatarSize = 80;
  final BorderRadius borderRadius = BorderRadius.all(Radius.circular(7));
  final Color borderColor = Colors.grey;
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF303030);

  final Schedule event;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  ScheduleCardItem({
    this.event,
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
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: InkWell(
                onTap: this.onTap,
                onLongPress: this._onLongPress,
                child: Row(
                  children: <Widget>[
                    this._buildInstructorAvatar(),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: default_margin,
                          right: 10,
                          bottom: 0,
                          left: 2,
                        ),
                        child: Column(
                          children: <Widget>[
                            this._buildInstructorLabel(),
                            this._buildClassTopic()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildClassTopic() {
    return Container(
//      alignment: Alignment.centerRight,
//      child: new Chip(
//        label: Text(
//          this.event.skill?.name ?? '',
//          style: TextStyle(
//            color: this.textColor,
//            fontStyle: FontStyle.italic,
//            fontSize: this.fontSizeSkills,
//          ),
//        ),
//      ),
        );
  }

  _buildInstructorLabel() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: default_margin),
        child: Text(
          this.event.user.firstName,
          style: TextStyle(
            color: this.textColor,
            fontWeight: FontWeight.bold,
            fontSize: this.fontSizeTitle,
          ),
        ),
      ),
    );
  }

  _buildInstructorAvatar() {
    return Align(
      alignment: Alignment.topLeft,
      child: Center(
        child: DefaultAvatar(
          url: this.event.user.profilePicture,
          size: this.avatarSize,
        ),
      ),
    );
  }

  void _onLongPress() {}
}
