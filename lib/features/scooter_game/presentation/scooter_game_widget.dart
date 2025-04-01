import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/dialog_window.dart';
import 'package:sdvgo/features/scooter_game/config/game_config.dart';
import 'package:sdvgo/features/scooter_game/objects/enemy_object.dart';
import 'package:sdvgo/features/scooter_game/objects/player_object.dart';

class ScooterGameWidget extends StatelessWidget {
  const ScooterGameWidget({super.key, required this.addClicks});

  final VoidCallback addClicks;

  @override
  Widget build(BuildContext context) {
    return GameWidget<ScooterGame>.controlled(
      gameFactory: () => ScooterGame(addClicks: addClicks),
      overlayBuilderMap: {
        'GameOver': (_, game) => DialogWindow(
              dialogText: "Game Over\nYour score: ${game.points}",
              buttonText: "Play again",
              buttonOnTap: game.restartingGame,
            )
      },
    );
  }
}

class ScooterGame extends FlameGame with PanDetector, HasCollisionDetection {
  ScooterGame({required this.addClicks});

  final VoidCallback addClicks;

  late Player player;

  /// Number of stripes in game
  final stripes = List.generate(GameConfig.roadLinesCounter, (i) => i);
  int points = 0;

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
        // Calculating 1 or 2 enemies will be on screen
        final makeTwo = Random().nextBool();

        // Generating on which line enemy occur
        final shuffledStripes = [...stripes]
          ..shuffle()
          ..take(2);

        return [
          Enemy(
            pedLine: shuffledStripes[0],
            addClicks: addPoints,
          ),
          if (makeTwo)
            Enemy(
              pedLine: shuffledStripes[1],
            ),
        ];
      },
      selfPositioning: true,
      // Setting delta time of spawning enemies
      maxPeriod: 2.5,
      minPeriod: 1.5,
    ));
  }

  late Vector2 _startPosition;

  /// Value of how much user should swipe (in pixels) for triggering handler
  static const _swipeThreshold = 30.0;

  @override
  void onPanStart(DragStartInfo info) {
    _startPosition = info.eventPosition.global;
  }

  @override
  void onPanEnd(DragEndInfo info) {
    final delta = info.raw.globalPosition.dy - _startPosition.y;

    final isSwipe = delta.abs() > _swipeThreshold;
    if (isSwipe) {
      // Check if swipe up or down
      final isUpEvent = delta > 0;
      player.move(isMoveUp: isUpEvent);
    }
  }

  Future<void> reloadGame() async {
    removeAll(children);
    points = 0;
    await onLoad();
  }

  void addPoints() {
    points++;
    addClicks();
  }

  void restartingGame() async {
    await reloadGame();
    overlays.remove('GameOver');
    resumeEngine();
  }
}
