import 'package:flutter/material.dart';
import 'package:sdvgo/features/achievments/presentation/achievment_progress.dart';

class AchievmentsPage extends StatelessWidget {
  const AchievmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ачивочки")),
      body: Column(
        children: [
          AchievementProgress(
            icon: Icons.star,
            iconColor: Colors.amber,
            progressColor: Colors.green,
            current: 42,
            total: 100,
            height: 50,
            textAbove: true,
          ),
          SizedBox(height: 20,),
          AchievementProgress(
            icon: Icons.heart_broken,
            iconColor: Colors.purple,
            progressColor: Colors.yellow,
            current: 520,
            total: 1000,
            height: 60,
            textAbove: true,
          )
        ],
      ),
    );
  }
}
