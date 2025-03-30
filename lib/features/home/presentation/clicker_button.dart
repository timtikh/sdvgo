import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/domain/user_cubit.dart';
import 'package:sdvgo/features/home/presentation/overflowed_text.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import '../../../core/domain/user.dart';

class ClickerButton extends StatefulWidget {
  const ClickerButton({super.key});

  @override
  State<ClickerButton> createState() => _ClickerButtonState();
}

class _ClickerButtonState extends State<ClickerButton> {
  double _scale = 1.0;
  double _scaleIncrement = 0.1;
  Timer? _resetTimer;
  final String _catImageUrl = 'assets/images/smiley_face.png';

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

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
        builder: (context, scope) {
      final userCubit = scope.userCubitDep.get;

      return AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 50),
        child: SizedBox(
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
            onPressed: () {
              userCubit.incrementScore();
              setState(() {
                _scale += _scaleIncrement;
                _scaleIncrement *= 0.9;
                _startResetTimer();
              });
            },
            child: Stack(
              children: [
                Image.asset(
                  _catImageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                BlocBuilder<UserCubit, User>(
                  bloc: userCubit,
                  builder: (context, state) => Center(
                    child: OverflowedText(number: state.score),
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
