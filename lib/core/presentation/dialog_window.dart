import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';

class DialogWindow extends StatelessWidget {
  final String dialogText;
  final List<Widget> buttons;
  final Color bgColor;
  final Color dialogTextColor;
  final Color borderColor;

  const DialogWindow({
    required this.dialogText,
    required this.buttons,
    this.bgColor = Colors.purple,
    this.dialogTextColor = Colors.blue,
    this.borderColor = Colors.orange,
    super.key,
  });

  // Constructor for creating buttons with the same style
  factory DialogWindow.withButtons({
    required String dialogText,
    required List<String> buttonTexts,
    required List<VoidCallback> buttonOnTaps,
    Color bgColor = Colors.purple,
    Color dialogTextColor = Colors.blue,
    Color buttonBgColor = Colors.green,
    Color buttonTextColor = Colors.yellow,
    Color buttonBorderColor = Colors.red,
    Color borderColor = Colors.orange,
    double buttonHeight = 50,
    Key? key,
  }) {
    assert(buttonTexts.length == buttonOnTaps.length,
        'The number of button texts must match the number of button callbacks');

    final buttonWidgets = <Widget>[];

    for (int i = 0; i < buttonTexts.length; i++) {
      // Add spacing between buttons
      if (i > 0) {
        buttonWidgets.add(const SizedBox(height: 10));
      }

      buttonWidgets.add(
        SizedBox(
          width: 200,
          height: buttonHeight,
          child: MenuButton(
            text: buttonTexts[i],
            textColor: buttonTextColor,
            borderColor: buttonBorderColor,
            bgcolor: buttonBgColor.withOpacity(0.7),
            onTap: buttonOnTaps[i],
            fontSize: 25,
          ),
        ),
      );
    }

    return DialogWindow(
      dialogText: dialogText,
      buttons: buttonWidgets,
      bgColor: bgColor,
      dialogTextColor: dialogTextColor,
      borderColor: borderColor,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: 300,
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.93),
            border: Border.all(color: borderColor, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                dialogText,
                style: TextStyle(
                  color: dialogTextColor,
                  fontSize: 27,
                ),
              ),
              const SizedBox(height: 10),
              ...buttons,
            ],
          ),
        ),
      ),
    );
  }
}
