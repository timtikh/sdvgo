import 'package:dio/dio.dart';

abstract class AppConfig {
  AppConfig._();

  static BaseOptions dioConfig = BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );
}
