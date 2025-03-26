import 'package:flutter/material.dart';
import 'package:sdvgo/core/domain/user_model.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.all(20),
            child: Text("сосали?"),
          ),
        ),
        body: Consumer<UserModel>(
          builder: (context, userModel, child) {
            return Column(
              children: [
                Row(
                  children: [
                    Photo(),
                    Column(children: [Text(userModel.name), Text(userModel.surname)],)
                  ],
                )
              ],
            );
          }
        ));
  }
}
