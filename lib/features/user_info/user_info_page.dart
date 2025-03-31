import 'package:flutter/material.dart';
import 'package:sdvgo/core/domain/user_model.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';
import 'package:sdvgo/features/user_info/presentation/photo.dart';
import 'package:provider/provider.dart';

import 'package:sdvgo/core/localizations/s.dart';

import '../auth/domain/auth_provider.dart';

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
    final authService = Provider.of<AuthenticationProvider>(context);

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
        body: Consumer<UserModel>(
          builder: (context, userModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Photo(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userModel.name,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(userModel.surname,
                              style: TextStyle(fontSize: 30)),
                        ],
                      ),
                      MenuButton(
                        text: S.of(context).exitButton,
                        textColor: Colors.red,
                        borderColor: Colors.red,
                        speed: 10000,
                        onTap: () async {
                          await authService.signOut();
                          Navigator.pushNamed(context, '/login');
                        },
                        bgcolor: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                MenuButton(
                  text: S.of(context).achievementsTitle,
                  textColor: Colors.green,
                  borderColor: Colors.pink,
                  speed: 2923,
                  onTap: onMenuButtonTap,
                ),
                SizedBox(
                  height: 20,
                ),
                MenuButton(
                  text: S.of(context).achievementsTitle,
                  textColor: Colors.yellow,
                  borderColor: Colors.purple,
                  speed: 1697,
                  onTap: onMenuButtonTap,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
