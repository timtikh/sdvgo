import 'package:flutter/material.dart';
import 'package:sdvgo/features/home/presentation/lower_controller.dart';
import 'package:sdvgo/features/home/presentation/upper_controller.dart';

import 'presentation/control_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: UpperController()
          ),
          Expanded(
            flex: 1,
            child: ControlBar(),
          ),
          Expanded(
            flex: 4,
            child: LowerController()
          ),
        ],
      ),
    );
  }
}
