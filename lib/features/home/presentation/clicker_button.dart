import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/domain/user_model.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'dart:async';

class ClickerButton extends StatefulWidget {
  const ClickerButton({super.key});

  @override
  State<ClickerButton> createState() => _ClickerButtonState();
}

class _ClickerButtonState extends State<ClickerButton> {
  double _scale = 1.0;
  double _scaleIncrement = 0.1;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _startResetTimer() {
    _resetTimer?.cancel();
    _resetTimer = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
        _scaleIncrement = 0.15;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();

    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 50),
      child: SizedBox(
        height: 140,
        width: 140,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
          ),
          onPressed: () {
            setState(() {
              userModel.incrementScore();
              _scale += _scaleIncrement;
              _scaleIncrement *= 0.9;
              _startResetTimer();
            });
          },
          child: Text('${S.of(context).click} ${userModel.score}'),
        ),
      ),
    );
  }
}
