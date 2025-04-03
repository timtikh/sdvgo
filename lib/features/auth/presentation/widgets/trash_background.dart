import 'package:flutter/material.dart';

class TrashBackground extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;

  const TrashBackground({
    super.key,
    required this.child,
    this.gradientColors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors.isEmpty
                ? [
                    Colors.purple.withOpacity(0.3),
                    Colors.black,
                  ]
                : gradientColors,
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
} 