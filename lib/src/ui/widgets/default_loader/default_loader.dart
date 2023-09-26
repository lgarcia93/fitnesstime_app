import 'package:flutter/material.dart';

class DefaultLoader extends StatelessWidget {
  final double strokeWidth;
  final double widthAndHeight;
  DefaultLoader({
    this.strokeWidth = 2.0,
    this.widthAndHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthAndHeight,
      height: widthAndHeight,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
      ),
    );
  }
}
