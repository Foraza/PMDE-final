// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static Dio? _instance;

  static final _options = BaseOptions(
    baseUrl: '${dotenv.maybeGet('SERVER_HOST') ?? 'localhost'}:${dotenv.maybeGet('SERVER_PORT') ?? '8080'}',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 30000),
  );

  static Dio getInstance() {
    return _instance ?? Dio(_options);
  }
}
