import 'package:flutter/material.dart';
import 'package:sdvgo/app.dart';
import 'package:provider/provider.dart';
import 'package:sdvgo/core/data/mock_user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sdvgo/features/auth/domain/auth_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());



}
