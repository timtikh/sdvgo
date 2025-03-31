import 'package:flutter/material.dart';

class AnimatedWelcomeText extends StatelessWidget {
  final String text;
  final Animation<double> fadeAnimation;
  final double fontSize;
  final double opacity;

  const AnimatedWelcomeText({
    Key? key,
    required this.text,
    required this.fadeAnimation,
    this.fontSize = 16,
    this.opacity = 0.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(opacity),
              fontSize: fontSize,
            ),
          ),
        );
      },
    );
  }
} 