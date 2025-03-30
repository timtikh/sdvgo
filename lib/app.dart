import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/core/styles/theme.dart';
import 'package:sdvgo/features/achievments/achievments_page.dart';
import 'package:sdvgo/features/auth/domain/auth_router.dart';
import 'package:sdvgo/features/auth/presentation/pages/trash_login_page.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

import 'features/auth/domain/auth_provider.dart';
import 'features/home/home_page.dart';
import 'features/user_info/user_info_page.dart';

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
      child: ScopeBuilder<AppScopeContainer>.withPlaceholder(
        builder: (context, appScope) {
          return MultiProvider(
            providers: [
              Provider<AuthenticationProvider>.value(
                value: AuthenticationProvider(FirebaseAuth.instance),
              ),
              StreamProvider(
                create: (context) =>
                    context.read<AuthenticationProvider>().authState,
                initialData: null,
              ),
            ],
            child: MaterialApp(
              title: 'SDVGO',
              supportedLocales: S.supportedLocales,
              localizationsDelegates: S.localizationDelegates,
              locale: S.locale,
              home: AuthRouter(),
              routes: {
                '/login': (context) => const TrashLoginPage(),
                '/home': (context) => const HomePage(),
                '/userinfo': (context) => const UserInfoPage(),
                '/userinfo/achievements': (context) => AchievmentsPage(),
              },
              theme: appTheme,
            ),
          );
        },
        placeholder: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
