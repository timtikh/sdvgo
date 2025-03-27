import 'package:flutter/material.dart';

class GradientColors extends ThemeExtension<GradientColors> {
  final Color color1;
  final Color color2;
  final Color color3;

  const GradientColors({
    required this.color1,
    required this.color2,
    required this.color3,
  });

  @override
  GradientColors copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
  }) {
    return GradientColors(
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
    );
  }

  @override
  GradientColors lerp(GradientColors? other, double t) {
    if (other is! GradientColors) {
      return this;
    }
    return GradientColors(
      color1: Color.lerp(color1, other.color1, t)!,
      color2: Color.lerp(color2, other.color2, t)!,
      color3: Color.lerp(color3, other.color3, t)!,
    );
  }
}

ThemeData appTheme = ThemeData(
  fontFamily: 'Chococooky',
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  extensions: const [
    GradientColors(
      color1: Colors.green,
      color2: Colors.yellow,
      color3: Colors.redAccent,
    ),
  ],
);
