import 'package:flutter/material.dart';
import 'package:sdvgo/features/home/presentation/lower_controller.dart';
import 'package:sdvgo/features/home/presentation/upper_controller.dart';
import 'package:sdvgo/features/home/presentation/clicker_button.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';

import 'presentation/control_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:
            Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
          Column(
            children: [
              Expanded(flex: 8, child: UpperController()),
              Expanded(
                flex: 1,
                child: ControlBar(),
              ),
              Expanded(flex: 8, child: LowerController()),
            ],
          ),
          ClickerButton(),
        ]),
      ),
    );
  }
}
