import 'package:flutter/material.dart';

import 'button_content.dart';

class StaticButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color bgcolor;

  const StaticButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.borderColor,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ButtonContent(
        onTap: onTap,
        borderColor: borderColor,
        bgcolor: bgcolor,
        child: child,
      ),
    );
  }
}
