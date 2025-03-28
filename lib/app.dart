import 'package:flutter/material.dart';
import 'package:sdvgo/features/achievments/achievments_page.dart';

import 'features/home/home_page.dart';
import 'features/user_info/user_info_page.dart';

import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/core/styles/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: S.supportedLocales,
      localizationsDelegates: S.localizationDelegates,
      locale: S.locale,
      title: 'SDVGO',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/userinfo': (context) => UserInfoPage(),
        '/userinfo/achievements': (context) => AchievmentsPage(),
      },
      // TODO: Перетащить тему в styles и в целом контроль темки там реализовывать
      theme: appTheme,
      // TODO: Routing через аус чек скрин - когда ауска будет сделана нужно сразу это переделать
    );
  }
}
