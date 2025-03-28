import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/domain/user_model.dart';
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
  final String _catImageUrl =
      'https://i.pinimg.com/564x/32/f2/43/32f24381b05fcf53d8088c98963fe326.jpg';

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
            backgroundColor: Colors.transparent,
            side: const BorderSide(color: Colors.transparent),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: () {
            setState(() {
              userModel.incrementScore();
              _scale += _scaleIncrement;
              _scaleIncrement *= 0.9;
              _startResetTimer();
            });
          },
          child: Stack(
            children: [
              // Фон с котёнком
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  _catImageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(color: Colors.grey[300]);
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[300]);
                  },
                ),
              ),
              // Текст поверх изображения
              Center(
                child: OverflowBox(
                  maxWidth: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    '${userModel.score}',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
