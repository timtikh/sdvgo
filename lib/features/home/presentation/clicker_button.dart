import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/domain/user_model.dart';

class ClickerButton extends StatefulWidget {
  const ClickerButton({super.key});

  @override
  State<ClickerButton> createState() => _ClickerButtonState();
}

class _ClickerButtonState extends State<ClickerButton> {
  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();
    return  ElevatedButton(
      onPressed: () {
        setState(() {
          userModel.incrementScore();
        });
      },
      child: Text('CLICK ${userModel.score}'),
    );
  }
}
