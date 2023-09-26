import 'package:fitness_time/src/enums/week_day.dart';
import 'package:fitness_time/src/models/appointment.dart';
import 'package:fitness_time/src/ui/widgets/time_item/time_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AppointmentsPanel extends StatelessWidget {
  static const double default_margin = 8;

  final String textEmptyAppointments =
      "Você ainda não tem aulas cadastradas com este professor.";

  final double borderWidth = 1;
  final double height = 150;
  final double fontSizeTitle = 16;
  final double fontSizeDescription = 18;
  final double fontSizeAction = 20;
  final double fontSizeSkills = 8;
  final BorderRadius borderRadius = BorderRadius.all(Radius.circular(7));
  final Color borderColor = Colors.grey;
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF303030);
  final Color textActionColor = Colors.black87;

  final List<Appointment> appointments;

  AppointmentsPanel({
    this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return this._renderEmptyEventsPanel();
    } else {
      return this._appointments();
    }
  }

  Widget _appointments() {
    List<Widget> appointmentsWidgets = List();
    for (Appointment appointment in appointments) {
      appointmentsWidgets.add(
        new TimeItem(
          appointment.time.hour,
          appointment.time.minute,
          this._getDayOfTheWeek(appointment.weekDay),
          this._onTap,
          this._onLongPress,
        ),
      );

      appointmentsWidgets.add(
        SizedBox(
          width: 10,
          height: 10,
        ),
      );
    }
    return Container(
      height: 140,
      child: ListView(
        shrinkWrap: true,
        children: appointmentsWidgets,
        padding: const EdgeInsets.only(bottom: default_margin, top: 4),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _renderEmptyEventsPanel() {
    return new Column(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: Align(
            child: Container(
              width: 250,
              child: new Text(
                this.textEmptyAppointments,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: this.textColor,
                  fontStyle: FontStyle.italic,
                  fontSize: this.fontSizeDescription,
                ),
              ),
            ),
          ),
        ),
        new Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: this._onTap,
            child: new Text(
              "CADASTRAR",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: this.textActionColor,
                fontWeight: FontWeight.w500,
                fontSize: this.fontSizeAction,
              ),
            ),
          ),
        )
      ],
    );
  }

  String _getDayOfTheWeek(WeekDay weekDay) {
    switch (weekDay) {
      case WeekDay.sunday:
        return "D";
      case WeekDay.monday:
        return "S";
      case WeekDay.tuesday:
        return "T";
      case WeekDay.wednesday:
      case WeekDay.thursday:
        return "Q";
      case WeekDay.friday:
      case WeekDay.saturday:
        return "S";
      default:
        return "S";
    }
  }

  void _onTap() {}

  void _onLongPress() {}
}
