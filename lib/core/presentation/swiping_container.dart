import 'package:flutter/material.dart';

const _swipeThreshold = 50.0;

class SwipingContainer extends StatefulWidget {
  const SwipingContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  State<SwipingContainer> createState() => _SwipingContainerState();
}

class _SwipingContainerState extends State<SwipingContainer> {
  int currentWidgetIndex = 0;
  late Offset startPosition;

  void handleSwipe(Offset delta) {
    if (delta.dx.abs() < delta.dy.abs()) {
      return;
    }
    if (delta.dx.abs() < _swipeThreshold) {
      return;
    }
    if (delta.dx < 0) {
      currentWidgetIndex = (currentWidgetIndex + 1) % widget.children.length;
    } else {
      currentWidgetIndex = (currentWidgetIndex - 1) % widget.children.length;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (details) {
        startPosition = details.globalPosition;
      },
      onHorizontalDragEnd: (details) {
        final delta = details.globalPosition - startPosition;
        handleSwipe(delta);
      },
      child: widget.children[currentWidgetIndex],
    );
  }
}
