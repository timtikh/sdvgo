import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/features/auth/domain/auth_router.dart';
import 'package:sdvgo/features/auth/presentation/pages/trash_login_page.dart';
import 'core/data/mock_user_model.dart';
import 'features/auth/domain/auth_provider.dart';
import 'features/home/home_page.dart';
import 'features/user_info/user_info_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            Provider<AuthenticationProvider>(
              create: (_) => AuthenticationProvider(FirebaseAuth.instance),
            ),
            StreamProvider(
              create: (context) => context.read<AuthenticationProvider>().authState, initialData: null,
            ),
            ChangeNotifierProvider.value(value: mockUserModel)
          ],

      child: MaterialApp(
        title: 'SDVGO',
        home: AuthRouter(),
        routes: {
          '/login': (context) => const TrashLoginPage(),
          '/home': (context) => const HomePage(),
          '/userinfo': (context) => const UserInfoPage(),
        },
        // TODO: Перетащить тему в styles и в целом контроль темки там реализовывать
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );;
  }
}