import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/domain/user_statistics.dart';
import 'package:sdvgo/core/domain/user_statistics_cubit.dart';
import 'package:sdvgo/features/home/presentation/emoji_animation_manager.dart';
import 'package:sdvgo/features/home/presentation/overflowed_text.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class ClickerButton extends StatefulWidget {
  final GlobalKey<EmojiAnimationManagerState>? emojiManagerKey;

  const ClickerButton({
    super.key,
    this.emojiManagerKey,
  });

  @override
  State<ClickerButton> createState() => _ClickerButtonState();
}

class _ClickerButtonState extends State<ClickerButton> {
  double _scale = 1.0;
  double _scaleIncrement = 0.1;
  Timer? _resetTimer;
  final String _catImageUrl = 'assets/images/smiley_face.png';
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _startResetTimer() {
    _resetTimer?.cancel();
    _resetTimer = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
        _scaleIncrement = 0.15;
      });
    });
  }

  /// Get the position of this button in the global coordinate system
  Offset _getButtonPosition() {
    final RenderBox renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    // Return the center position of the button
    return Offset(
      position.dx + size.width / 2,
      position.dy + size.height / 2,
    );
  }

  void _handleButtonPress(UserStatisticsCubit userStatisticsCubit) {
    // Increment clicks count
    userStatisticsCubit.increaseClicksCountByValue(1);

    // Update scale animation
    setState(() {
      _scale += _scaleIncrement;
      _scaleIncrement *= 0.9;
      _startResetTimer();
    });

    // Trigger emojis from the button position
    final buttonPosition = _getButtonPosition();

    // Use the directly provided emojiManagerKey if available
    if (widget.emojiManagerKey?.currentState != null) {
      widget.emojiManagerKey!.currentState!.triggerEmojis(buttonPosition);
    } else {
      // Fallback to finding in the widget tree if key not provided
      final emojiManager =
          context.findRootAncestorStateOfType<EmojiAnimationManagerState>();
      if (emojiManager != null) {
        emojiManager.triggerEmojis(buttonPosition);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
        builder: (context, scope) {
      final userStatisticsCubit = scope.userStatisticsCubitDep.get;

      return AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 50),
        child: SizedBox(
          key: _buttonKey,
          height: 140,
          width: 140,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.transparent),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () => _handleButtonPress(userStatisticsCubit),
            child: Stack(
              children: [
                Image.asset(
                  _catImageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                BlocBuilder<UserStatisticsCubit, UserStatistics>(
                  bloc: userStatisticsCubit,
                  builder: (context, state) => Center(
                    child: OverflowedText(number: state.clicksCount),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
