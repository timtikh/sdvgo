import 'package:flutter/material.dart';
import 'package:sdvgo/features/achievments/achievments_page.dart';

import 'features/home/home_page.dart';
import 'features/user_info/user_info_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDVGO',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/userinfo': (context) => UserInfoPage(),
        '/userinfo/achievements': (context) => AchievmentsPage(),
      },
      // TODO: Перетащить тему в styles и в целом контроль темки там реализовывать
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // TODO: Routing через аус чек скрин - когда ауска будет сделана нужно сразу это переделать
    );
  }
}
