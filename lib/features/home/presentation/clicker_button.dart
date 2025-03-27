import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/domain/user_model.dart';

import 'package:sdvgo/core/localizations/s.dart';

class ClickerButton extends StatefulWidget {
  const ClickerButton({super.key});

  @override
  State<ClickerButton> createState() => _ClickerButtonState();
}

class _ClickerButtonState extends State<ClickerButton> {
  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return SizedBox(
      height: 100,
      width: 100,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue,
            side: BorderSide(
              color: Colors.blue,
            )),
        onPressed: () {
          setState(() {
            userModel.incrementScore();
          });
        },
        child: Text('${S.of(context).click} ${userModel.score}'),
      ),
    );
  }
}
