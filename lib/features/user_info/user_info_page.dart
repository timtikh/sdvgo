import 'package:flutter/material.dart';
import 'package:sdvgo/core/domain/user_model.dart';
import 'package:sdvgo/core/presentation/gradient_background.dart';
import 'package:sdvgo/core/presentation/menu_button.dart';
import 'package:sdvgo/features/user_info/presentation/photo.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Настройки"),
            ),
          ),
          body: Consumer<UserModel>(builder: (context, userModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    children: [
                      Photo(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userModel.name,
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(userModel.surname, style: TextStyle(fontSize: 30)),
                        ],
                      )
                    ],
                  ),
                ),
                MenuButton(text: "профиль", textColor: Colors.red, borderColor: Colors.black, speed: 1000,),
                SizedBox(height: 20,),
                MenuButton(text: "профиль", textColor: Colors.green, borderColor: Colors.pink, speed: 3000,),
                SizedBox(height: 20,),
                MenuButton(text: "профиль", textColor: Colors.yellow, borderColor: Colors.purple, speed: 2000,),
              ],
            );
          })),
    );
  }
}
