import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sdvgo/features/scooter_game/objects/road_stripe_height_mixin.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';

class Player extends SpriteComponent
    with
        HasGameRef<ScooterGame>,
        RoadStripeHeight<ScooterGame>,
        CollisionCallbacks {
  Player() : super(anchor: Anchor.centerLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final playerHeight = roadStripeHeight * 0.75;
    final playerWidth = playerHeight * 1.5;
    size = Vector2(playerWidth, playerHeight);
    sprite = await gameRef.loadSprite('scooter_sprite.png');
    position = Vector2(0, gameRef.size.y / 2);

    add(RectangleHitbox(collisionType: CollisionType.active));
  }

  void move({required bool isMoveUp}) {
    if (isMoveUp) {
      if (position.y + roadStripeHeight > gameRef.size.y) {
        return;
      }
      position.add(Vector2(0, roadStripeHeight));
    } else {
      if (position.y - roadStripeHeight < 0) {
        return;
      }
      position.add(Vector2(0, -roadStripeHeight));
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (gameRef.overlays.isActive('GameOver')) {
      return;
    }

    gameRef.pauseEngine();
    gameRef.overlays.add('GameOver');
  }
}
