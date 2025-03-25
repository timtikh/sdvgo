import 'package:flutter/material.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
        },
        child: const Text('CLICK'),
      ),
    );
  }
}