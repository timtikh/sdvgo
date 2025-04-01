import 'package:flutter/material.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';

class DialogWindow extends StatelessWidget {
  final String dialogText;
  final String buttonText;
  final Color bgColor;
  final Color dialogTextColor;
  final Color buttonBgColor;
  final Color buttonTextColor;
  final Color buttonBorderColor;
  final Color borderColor;
  final VoidCallback buttonOnTap;

  const DialogWindow(
      {required this.dialogText,
      required this.buttonText,
      required this.buttonOnTap,
      this.bgColor = Colors.purple,
      this.dialogTextColor = Colors.blue,
      this.buttonBgColor = Colors.green,
      this.buttonTextColor = Colors.yellow,
      this.buttonBorderColor = Colors.red,
      this.borderColor = Colors.orange,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.93),
            border: Border.all(color: borderColor, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dialogText,
                style: TextStyle(
                  color: dialogTextColor,
                  fontSize: 27,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 75,
                child: MenuButton(
                  text: buttonText,
                  textColor: buttonTextColor,
                  borderColor: buttonBorderColor,
                  bgcolor: buttonBgColor.withOpacity(0.7),
                  onTap: buttonOnTap,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
