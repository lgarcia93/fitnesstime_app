import 'package:fitness_time/src/ui/themes/default_theme.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final bool darkVariant;
  final String text;
  final VoidCallback onPressed;

  CustomOutlineButton({
    this.darkVariant = true,
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: darkVariant
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
        ),
        child: Text(
          this.text,
          style: buttonTextStyle.copyWith(
              color: darkVariant
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onPrimary),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
