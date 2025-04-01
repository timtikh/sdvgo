import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  final String text;
  final double fontSize;
  final Animation<double> fadeAnimation;

  const AnimatedLogo({
    Key? key,
    required this.text,
    required this.fadeAnimation,
    this.fontSize = 80,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _wiggleAnimation;
  Color _currentColor = Colors.purple;
  final List<Color> _colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    // Create random movement patterns
    final random = math.Random(DateTime.now().millisecondsSinceEpoch);

    // Main movement
    _xAnimation = Tween<double>(
      begin: -0.5,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _yAnimation = Tween<double>(
      begin: -0.5,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Random rotation with multiple turns
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: random.nextDouble() * 8 * math.pi, // Up to 4 full turns
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Random scale with more variation
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: random.nextDouble() * 0.5 + 0.8, // Random scale between 0.8 and 1.3
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Bouncing effect
    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Wiggle effect
    _wiggleAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
    _controller.addListener(_updateColor);
  }

  void _updateColor() {
    if (_controller.value > 0.95 || _controller.value < 0.05) {
      setState(() {
        _currentColor =
            _colors[DateTime.now().millisecondsSinceEpoch % _colors.length];
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Calculate combined movement
          final xOffset = _xAnimation.value * 200;
          final yOffset = _yAnimation.value * 200;
          final bounceOffset = math.sin(_bounceAnimation.value * math.pi) * 20;
          final wiggleOffset = math.sin(_wiggleAnimation.value) * 10;

          return Transform.translate(
            offset: Offset(
              xOffset + wiggleOffset,
              yOffset + bounceOffset,
            ),
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _currentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _currentColor.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                      shadows: [
                        Shadow(
                          color: _currentColor.withOpacity(0.5),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
