import 'package:flutter/material.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/core/styles/theme.dart';
import 'package:sdvgo/features/achievments/achievments_page.dart';
import 'package:sdvgo/features/auth/domain/auth_router.dart';
import 'package:sdvgo/features/auth/presentation/pages/profile_page.dart';
import 'package:sdvgo/features/home/home_page.dart';
import 'package:sdvgo/features/user_info/user_info_page.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appScopeHolder = AppScopeHolder();

  @override
  void initState() {
    super.initState();
    _appScopeHolder.create();
  }

  @override
  void dispose() {
    _appScopeHolder.drop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeProvider(
      holder: _appScopeHolder,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SDVGO',
        supportedLocales: S.supportedLocales,
        localizationsDelegates: S.localizationDelegates,
        locale: S.locale,
        home: const AuthRouter(),
        routes: {
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/userinfo': (context) => const UserInfoPage(),
          '/userinfo/achievements': (context) => AchievmentsPage(),
        },
        theme: appTheme,
      ),
    );
  }
}
