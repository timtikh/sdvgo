import 'package:flutter/material.dart';
import 'package:sdvgo/core/domain/user_model.dart';
import 'package:sdvgo/features/auth/domain/auth_router.dart';
import 'package:sdvgo/features/user_info/presentation/photo.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/features/auth/domain/auth_provider.dart';

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
          title: const Padding(
            padding: EdgeInsets.all(20),
            child: Text("сосали?"),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                try {
                  await context.read<AuthenticationProvider>().signOut();
                  if (mounted) {
                    Navigator.of(context).pushReplacementNamed('/login');
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error signing out: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
        body: Consumer<UserModel>(
          builder: (context, userModel, child) {
            return Column(
              children: [
                Row(
                  children: [
                    const Photo(),
                    Column(
                      children: [
                        Text(userModel.name),
                        Text(userModel.surname)
                      ],
                    )
                  ],
                )
              ],
            );
          }
        ));
  }
}
