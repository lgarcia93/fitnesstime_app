import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget {
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final Widget suffixIcon;
  final String hintText;
  final Function(String) validator;
  final bool autoFocus;
  final int maxLength;
  final bool showCounter;
  DefaultInput({
    this.onSubmitted,
    this.focusNode,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.autoFocus = false,
    this.maxLength,
    this.showCounter = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (String value) {
        onSubmitted?.call(value);
      },
      validator: this.validator,
      maxLength: 25,
      focusNode: focusNode,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.text,
      autofocus: autoFocus,
      buildCounter: (BuildContext context,
          {int currentLength, int maxLength, bool isFocused}) {
        if (showCounter) {
          return Text(
            '$currentLength/$maxLength',
            style: TextStyle(
              fontSize: 14,
            ),
          );
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
