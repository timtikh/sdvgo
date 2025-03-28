import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/features/achievments/presentation/achievment_progress.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/core/domain/user_model.dart';

class AchievmentsPage extends StatelessWidget {
  const AchievmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<UserModel>();

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.of(context).achievementsTitle),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            AchievementProgress(
              title: "Tiktoks",
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
              title: "Clicks",
              icon: Icons.heart_broken,
              iconColor: Colors.purple,
              progressColor: Colors.yellow,
              current: userModel.score,
              total: 1000,
              height: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            AchievementProgress(
              title: "gays",
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
    );
  }
}
