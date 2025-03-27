import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../objects/player_object.dart';

class ScooterGameWidget extends StatelessWidget {
  const ScooterGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: GameWidget(game: ScooterGame()),
    );
  }
}

class ScooterGame extends FlameGame with PanDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player();

    add(player);
  }

  late Vector2 _startPosition;
  static const _swipeThreshold = 50.0;

  @override
  void onPanStart(DragStartInfo info) {
    _startPosition = info.eventPosition.global;
  }

  @override
  void onPanEnd(DragEndInfo info) {

    final delta = info.raw.globalPosition.dy - _startPosition.y;

    // Check if user swipes enough
    if (delta.abs() > _swipeThreshold) {
      // Check if swipe was horizontal or vertical
        final isUpEvent = delta > 0;
        player.move(isMoveUp: isUpEvent);
    }
  }
}
