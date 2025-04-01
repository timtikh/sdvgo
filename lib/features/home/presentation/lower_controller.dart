import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/swiping_container.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';

// TODO: он типо должен хэндлить логику переключения между списком вижетов
// TODO:  а в идеале вообще быть унаследован от одного и того же типа

class LowerController extends StatefulWidget {
  const LowerController({super.key});

  @override
  State<LowerController> createState() => _LowerControllerState();
}

class _LowerControllerState extends State<LowerController> {
  @override
  Widget build(BuildContext context) {
    // TODO: add callback method realisation
    return ColoredBox(
      color: Colors.pink.shade100,
      child: SwipingContainer(
        children: [
          ScooterGameWidget(
            addClicks: () {},
          ),
          Center(
            child: Text('Screen 2'),
          ),
        ],
      ),
    );
  }
}
