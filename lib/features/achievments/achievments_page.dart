import 'package:flutter/material.dart';
import 'package:sdvgo/features/achievments/presentation/achievment_progress.dart';
import 'package:sdvgo/core/localizations/s.dart';

class AchievmentsPage extends StatelessWidget {
  const AchievmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            current: 520,
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
    );
  }
}
