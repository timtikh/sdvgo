import 'package:flutter/material.dart';

class AchievementProgress extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color progressColor;
  final int current;
  final int total;
  final double height;
  final bool textAbove;

  const AchievementProgress({
    super.key,
    required this.icon,
    this.iconColor = Colors.amber,
    this.progressColor = Colors.blue,
    required this.current,
    required this.total,
    this.height = 40.0,
    this.textAbove = false,
  });

  double get progress => current / total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Container(
            width: height,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: height * 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (textAbove) _buildProgressText(),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: progressColor.withOpacity(0.2),
                  color: progressColor,
                  minHeight: height * 0.4,
                  borderRadius: BorderRadius.circular(4),
                ),
                if (!textAbove) _buildProgressText(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '$current/$total',
        style: TextStyle(
          fontSize: height * 0.3,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}