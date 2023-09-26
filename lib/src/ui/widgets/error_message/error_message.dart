import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;

  ErrorMessage({
    @required this.message,
    this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(fontSize: 16.0),
          ),
          if (onTryAgain != null)
            FlatButton(
              child: Text(
                'Tentar novamente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: onTryAgain,
            )
        ],
      ),
    );
  }
}
