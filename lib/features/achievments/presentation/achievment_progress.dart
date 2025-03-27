import 'package:flutter/material.dart';

class AchievementProgress extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color progressColor;
  final int current;
  final int total;
  final double height;

  const AchievementProgress({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = Colors.amber,
    this.progressColor = Colors.blue,
    required this.current,
    required this.total,
    this.height = 100.0,
  });

  double get progress => current / total;
  int get achievementLevel => (current / total * 10).floor() + 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: height,
                      height: height,
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: iconColor, size: height * 0.4),
                          Text(
                            'Уровень $achievementLevel',
                            style: TextStyle(
                              fontSize: height * 0.15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: height * 0.2,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  '$current/$total',
                                  style: TextStyle(
                                    fontSize: height * 0.2,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: progressColor.withOpacity(0.2),
                            color: progressColor,
                            minHeight: height * 0.1,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
