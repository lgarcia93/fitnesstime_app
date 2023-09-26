import 'package:flutter/material.dart';

class EmptyListPlaceholder extends StatelessWidget {
  final String text;

  EmptyListPlaceholder(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class EmptyScheduleListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyListPlaceholder(
      'Você ainda não possui itens na sua agenda.',
    );
  }
}

class EmptyPendingScheduleListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyListPlaceholder(
      'Sem solicitações pendentes.',
    );
  }
}
