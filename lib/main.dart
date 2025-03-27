import 'package:flutter/material.dart';
import 'package:sdvgo/app.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/data/mock_user_model.dart';

void main() {
  runApp(
      ChangeNotifierProvider.value(value: mockUserModel, child: const MyApp()));
}
