/// Custom API Exception با اطلاعات کامل
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  final ApiExceptionType type;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
    this.type = ApiExceptionType.unknown,
  });

  @override
  String toString() => 'ApiException: [$statusCode] $message';

  /// Factory برای ساخت از status code
  factory ApiException.fromStatusCode(int? statusCode, [String? message]) {
    switch (statusCode) {
      case 400:
        return ApiException(
          message: message ?? 'درخواست نامعتبر',
          statusCode: statusCode,
          type: ApiExceptionType.badRequest,
        );
      case 401:
        return ApiException(
          message: message ?? 'لطفاً وارد شوید',
          statusCode: statusCode,
          type: ApiExceptionType.unauthorized,
        );
      case 403:
        return ApiException(
          message: message ?? 'دسترسی غیرمجاز',
          statusCode: statusCode,
          type: ApiExceptionType.forbidden,
        );
      case 404:
        return ApiException(
          message: message ?? 'یافت نشد',
          statusCode: statusCode,
          type: ApiExceptionType.notFound,
        );
      case 422:
        return ApiException(
          message: message ?? 'خطا در اعتبارسنجی',
          statusCode: statusCode,
          type: ApiExceptionType.validation,
        );
      case 429:
        return ApiException(
          message: message ?? 'درخواست‌های زیاد، کمی صبر کنید',
          statusCode: statusCode,
          type: ApiExceptionType.tooManyRequests,
        );
      case 500:
        return ApiException(
          message: message ?? 'خطای سرور',
          statusCode: statusCode,
          type: ApiExceptionType.serverError,
        );
      case 502:
      case 503:
      case 504:
        return ApiException(
          message: message ?? 'سرور در دسترس نیست',
          statusCode: statusCode,
          type: ApiExceptionType.serviceUnavailable,
        );
      default:
        return ApiException(
          message: message ?? 'خطای نامشخص',
          statusCode: statusCode,
          type: ApiExceptionType.unknown,
        );
    }
  }

  /// Network errors
  factory ApiException.network([String? message]) {
    return ApiException(
      message: message ?? 'خطا در اتصال به اینترنت',
      type: ApiExceptionType.network,
    );
  }

  /// Timeout
  factory ApiException.timeout([String? message]) {
    return ApiException(
      message: message ?? 'زمان درخواست به پایان رسید',
      type: ApiExceptionType.timeout,
    );
  }

  /// Cancel
  factory ApiException.cancel([String? message]) {
    return ApiException(
      message: message ?? 'درخواست لغو شد',
      type: ApiExceptionType.cancel,
    );
  }
}

/// انواع خطاها
enum ApiExceptionType {
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  validation,
  tooManyRequests,
  serverError,
  serviceUnavailable,
  network,
  timeout,
  cancel,
  unknown,
}
