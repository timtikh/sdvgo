import 'package:flutter/material.dart';

import 'button_content.dart';

class AnimatingButton extends StatefulWidget {
  final Widget child;
  final int speed;
  final VoidCallback? onTap;
  final Color borderColor;
  final Color bgcolor;

  const AnimatingButton({
    super.key,
    required this.child,
    required this.speed,
    required this.onTap,
    required this.borderColor,
    required this.bgcolor,
  });

  @override
  State<AnimatingButton> createState() => _AnimatingButtonState();
}

class _AnimatingButtonState extends State<AnimatingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.speed),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -1, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => Align(
        alignment: Alignment(_animation.value, 0),
        child: ButtonContent(
          onTap: widget.onTap,
          borderColor: widget.borderColor,
          bgcolor: widget.bgcolor,
          child: widget.child,
        ),
      ),
    );
  }
}
