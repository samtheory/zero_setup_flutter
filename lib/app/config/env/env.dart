/// Base environment configuration
/// تمام محیط‌ها باید این interface را پیاده‌سازی کنند
abstract class Env {
  /// نام محیط (dev, staging, production)
  String get name;

  /// آیا محیط توسعه است؟
  bool get isDevelopment;

  /// آیا محیط تست است؟
  bool get isStaging;

  /// آیا محیط تولید است؟
  bool get isProduction;

  // ==================== API Configuration ====================

  /// آدرس پایه API
  String get baseUrl;

  /// کلید API
  String get apiKey;

  /// نسخه API
  String get apiVersion;

  /// Timeout برای درخواست‌ها (به میلی‌ثانیه)
  int get connectTimeout;

  /// Timeout برای دریافت پاسخ (به میلی‌ثانیه)
  int get receiveTimeout;

  // ==================== App Configuration ====================

  /// شناسه اپلیکیشن
  String get appId;

  /// نام نمایشی اپلیکیشن
  String get appName;

  /// Bundle ID / Package Name
  String get bundleId;

  // ==================== Feature Flags ====================

  /// نمایش لاگ‌های runtime
  bool get showRuntimeLog;

  /// نمایش لاگ‌های شبکه (Chucker/Charles)
  bool get showNetworkLog;

  /// فعال‌سازی Crashlytics
  bool get enableCrashlytics;

  /// فعال‌سازی Analytics
  bool get enableAnalytics;

  /// حالت دیباگ
  bool get debugMode;

  // ==================== Storage Configuration ====================

  /// نام پایگاه داده محلی
  String get databaseName;

  /// نسخه پایگاه داده
  int get databaseVersion;

  // ==================== External Services ====================

  /// کلید Google Maps
  String? get googleMapsApiKey;

  /// کلید Firebase
  String? get firebaseApiKey;

  /// URL Sentry برای گزارش خطا
  String? get sentryDsn;

  // ==================== Helper Methods ====================

  /// دریافت تنظیمات به صورت Map
  Map<String, dynamic> toMap();

  /// نمایش اطلاعات محیط به صورت خوانا
  @override
  String toString() {
    return '''
    Environment: $name
    Base URL: $baseUrl
    App Name: $appName
    Debug Mode: $debugMode
    ''';
  }
}
