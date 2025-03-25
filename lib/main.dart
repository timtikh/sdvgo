import 'package:flutter/material.dart';
import 'package:sdvgo/app.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/domain/user_model.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => UserModel(), child: const MyApp()));
}


