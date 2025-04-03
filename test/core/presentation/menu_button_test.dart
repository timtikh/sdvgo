import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';

void main() {
  group('MenuButton Golden Tests', () {
    testWidgets('MenuButton with static variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: MenuButton(
                text: 'Test Button',
                textColor: Colors.white,
                borderColor: Colors.blue,
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MenuButton),
        matchesGoldenFile('menu_button_static.png'),
      );
    });

    testWidgets('MenuButton with animation variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: MenuButton(
                text: 'Animated Button',
                textColor: Colors.white,
                borderColor: Colors.red,
                speed: 1,
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MenuButton),
        matchesGoldenFile('menu_button_animated.png'),
      );
    });

    testWidgets('MenuButton with custom background', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: MenuButton(
                text: 'Custom Background',
                textColor: Colors.white,
                borderColor: Colors.green,
                bgcolor: Colors.blue.withOpacity(0.5),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MenuButton),
        matchesGoldenFile('menu_button_custom_bg.png'),
      );
    });
  });
}
