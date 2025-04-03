import 'package:flutter/material.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/features/home/presentation/control_bar_button.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Image.asset(
        'assets/images/ad.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
