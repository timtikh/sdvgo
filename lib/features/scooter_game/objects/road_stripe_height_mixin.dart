import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sdvgo/features/scooter_game/config/game_config.dart';

mixin RoadStripeHeight<T extends FlameGame> on HasGameRef<T> {
  late final double roadStripeHeight =
      gameRef.size.y / GameConfig.roadLinesCounter;
}
