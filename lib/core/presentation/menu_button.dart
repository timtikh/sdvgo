import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key, required this.text, this.speed = 4, required this.textColor, required this.borderColor, required this.route});

  final String text;
  final Color borderColor;
  final Color textColor;
  final int speed;
  final String route;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.speed),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
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
      builder: (context,_) => Align(
        alignment: Alignment(_animation.value * 2 - 1, 0),
        child: OutlinedButton(
          onPressed: () {Navigator.pushNamed(context, widget.route);},
          style: ButtonStyle(
            fixedSize: WidgetStateProperty.all(Size(200, 50)),
            side: WidgetStateProperty.all(
              BorderSide(color: widget.borderColor, width: 2.0),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          child: Text(
            textAlign: TextAlign.center,
            widget.text,
            style: TextStyle(
              fontFamily: "ComicSansMS",
              color: widget.textColor,
              fontSize: 30,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 7,
                  offset: Offset(6, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
