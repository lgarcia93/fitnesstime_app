import 'package:fitness_time/src/ui/widgets/default_loader/default_loader.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final bool enabled;
  final bool isLoading;
  DefaultButton({
    @required this.text,
    @required this.onTap,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.enabled = true,
    this.isLoading = false,
  });

  Widget get _loader {
    return Container(
      width: 24.0,
      height: 24.0,
      child: Center(
        child: DefaultLoader(
          strokeWidth: 2.0,
        ),
      ),
    );
  }

  void _onTap() {
    if (!isLoading && enabled) {
      this.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: backgroundColor ?? Theme.of(context).primaryColor,
        onPressed: _onTap,
        child: isLoading
            ? _loader
            : Text(
                this.text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 18.0,
                ),
              ),
      ),
    );
  }
}
