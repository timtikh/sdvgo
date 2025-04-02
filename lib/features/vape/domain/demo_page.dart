import 'package:flutter/material.dart';
import 'package:shake_gesture/shake_gesture.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ShakeGesture Example')),
      body: Center(
        child: ShakeGesture(
          onShake: () {
            print('shake shake ${count++}');
          },
          child: Center(
            child: OutlinedButton(
              onPressed: () {
                print('sinep');
              },
              child: Text('Simulate Shake'),
            ),
          ),
        ),
      ),
    );
  }
}
