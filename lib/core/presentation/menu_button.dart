import 'package:flutter/material.dart';

import 'animating_button.dart';
import 'static_button.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final int? speed;
  final Color bgcolor;
  final VoidCallback? onTap;

  const MenuButton({
    super.key,
    required this.text,
    this.speed,
    required this.textColor,
    required this.borderColor,
    required this.onTap,
    this.bgcolor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "ChocoCooky",
        color: textColor,
        fontSize: 30,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 7,
            offset: const Offset(6, 4),
          ),
        ],
      ),
    );

    return speed == null
        ? StaticButton(
            onTap: onTap,
            borderColor: borderColor,
            bgcolor: bgcolor,
            child: textWidget,
          )
        : AnimatingButton(
            speed: speed!,
            onTap: onTap,
            borderColor: borderColor,
            bgcolor: bgcolor,
            child: textWidget,
          );
  }
}
