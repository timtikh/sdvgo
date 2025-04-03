import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdvgo/core/di/app_scope.dart';
import 'package:sdvgo/core/localizations/s.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';
import 'package:sdvgo/features/auth/domain/cubits/auth_cubit.dart';
import 'package:sdvgo/features/user_info/presentation/photo.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  void onMenuButtonTap() {
    Navigator.pushNamed(context, "/userinfo/achievements");
  }

  @override
  Widget build(BuildContext context) {
    return ScopeBuilder<AppScopeContainer>.withPlaceholder(
      builder: (context, scope) {
        final authCubit = scope.authCubitDep.get;

        return GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: EdgeInsets.all(20),
                child: Text(S.of(context).settingsButton),
              ),
            ),
            body: BlocBuilder<AuthCubit, AuthState>(
              bloc: authCubit,
              builder: (context, state) {
                final user = state.user;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Text(
                            user?.email ?? 'У тебя нет имени',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Photo(),
                              MenuButton(
                                text: S.of(context).exitButton,
                                textColor: Colors.red,
                                borderColor: Colors.black,
                                onTap: () {
                                  Navigator.pop(context);
                                  authCubit.signOut();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    MenuButton(
                      text: S.of(context).achievementsTitle,
                      textColor: Colors.red,
                      borderColor: Colors.black,
                      speed: 1212,
                      onTap: onMenuButtonTap,
                      bgcolor: Colors.green,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MenuButton(
                      text: S.of(context).achievementsTitle,
                      textColor: Colors.green,
                      borderColor: Colors.pink,
                      speed: 2923,
                      onTap: onMenuButtonTap,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MenuButton(
                      text: S.of(context).achievementsTitle,
                      textColor: Colors.yellow,
                      borderColor: Colors.purple,
                      speed: 1697,
                      onTap: onMenuButtonTap,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MenuButton(
                      text: S.of(context).achievementsTitle,
                      textColor: Colors.white70,
                      borderColor: Colors.green,
                      speed: 452,
                      onTap: onMenuButtonTap,
                      bgcolor: Colors.indigoAccent,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MenuButton(
                      text: S.of(context).achievementsTitle,
                      textColor: Colors.black,
                      borderColor: Colors.yellow,
                      speed: 3423,
                      onTap: onMenuButtonTap,
                      bgcolor: Colors.grey,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
