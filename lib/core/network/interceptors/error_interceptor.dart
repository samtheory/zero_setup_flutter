import 'package:dio/dio.dart';

import '../../logger/app_logger.dart';
import '../api_exception.dart';

/// Interceptor برای Handle کردن خطاها
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final ApiException apiException;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        apiException = ApiException.timeout();
        break;

      case DioExceptionType.connectionError:
        apiException = ApiException.network();
        break;

      case DioExceptionType.cancel:
        apiException = ApiException.cancel();
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = _extractErrorMessage(err.response?.data);
        apiException = ApiException.fromStatusCode(statusCode, message);
        break;

      case DioExceptionType.badCertificate:
        apiException = const ApiException(
          message: 'خطای امنیتی SSL',
          type: ApiExceptionType.unknown,
        );
        break;

      case DioExceptionType.unknown:
      default:
        apiException = ApiException(
          message: err.message ?? 'خطای نامشخص',
          type: ApiExceptionType.unknown,
        );
    }

    // لاگ کردن خطا
    talker.error('API Error: ${apiException.message}', apiException);

    // ارسال خطای custom به جای DioException
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: apiException,
        type: err.type,
        response: err.response,
      ),
    );
  }

  /// استخراج پیام خطا از Response
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // فرمت‌های رایج پیام خطا
      return data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String? ??
          data['detail'] as String?;
    }

    if (data is String) {
      return data;
    }

    return null;
  }
}
