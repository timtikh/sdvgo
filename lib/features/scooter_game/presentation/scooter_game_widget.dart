import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/parallax.dart';
import 'package:sdvgo/features/scooter_game/config/game_config.dart';
import 'package:sdvgo/features/scooter_game/objects/enemy_object.dart';
import 'package:sdvgo/features/scooter_game/objects/player_object.dart';

import 'game_over_overlay.dart';

class ScooterGameWidget extends StatelessWidget {
  const ScooterGameWidget({super.key, required this.addClicks});

  final VoidCallback addClicks;

  @override
  Widget build(BuildContext context) {
    return GameWidget<ScooterGame>.controlled(
      gameFactory: () => ScooterGame(addClicks: addClicks),
      overlayBuilderMap: {'GameOver': (_, game) => GameOver(game: game)},
    );
  }
}

class ScooterGame extends FlameGame with PanDetector, HasCollisionDetection {
  ScooterGame({required this.addClicks});

  final VoidCallback addClicks;

  late Player player;
  final stripes = List.generate(GameConfig.roadLinesCounter, (i) => i);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Adding background
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('background.jpeg'),
      ],
      baseVelocity: Vector2(50, 0),
      repeat: ImageRepeat.repeat,
    );
    add(parallax);

    // Adding player
    player = Player();
    add(player);

    // Adding enemies
    add(SpawnComponent.periodRange(
      multiFactory: (amount) {
        final makeTwo = Random().nextBool();

        final shuffledStripes = [...stripes]
          ..shuffle()
          ..take(2);

        return [
          Enemy(
            pedLine: shuffledStripes[0],
            addClicks: addClicks,
          ),
          if (makeTwo)
            Enemy(
              pedLine: shuffledStripes[1],
            ),
        ];
      },
      selfPositioning: true,
      maxPeriod: 2.5,
      minPeriod: 1.5,
    ));
  }

  late Vector2 _startPosition;
  static const _swipeThreshold = 30.0;

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
