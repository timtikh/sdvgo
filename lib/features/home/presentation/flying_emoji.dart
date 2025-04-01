import 'dart:math';

import 'package:flutter/material.dart';

class FlyingEmoji extends StatefulWidget {
  final Offset startPosition;
  final VoidCallback onComplete;

  const FlyingEmoji({
    super.key,
    required this.startPosition,
    required this.onComplete,
  });

  @override
  State<FlyingEmoji> createState() => _FlyingEmojiState();
}

class _FlyingEmojiState extends State<FlyingEmoji>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  // Random values for animation
  late final Offset _velocity;
  late final double _size;
  late final String _emoji;
  late final Color _color;

  // List of emojis to randomly choose from
  final List<String> _emojis = [
    '😊',
    '😁',
    '🚀',
    '⭐',
    '💖',
    '✨',
    '🔥',
    '👍',
    '🎯',
    '💯'
  ];

  // List of bright colors
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  void initState() {
    super.initState();

    // Initialize random properties
    final random = Random();

    // Random direction (angle in radians)
    final angle = random.nextDouble() * 2 * pi;
    // Random speed between 200 and 500 pixels per second (faster than before)
    final speed = random.nextDouble() * 300 + 200;
    _velocity = Offset(cos(angle) * speed, sin(angle) * speed);

    // Random size between 30 and 60 (larger than before)
    _size = random.nextDouble() * 40 + 40;

    // Random emoji from the list
    _emoji = _emojis[random.nextInt(_emojis.length)];

    // Random color from the list
    _color = _colors[random.nextInt(_colors.length)];

    // Setup animation controller with longer duration for better visibility
    _controller = AnimationController(
      duration: Duration(
          milliseconds:
              random.nextInt(1500) + 1500), // Random duration 1500-3000ms
      vsync: this,
    );

    // Slow down the opacity animation with a custom curve
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        // Use a slower curve for opacity to delay the fade-out
        curve: Interval(0.3, 1.0, curve: Curves.easeInQuart),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward().then((_) {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Calculate current position based on time and velocity
        final t = _controller.value;
        // Adding some gravity effect
        final gravitationalPull = 200.0 * t * t; // Accelerating downward
        final currentPosition = Offset(
          widget.startPosition.dx + _velocity.dx * t,
          widget.startPosition.dy + _velocity.dy * t + gravitationalPull,
        );

        return Positioned(
          left: currentPosition.dx - _size / 2,
          top: currentPosition.dy - _size / 2,
          child: IgnorePointer(
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Text(
                  _emoji,
                  style: TextStyle(
                    fontSize: _size,
                    color: _color, // Apply random color
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
