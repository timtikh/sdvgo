import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/domain/user_statistics.dart';
import 'package:sdvgo/core/domain/user_statistics_cubit.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/features/achievments/presentation/achievment_progress.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class AchievmentsPage extends StatelessWidget {
  const AchievmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        final userStatisticsCubit = scope.userStatisticsCubitDep.get;
        return GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(S.of(context).achievementsTitle),
              backgroundColor: Colors.transparent,
            ),
            body: BlocBuilder<UserStatisticsCubit, UserStatistics>(
              bloc: userStatisticsCubit,
              builder: (context, state) => ListView(
                children: [
                  AchievementProgress(
                    title: S.of(context).tiktoksAchievement,
                    icon: Icons.star,
                    iconColor: Colors.amber,
                    progressColor: Colors.green,
                    current: 42,
                    total: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AchievementProgress(
                    title: S.of(context).clicksAchievement,
                    icon: Icons.heart_broken,
                    iconColor: Colors.purple,
                    progressColor: Colors.yellow,
                    current: state.clicksCount,
                    total: 1000,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AchievementProgress(
                    title: S.of(context).templateWord,
                    icon: Icons.flag,
                    iconColor: Colors.blue,
                    progressColor: Colors.red,
                    current: 75,
                    total: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
