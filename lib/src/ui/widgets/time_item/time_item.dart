import 'package:flutter/material.dart';

class TimeItem extends StatelessWidget {
  final double borderWidth = 1;
  final double width = 64;
  final double fontSizeDay = 24;
  final double fontSizeTime = 14;
  final Color borderColor = Colors.grey;
  final Color backgroundColor = Colors.white;
  final Color textColor = Color(0xFF303030);

  final int hour;
  final int minutes;
  final String weekDay;
  final VoidCallback onTap;

  final VoidCallback onLongPress;

  TimeItem(
    this.hour,
    this.minutes,
    this.weekDay,
    this.onTap,
    this.onLongPress,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: this.width,
        height: this.width * 2,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: this.borderColor, width: this.borderWidth),
        ),
        child: InkWell(
          onTap: this.onTap,
          onLongPress: this._onLongPress,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    this.weekDay.toUpperCase().trim(),
                    style: TextStyle(
                      color: this.textColor,
                      fontSize: this.fontSizeDay,
                    ),
                  ),
                ),
              ),
              Divider(
                height: borderWidth,
                color: borderColor,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    this.formatText(),
                    style: TextStyle(
                      color: this.textColor,
                      fontSize: this.fontSizeTime,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLongPress() {}

  String formatText() {
    String format =
        (this.hour <= 9) ? '0' + this.hour.toString() : this.hour.toString();
    format += ':' +
        (this.minutes <= 9
            ? '0' + this.minutes.toString()
            : this.minutes.toString());
    return format;
  }
}
