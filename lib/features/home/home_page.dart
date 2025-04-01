import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/features/home/presentation/clicker_button.dart';
import 'package:sdvgo/features/home/presentation/emoji_animation_manager.dart';
import 'package:sdvgo/features/home/presentation/lower_controller.dart';
import 'package:sdvgo/features/home/presentation/upper_controller.dart';

import 'presentation/control_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create a global key for the EmojiAnimationManager
  final GlobalKey<EmojiAnimationManagerState> _emojiManagerKey =
      GlobalKey<EmojiAnimationManagerState>();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // Background UI elements
            Column(
              children: [
                Expanded(flex: 8, child: UpperController()),
                Expanded(
                  flex: 1,
                  child: ControlBar(),
                ),
                Expanded(flex: 8, child: LowerController()),
              ],
            ),

            // Wrap both emojis and button in an EmojiAnimationManager
            // This ensures emojis can be triggered properly and will be visible
            EmojiAnimationManager(
              key: _emojiManagerKey,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // This container covers the entire screen but is transparent
                  // It serves as the area where emojis can fly
                  SizedBox.expand(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),

                  // Button is a child of the animation manager
                  ClickerButton(
                    emojiManagerKey: _emojiManagerKey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
