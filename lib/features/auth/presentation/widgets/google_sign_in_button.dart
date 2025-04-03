import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final bool isLoading;
  final Function()? onPressed;
  final bool isTrashDesign;
  final double? width;
  final double? height;

  const GoogleSignInButton({
    super.key,
    this.isLoading = false,
    this.onPressed,
    this.isTrashDesign = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? 280,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: isTrashDesign ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: isTrashDesign ? null : Border.all(color: Colors.grey),
          boxShadow: isTrashDesign
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isTrashDesign)
              Image.network(
                'https://www.google.com/favicon.ico',
                height: 24,
              ),
            SizedBox(width: 12),
            Text(
              // todo: add locales
              'Гугол вход',
              style: TextStyle(
                color: isTrashDesign ? Colors.white : Colors.black87,
                fontSize: isTrashDesign ? 18 : 16,
                fontWeight: isTrashDesign ? FontWeight.bold : FontWeight.normal,
                letterSpacing: isTrashDesign ? 1.2 : 0,
              ),
            ),
            if (isLoading) ...[
              SizedBox(width: 12),
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isTrashDesign ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
