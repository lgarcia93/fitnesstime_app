import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;

  MessageDialog({
    this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: EdgeInsets.all(0.0),
      elevation: 2.0,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 16.0,
            right: 16.0,
            bottom: 0,
          ),
          child: Column(
            children: <Widget>[
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
