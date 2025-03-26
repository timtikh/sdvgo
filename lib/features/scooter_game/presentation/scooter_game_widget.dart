import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../objects/player_object.dart';

class ScooterGameWidget extends StatelessWidget {
  const ScooterGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: ScooterGame());
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

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }
}
