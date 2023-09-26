import 'package:flutter/cupertino.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;

  final double left;
  final double right;
  final double top;
  final double bottom;

  ScreenContainer({
    @required this.child,
    this.left = 32.0,
    this.right = 32.0,
    this.top = 24.0,
    this.bottom = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: this.top,
          left: this.left,
          right: this.right,
          bottom: this.bottom,
        ),
        child: child,
      ),
    );
  }
}
