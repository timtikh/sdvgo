import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sdvgo/features/home/presentation/flying_emoji.dart';

/// Manages emoji animations that fly out from a button press
class EmojiAnimationManager extends StatefulWidget {
  final Widget child;

  const EmojiAnimationManager({
    super.key,
    required this.child,
  });

  @override
  State<EmojiAnimationManager> createState() => EmojiAnimationManagerState();
}

class EmojiAnimationManagerState extends State<EmojiAnimationManager> {
  final List<Key> _emojiKeys = [];
  final Map<Key, Offset> _emojiPositions = {};

  /// Trigger emoji animation from the given position
  void triggerEmojis(Offset position) {
    // Create 5-10 emojis at once
    final random = Random();
    final count = 1;

    setState(() {
      for (int i = 0; i < count; i++) {
        final key = GlobalKey();
        _emojiKeys.add(key);
        _emojiPositions[key] = position;
      }
    });
  }

  void _removeEmoji(Key key) {
    setState(() {
      _emojiKeys.remove(key);
      _emojiPositions.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // The actual child content
          widget.child,

          // Overlay for emojis that doesn't block interaction
          if (_emojiKeys.isNotEmpty)
            IgnorePointer(
              child: Stack(
                fit: StackFit.expand,
                children: _emojiKeys
                    .map(
                      (key) => FlyingEmoji(
                        key: key,
                        startPosition: _emojiPositions[key]!,
                        onComplete: () => _removeEmoji(key),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
