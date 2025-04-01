import 'package:flutter/material.dart';

class ButtonContent extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color bgcolor;

  const ButtonContent({
    required this.child,
    required this.onTap,
    required this.borderColor,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(bgcolor),
        side: WidgetStateProperty.all(
          BorderSide(color: borderColor, width: 2.0),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: child,
      ),
    );
  }
}
