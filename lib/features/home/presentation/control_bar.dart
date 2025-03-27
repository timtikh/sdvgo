import 'package:flutter/material.dart';
import 'package:sdvgo/features/home/presentation/clicker_button.dart';

import 'package:sdvgo/core/localizations/s.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(S.of(context).exitButton),
          ),
          SizedBox(
            width: 0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/userinfo');
            },
            child: Text(S.of(context).settingsButton),
          ),
        ],
      ),
    );
  }
}
