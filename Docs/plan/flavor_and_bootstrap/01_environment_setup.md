# مرحله 1: پیکربندی Environment Variables

## مقدمه

در این مرحله سیستم مدیریت متغیرهای محیطی را با استفاده از Dart خالص پیاده‌سازی می‌کنیم. این رویکرد ساده، type-safe و قابل نگهداری است.

## ساختار فایل‌ها

```
lib/config/
├── env/
│   ├── env.dart           # Base class و interface
│   ├── env_dev.dart       # Development environment
│   ├── env_staging.dart   # Staging environment
│   └── env_prod.dart      # Production environment
└── app_config.dart        # Global app configuration
```

## 1. ایجاد Base Environment Class

### فایل: `lib/config/env/env.dart`

این کلاس پایه تعریف می‌کند که هر محیط چه متغیرهایی باید داشته باشد.

```dart
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
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDevelopment': isDevelopment,
      'isStaging': isStaging,
      'isProduction': isProduction,
      'baseUrl': baseUrl,
      'apiKey': apiKey,
      'apiVersion': apiVersion,
      'appId': appId,
      'appName': appName,
      'bundleId': bundleId,
      'showRuntimeLog': showRuntimeLog,
      'showNetworkLog': showNetworkLog,
      'enableCrashlytics': enableCrashlytics,
      'enableAnalytics': enableAnalytics,
      'debugMode': debugMode,
    };
  }
  
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
```

## 2. پیاده‌سازی محیط Development

### فایل: `lib/config/env/env_dev.dart`

```dart
import 'env.dart';

/// Development environment configuration
/// محیط توسعه با تنظیمات مناسب برای debug و testing
class EnvDev implements Env {
  const EnvDev();
  
  @override
  String get name => 'development';
  
  @override
  bool get isDevelopment => true;
  
  @override
  bool get isStaging => false;
  
  @override
  bool get isProduction => false;
  
  // ==================== API Configuration ====================
  
  @override
  String get baseUrl => 'https://dev-api.example.com';
  
  @override
  String get apiKey => 'dev-api-key-12345';
  
  @override
  String get apiVersion => 'v1';
  
  @override
  int get connectTimeout => 30000; // 30 seconds
  
  @override
  int get receiveTimeout => 30000; // 30 seconds
  
  // ==================== App Configuration ====================
  
  @override
  String get appId => 'com.example.zerosetup.dev';
  
  @override
  String get appName => 'Zero Setup (Dev)';
  
  @override
  String get bundleId => 'com.example.zerosetup.dev';
  
  // ==================== Feature Flags ====================
  
  @override
  bool get showRuntimeLog => true;
  
  @override
  bool get showNetworkLog => true;
  
  @override
  bool get enableCrashlytics => false;
  
  @override
  bool get enableAnalytics => false;
  
  @override
  bool get debugMode => true;
  
  // ==================== Storage Configuration ====================
  
  @override
  String get databaseName => 'zero_setup_dev.db';
  
  @override
  int get databaseVersion => 1;
  
  // ==================== External Services ====================
  
  @override
  String? get googleMapsApiKey => 'YOUR_DEV_GOOGLE_MAPS_KEY';
  
  @override
  String? get firebaseApiKey => null; // در محیط dev از Firebase استفاده نمی‌کنیم
  
  @override
  String? get sentryDsn => null; // در محیط dev از Sentry استفاده نمی‌کنیم
}
```

## 3. پیاده‌سازی محیط Staging

### فایل: `lib/config/env/env_staging.dart`

```dart
import 'env.dart';

/// Staging environment configuration
/// محیط تست که نزدیک به production است
class EnvStaging implements Env {
  const EnvStaging();
  
  @override
  String get name => 'staging';
  
  @override
  bool get isDevelopment => false;
  
  @override
  bool get isStaging => true;
  
  @override
  bool get isProduction => false;
  
  // ==================== API Configuration ====================
  
  @override
  String get baseUrl => 'https://staging-api.example.com';
  
  @override
  String get apiKey => 'staging-api-key-67890';
  
  @override
  String get apiVersion => 'v1';
  
  @override
  int get connectTimeout => 20000; // 20 seconds
  
  @override
  int get receiveTimeout => 20000; // 20 seconds
  
  // ==================== App Configuration ====================
  
  @override
  String get appId => 'com.example.zerosetup.staging';
  
  @override
  String get appName => 'Zero Setup (Staging)';
  
  @override
  String get bundleId => 'com.example.zerosetup.staging';
  
  // ==================== Feature Flags ====================
  
  @override
  bool get showRuntimeLog => true;
  
  @override
  bool get showNetworkLog => true;
  
  @override
  bool get enableCrashlytics => true; // فعال برای تست گزارش خطا
  
  @override
  bool get enableAnalytics => false; // غیرفعال تا داده‌های واقعی را آلوده نکند
  
  @override
  bool get debugMode => false;
  
  // ==================== Storage Configuration ====================
  
  @override
  String get databaseName => 'zero_setup_staging.db';
  
  @override
  int get databaseVersion => 1;
  
  // ==================== External Services ====================
  
  @override
  String? get googleMapsApiKey => 'YOUR_STAGING_GOOGLE_MAPS_KEY';
  
  @override
  String? get firebaseApiKey => 'YOUR_STAGING_FIREBASE_KEY';
  
  @override
  String? get sentryDsn => 'YOUR_STAGING_SENTRY_DSN';
}
```

## 4. پیاده‌سازی محیط Production

### فایل: `lib/config/env/env_prod.dart`

```dart
import 'env.dart';

/// Production environment configuration
/// محیط تولید با بالاترین سطح امنیت و بهینه‌سازی
class EnvProd implements Env {
  const EnvProd();
  
  @override
  String get name => 'production';
  
  @override
  bool get isDevelopment => false;
  
  @override
  bool get isStaging => false;
  
  @override
  bool get isProduction => true;
  
  // ==================== API Configuration ====================
  
  @override
  String get baseUrl => 'https://api.example.com';
  
  @override
  String get apiKey => 'prod-api-key-secure-xxxxx';
  
  @override
  String get apiVersion => 'v1';
  
  @override
  int get connectTimeout => 15000; // 15 seconds
  
  @override
  int get receiveTimeout => 15000; // 15 seconds
  
  // ==================== App Configuration ====================
  
  @override
  String get appId => 'com.example.zerosetup';
  
  @override
  String get appName => 'Zero Setup';
  
  @override
  String get bundleId => 'com.example.zerosetup';
  
  // ==================== Feature Flags ====================
  
  @override
  bool get showRuntimeLog => false; // غیرفعال در production
  
  @override
  bool get showNetworkLog => false; // غیرفعال در production
  
  @override
  bool get enableCrashlytics => true;
  
  @override
  bool get enableAnalytics => true;
  
  @override
  bool get debugMode => false;
  
  // ==================== Storage Configuration ====================
  
  @override
  String get databaseName => 'zero_setup.db';
  
  @override
  int get databaseVersion => 1;
  
  // ==================== External Services ====================
  
  @override
  String? get googleMapsApiKey => 'YOUR_PRODUCTION_GOOGLE_MAPS_KEY';
  
  @override
  String? get firebaseApiKey => 'YOUR_PRODUCTION_FIREBASE_KEY';
  
  @override
  String? get sentryDsn => 'YOUR_PRODUCTION_SENTRY_DSN';
}
```

## 5. ایجاد App Configuration

### فایل: `lib/config/app_config.dart`

```dart
import 'env/env.dart';
import 'env/env_dev.dart';
import 'env/env_staging.dart';
import 'env/env_prod.dart';

/// Global app configuration
/// مدیریت تنظیمات کلی اپلیکیشن و محیط فعلی
class AppConfig {
  AppConfig._();
  
  /// Instance سینگلتون
  static final AppConfig instance = AppConfig._();
  
  /// محیط فعلی
  static late Env _env;
  
  /// دسترسی به محیط فعلی
  static Env get env => _env;
  
  /// مقداردهی اولیه با محیط مشخص
  static void initialize(Env environment) {
    _env = environment;
  }
  
  /// Helper برای ایجاد محیط بر اساس نام
  static Env fromString(String envName) {
    switch (envName.toLowerCase()) {
      case 'development':
      case 'dev':
        return const EnvDev();
      case 'staging':
      case 'stg':
        return const EnvStaging();
      case 'production':
      case 'prod':
        return const EnvProd();
      default:
        throw ArgumentError('Unknown environment: $envName');
    }
  }
}
```

## استفاده از Environment

### در main.dart

```dart
import 'package:zero_setup_flutter/config/app_config.dart';
import 'package:zero_setup_flutter/config/env/env_dev.dart';

void main() {
  // مقداردهی محیط
  AppConfig.initialize(const EnvDev());
  
  // دسترسی به تنظیمات
  final env = AppConfig.env;
  print('Running in: ${env.name}');
  print('API URL: ${env.baseUrl}');
  
  runApp(MyApp());
}
```

### در سرویس‌ها

```dart
class ApiService {
  final Dio _dio;
  
  ApiService() : _dio = Dio() {
    final env = AppConfig.env;
    
    _dio.options.baseUrl = env.baseUrl;
    _dio.options.connectTimeout = Duration(milliseconds: env.connectTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: env.receiveTimeout);
    
    if (env.showNetworkLog) {
      _dio.interceptors.add(LogInterceptor());
    }
  }
}
```

## مزایای این رویکرد

✅ **Type Safety**: کامپایلر خطاهای تایپی را پیدا می‌کند
✅ **IDE Support**: Auto-complete و IntelliSense کامل
✅ **ساده و خوانا**: بدون نیاز به ابزار اضافی
✅ **قابل توسعه**: راحت می‌توان متغیر جدید اضافه کرد
✅ **Testable**: راحت می‌توان mock کرد

## نکات امنیتی

⚠️ **هشدار**: کلیدهای API و اطلاعات حساس را هرگز در کد commit نکنید!

### راه‌حل‌های پیشنهادی:

1. **استفاده از Environment Variables**
```dart
String get apiKey => const String.fromEnvironment('API_KEY');
```

2. **استفاده از .env فایل‌ها** (با flutter_dotenv)
```dart
String get apiKey => dotenv.env['API_KEY'] ?? '';
```

3. **استفاده از Remote Config** (Firebase)
```dart
String get apiKey => remoteConfig.getString('api_key');
```

---

**بعدی**: [مرحله 2: تنظیم Android Flavors](./02_android_flavors.md)
