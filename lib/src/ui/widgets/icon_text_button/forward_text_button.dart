import 'package:fitness_time/src/ui/widgets/icon_text_button/icon_text_button.dart';
import 'package:flutter/material.dart';

class ForwardTextButton extends StatelessWidget {
  final VoidCallback onTap;

  ForwardTextButton({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconTextButton(
      onTap: onTap,
      icon: Icons.arrow_forward,
      text: 'Próximo',
    );
  }
}
