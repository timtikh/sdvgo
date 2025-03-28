import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'google_sign_in_button.dart';

class GoogleSignInRoulette extends StatefulWidget {
  final Function()? onLuckyButtonPressed;

  const GoogleSignInRoulette({
    Key? key,
    this.onLuckyButtonPressed,
  }) : super(key: key);

  @override
  State<GoogleSignInRoulette> createState() => _GoogleSignInRouletteState();
}

class _GoogleSignInRouletteState extends State<GoogleSignInRoulette> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _xAnimations;
  late List<Animation<double>> _yAnimations;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _rotateAnimations;
  late List<Animation<double>> _opacityAnimations;
  bool _isLoading = false;
  int _luckyButtonIndex = 0;
  bool _gameStarted = false;

  @override
  void initState() {
    super.initState();
    _luckyButtonIndex = DateTime.now().millisecondsSinceEpoch % 3;
    _controllers = List.generate(3, (_) => AnimationController(
      duration: Duration(seconds: 2 + math.Random().nextInt(2)), // Random duration between 2-4 seconds
      vsync: this,
    ));

    final random = math.Random(DateTime.now().millisecondsSinceEpoch);

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
      final scale = random.nextDouble() * 0.4 + 0.8; // Random scale between 0.8 and 1.2
      return Tween<double>(
        begin: 1.0,
        end: scale,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _rotateAnimations = List.generate(3, (index) {
      final rotation = random.nextDouble() * 4 * math.pi; // Random rotation up to 2 full turns
      return Tween<double>(
        begin: 0.0,
        end: rotation,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _opacityAnimations = List.generate(3, (index) {
      final opacity = random.nextDouble() * 0.3 + 0.4; // Random opacity between 0.4 and 0.7
      return Tween<double>(
        begin: 0.4,
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
      _gameStarted = true;
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
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          // todo: add locales
          'Чел, тебе не повезло, минус вайб(',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
                    // todo: add locales

          'Попробуй еще раз!',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: Colors.purple)),
          ),
        ],
      ),
    );
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
    return Container(
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
                      child: GoogleSignInButton(
                        isLoading: _isLoading,
                        isTrashDesign: true,
                        width: 200, // Fixed width for better visibility
                        onPressed: () {
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