import 'package:flame/components.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';

const _ROADLINES_COUNTER = 3;

class Player extends SpriteComponent with HasGameRef<ScooterGame> {
  Player() : super(
    anchor: Anchor.centerLeft,
  );

  late final double roadStripeHeight;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    roadStripeHeight = gameRef.size.y / _ROADLINES_COUNTER;
    final playerHeight = roadStripeHeight * 0.75;
    final playerWidth = playerHeight * 1.5;
    size = Vector2(playerWidth, playerHeight);
    sprite = await gameRef.loadSprite('scooter_sprite.png');
    position = Vector2(0, gameRef.size.y / 2);
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
}