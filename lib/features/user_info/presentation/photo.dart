import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      height: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
      ),
    );
  }
}
