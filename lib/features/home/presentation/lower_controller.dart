import 'package:flutter/material.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/presentation/swiping_container.dart';
import 'package:sdvgo/features/scooter_game/presentation/scooter_game_widget.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
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
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        final userStatisticsCubit = scope.userStatisticsCubitDep.get;

        return ColoredBox(
          color: Colors.pink.shade100,
          child: SwipingContainer(
            children: [
              ScooterGameWidget(
                addClicks: () {
                  userStatisticsCubit.increaseClicksCountByValue(13);
                },
              ),
              Center(
                child: Text('Screen 2'),
              ),
            ],
          ),
        );
      },
    );
  }
}
