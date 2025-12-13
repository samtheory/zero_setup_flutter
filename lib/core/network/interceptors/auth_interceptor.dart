import 'package:dio/dio.dart';
import 'package:zero_setup_flutter/core/network/api_endpoints.dart';

import '../../storage/secure_storage_service.dart';

/// Interceptor برای اضافه کردن Token به Header
class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // گرفتن Token از Storage
    final token = await _storage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authHeader] =
          '${ApiConstants.bearerPrefix} $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // اگر 401 بود، می‌تونیم Refresh Token بزنیم
    // فعلاً فقط pass می‌کنیم
    if (err.response?.statusCode == 401) {
      // TODO: Implement refresh token logic
    }

    handler.next(err);
  }
}
