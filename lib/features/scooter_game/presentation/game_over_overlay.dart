import 'package:flutter/material.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';

class GameOver extends StatelessWidget {
  final ScooterGame game;

  const GameOver({required this.game, super.key});

  void restartingGame() async {
    await game.reloadGame();
    game.overlays.remove('GameOver');
    game.resumeEngine();
  }

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Colors.black;
    const whiteTextColor = Colors.white;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 200,
          width: 300,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over\nYour score: ${game.points}',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: restartingGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Play Again',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
