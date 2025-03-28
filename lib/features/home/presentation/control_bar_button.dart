import 'package:flutter/material.dart';

class ControlBarButton extends StatelessWidget {
  const ControlBarButton(
      {super.key, this.title = 'button', required this.onTap});
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60, // Высота области нажатия
          color: Colors.transparent, // Прозрачный фон (можно заменить)
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
