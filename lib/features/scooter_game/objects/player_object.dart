import 'package:flame/components.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';

class Player extends SpriteComponent with HasGameRef<ScooterGame> {
  Player() : super(
    size:Vector2(150, 100),
    anchor: Anchor.center,
  );


  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('scooter_sprite.png');
    position = gameRef.size / 2;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}