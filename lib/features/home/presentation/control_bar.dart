import 'package:flutter/material.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/features/home/presentation/control_bar_button.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ControlBarButton(
            title: S.of(context).hqdButton,
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          SizedBox(
            width: 100,
          ),
          ControlBarButton(
            title: S.of(context).settingsButton,
            onTap: () {
              Navigator.pushNamed(context, '/userinfo');
            },
          ),
        ],
      ),
    );
  }
}
