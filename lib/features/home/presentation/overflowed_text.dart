import 'package:flutter/material.dart';

class OverflowedText extends StatefulWidget {
  const OverflowedText({
    super.key,
    required this.number,
    this.fontSize = 30,
  });
  final int number;
  final double fontSize;
  @override
  State<OverflowedText> createState() => _OverflowedTextState();
}

class _OverflowedTextState extends State<OverflowedText> {
  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Text(
            '${widget.number}',
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = Colors.black,
            ),
          ),
          Text(
            '${widget.number}',
            style: TextStyle(
              fontSize: widget.fontSize,
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
        ],
      ),
    );
  }
}
