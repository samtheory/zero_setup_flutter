import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:zero_setup_flutter/core/network/api_endpoints.dart';

import '../logger/app_logger.dart';
import '../storage/secure_storage_service.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

/// Dio Client با تمام تنظیمات
class DioClient {
  late final Dio _dio;
  final SecureStorageService _storage;

  DioClient(this._storage) {
    _dio = Dio(_baseOptions);
    _setupInterceptors();
  }

  Dio get dio => _dio;

  /// تنظیمات پایه
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        contentType: ApiConstants.contentType,
        responseType: ResponseType.json,
      );

  /// ترتیب Interceptor‌ها مهمه!
  void _setupInterceptors() {
    _dio.interceptors.addAll([
      // 1️⃣ اول Auth - Token اضافه می‌کنه
      AuthInterceptor(_storage),

      // 2️⃣ بعد Logger - همه چی رو لاگ می‌کنه
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printResponseMessage: true,
          printRequestData: true,
          printResponseData: true,
        ),
      ),

      // 3️⃣ آخر Error Handler - خطاها رو تبدیل می‌کنه
      ErrorInterceptor(),
    ]);
  }
}
