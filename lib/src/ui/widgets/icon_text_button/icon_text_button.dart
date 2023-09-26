import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  IconTextButton({
    @required this.icon,
    @required this.text,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Icon(
              icon,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
