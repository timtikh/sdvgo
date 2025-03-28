import 'package:flutter/material.dart';
import 'package:sdvgo/core/localizations/s.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/userinfo');
              },
              child: Container(
                height: 60, // Высота области нажатия
                color: Colors.transparent, // Прозрачный фон (можно заменить)
                child: Center(
                  child: Text(S.of(context).hqdButton),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 70,
          ),
          // Второй InkWell
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/userinfo');
              },
              child: Container(
                height: 60, // Такая же высота, как у первой части
                color: Colors.transparent, // Прозрачный фон (можно заменить)
                child: Center(
                  child: Text(S.of(context).settingsButton),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
