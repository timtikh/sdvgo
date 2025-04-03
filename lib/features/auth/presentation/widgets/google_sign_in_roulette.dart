import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/dialog_window.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';

class GoogleSignInRoulette extends StatefulWidget {
  final Function()? onLuckyButtonPressed;

  const GoogleSignInRoulette({
    super.key,
    this.onLuckyButtonPressed,
  });

  @override
  State<GoogleSignInRoulette> createState() => _GoogleSignInRouletteState();
}

class _GoogleSignInRouletteState extends State<GoogleSignInRoulette>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _xAnimations;
  late List<Animation<double>> _yAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _rotateAnimations;
  late List<Animation<double>> _opacityAnimations;
  bool _isLoading = false;
  int _luckyButtonIndex = 0;

  // Random colors for each button
  late List<Color> _textColors;
  late List<Color> _borderColors;
  late List<Color> _backgroundColors;

  // Helper function to generate random bright color
  Color _getRandomColor() {
    final random = math.Random();
    return Color.fromRGBO(
      random.nextInt(200) + 55, // More vibrant with 55-255 range
      random.nextInt(200) + 55,
      random.nextInt(200) + 55,
      1.0,
    );
  }

  @override
  void initState() {
    super.initState();
    _luckyButtonIndex = DateTime.now().millisecondsSinceEpoch % 3;
    _controllers = List.generate(
        3,
        (_) => AnimationController(
              duration: Duration(
                  seconds: 2 +
                      math.Random()
                          .nextInt(2)), // Random duration between 2-4 seconds
              vsync: this,
            ));

    final random = math.Random(DateTime.now().millisecondsSinceEpoch);

    // Generate random colors for each button
    // _textColors = List.generate(3, (_) => _getRandomColor());
    _textColors = [
      Colors.white,
      Colors.purple,
      Colors.black,
      Colors.teal,
    ];

    _borderColors = List.generate(3, (_) => _getRandomColor());
    // _backgroundColors = List.generate(3, (_) => _getRandomColor());
    _backgroundColors = [
      Colors.red,
      Colors.yellow,
      Colors.green,
      Colors.transparent,
      Colors.transparent,
    ];
    _textColors.shuffle();
    _backgroundColors.shuffle();

    // Create random movement patterns for each button
    _xAnimations = List.generate(3, (index) {
      final startX = random.nextDouble() * 2 - 1;
      final endX = random.nextDouble() * 2 - 1;
      return Tween<double>(
        begin: startX,
        end: endX,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _yAnimations = List.generate(3, (index) {
      final startY = random.nextDouble() * 2 - 1;
      final endY = random.nextDouble() * 2 - 1;
      return Tween<double>(
        begin: startY,
        end: endY,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _scaleAnimations = List.generate(3, (index) {
      final scale =
          random.nextDouble() * 0.4 + 0.8; // Random scale between 0.8 and 1.2
      return Tween<double>(
        begin: 1.0,
        end: scale,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _rotateAnimations = List.generate(3, (index) {
      final rotation = random.nextDouble() *
          4 *
          math.pi; // Random rotation up to 2 full turns
      return Tween<double>(
        begin: 0.0,
        end: rotation,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _opacityAnimations = List.generate(3, (index) {
      final opacity =
          random.nextDouble() * 0.1 + 0.9; // Random opacity between 0.8 and 1
      return Tween<double>(
        begin: 0.8,
        end: opacity,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _startAnimation();
  }

  void _startAnimation() {
    setState(() {
    });
    for (var controller in _controllers) {
      controller.repeat(reverse: true);
    }
  }

  void _stopAnimation() {
    for (var controller in _controllers) {
      controller.stop();
    }
  }

  void _showNoLuckDialog() {
    showDialog(
        context: context,
        builder: (context) => DialogWindow.withButtons(
              dialogText: 'Чел, тебе не повезло, минус вайб(',
              buttonTexts: ['OK'],
              buttonOnTaps: [
                () {
                  Navigator.pop(context);
                }
              ],
              borderColor: Colors.green,
              bgColor: Colors.yellow,
              dialogTextColor: Colors.red,
              buttonBgColor: Colors.redAccent,
              buttonTextColor: Colors.white,
              buttonBorderColor: Colors.green,
            ));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height to ensure buttons are visible
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  _xAnimations[index].value * 100,
                  _yAnimations[index].value * 100,
                ),
                child: Transform.scale(
                  scale: _scaleAnimations[index].value,
                  child: Transform.rotate(
                    angle: _rotateAnimations[index].value,
                    child: Opacity(
                      opacity: _opacityAnimations[index].value,
                      child: MenuButton(
                        text: 'Гугол вход',
                        textColor: _textColors[index],
                        borderColor: _borderColors[index],
                        bgcolor: _backgroundColors[index],
                        onTap: _isLoading
                            ? null
                            : () {
                                _stopAnimation();
                                if (index == _luckyButtonIndex) {
                                  widget.onLuckyButtonPressed?.call();
                                } else {
                                  _showNoLuckDialog();
                                  _startAnimation();
                                }
                              },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
