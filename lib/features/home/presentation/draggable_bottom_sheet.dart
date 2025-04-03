import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class DraggableBottomSheetWidget extends StatelessWidget {
  final DraggableScrollableController controller;
  final Function(bool pressed) onButtonPressed;

  const DraggableBottomSheetWidget({
    super.key,
    required this.controller,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/hqd.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.black.withOpacity(0.1),
                  //   blurRadius: 10,
                  //   offset: const Offset(0, -5),
                  // ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PressHoldButton(onPressed: onButtonPressed),
                  const SizedBox(height: 16),
                  // Add your bottom sheet content here
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PressHoldButton extends StatelessWidget {
  final Function(bool pressed) onPressed;

  const PressHoldButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        onPressed(true);
        Vibration.hasVibrator().then((hasVibrator) {
          if (hasVibrator == true) {
            Vibration.vibrate(pattern: [0, 500], repeat: 0);
          }
        });
      },
      onTapUp: (_) {
        onPressed(false);
        Vibration.cancel();
      },
      onTapCancel: () {
        onPressed(false);
        Vibration.cancel();
      },
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.1),
            //   blurRadius: 4,
            //   offset: const Offset(0, 2),
            // ),
          ],
        ),
        child: const Center(
            child: Placeholder(
          color: Colors.transparent,
        )),
      ),
    );
  }
}
