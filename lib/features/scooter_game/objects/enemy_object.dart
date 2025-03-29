import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sdvgo/features/scooter_game/config/game_config.dart';
import 'package:sdvgo/features/scooter_game/objects/road_stripe_height_mixin.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';

class Enemy extends SpriteComponent
    with HasGameRef<ScooterGame>, RoadStripeHeight<ScooterGame> {
  Enemy({required this.pedLine, this.addClicks});

  final int pedLine;
  final void Function()? addClicks;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final enemySize = Vector2.all(roadStripeHeight * 0.75);
    size = enemySize;

    final enemySprite = GameConfig
        .enemySprites[Random().nextInt(GameConfig.enemySprites.length)];
    sprite = await gameRef.loadSprite(enemySprite);

    final enemyBottomPadding = (roadStripeHeight - enemySize.x) / 2;
    final enemyYPosition = roadStripeHeight * pedLine + enemyBottomPadding;
    position = Vector2(gameRef.size.x + enemySize.x, enemyYPosition);

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= dt * 250;

    if (position.x < -roadStripeHeight) {
      removeFromParent();
      if (gameRef.overlays.isActive('GameOver')) {
        return;
      }
      addClicks?.call();
    }
  }
}
