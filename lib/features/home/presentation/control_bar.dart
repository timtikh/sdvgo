import 'package:flutter/material.dart';
import 'package:sdvgo/features/home/presentation/clicker_button.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('HQD'),
          ),
          ClickerButton(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/userinfo');
            },
            child: const Text('SETTINGS'),
          ),
        ],
      ),
    );
  }
}