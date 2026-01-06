# مرحله 3: سیستم Bootstrap

## مقدمه

Bootstrap فرآیند راه‌اندازی و مقداردهی اولیه اپلیکیشن است. یک سیستم Bootstrap خوب باید:
- **تمیز و منظم** باشد
- **قابل تست** باشد
- **خطاها را مدیریت** کند
- **گزارش‌دهی مناسب** داشته باشد

## معماری Bootstrap

```
┌─────────────────────────────────────────────┐
│              main.dart                      │
│  (Entry Point)                              │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│         Bootstrap.initialize()              │
│  - Setup Environment                        │
│  - Initialize Services                      │
│  - Configure Dependencies                   │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│            Run Application                  │
│  - Create ProviderScope                     │
│  - Start App Widget                         │
└─────────────────────────────────────────────┘
```

## ساختار فایل‌ها

```
lib/
└── core/
    └── bootstrap/
        ├── bootstrap.dart                 # اصلی
        ├── bootstrap_config.dart          # تنظیمات
        ├── bootstrap_initializers.dart    # Initializers
        ├── bootstrap_logger.dart          # Logging
        └── bootstrap_error_handler.dart   # Error handling
```

## 1. Bootstrap Config

### فایل: `lib/core/bootstrap/bootstrap_config.dart`

```dart
import 'package:flutter/foundation.dart';

/// تنظیمات Bootstrap
class BootstrapConfig {
  /// آیا در حالت debug هستیم؟
  final bool isDebugMode;
  
  /// آیا لاگ‌ها فعال باشند؟
  final bool enableLogging;
  
  /// آیا Crashlytics فعال باشد؟
  final bool enableCrashlytics;
  
  /// آیا Analytics فعال باشد؟
  final bool enableAnalytics;
  
  /// Timeout برای initialize (به میلی‌ثانیه)
  final int initializeTimeout;
  
  /// آیا خطاها را به صورت خودکار گزارش دهد؟
  final bool autoReportErrors;

  const BootstrapConfig({
    this.isDebugMode = kDebugMode,
    this.enableLogging = true,
    this.enableCrashlytics = false,
    this.enableAnalytics = false,
    this.initializeTimeout = 30000,
    this.autoReportErrors = true,
  });

  /// تنظیمات پیش‌فرض برای Development
  factory BootstrapConfig.development() {
    return const BootstrapConfig(
      isDebugMode: true,
      enableLogging: true,
      enableCrashlytics: false,
      enableAnalytics: false,
      autoReportErrors: false,
    );
  }

  /// تنظیمات پیش‌فرض برای Production
  factory BootstrapConfig.production() {
    return const BootstrapConfig(
      isDebugMode: false,
      enableLogging: false,
      enableCrashlytics: true,
      enableAnalytics: true,
      autoReportErrors: true,
    );
  }
}
```

## 2. Bootstrap Logger

### فایل: `lib/core/bootstrap/bootstrap_logger.dart`

```dart
import 'package:flutter/foundation.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';

/// Logger مخصوص Bootstrap
class BootstrapLogger {
  BootstrapLogger._();
  
  static const String _prefix = '🚀 [BOOTSTRAP]';
  
  /// لاگ شروع
  static void start(String message) {
    if (kDebugMode) {
      talker.info('$_prefix ▶️ $message');
    }
  }
  
  /// لاگ موفقیت
  static void success(String message) {
    if (kDebugMode) {
      talker.good('$_prefix ✅ $message');
    }
  }
  
  /// لاگ اطلاعات
  static void info(String message) {
    if (kDebugMode) {
      talker.info('$_prefix ℹ️ $message');
    }
  }
  
  /// لاگ هشدار
  static void warning(String message) {
    if (kDebugMode) {
      talker.warning('$_prefix ⚠️ $message');
    }
  }
  
  /// لاگ خطا
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    talker.error('$_prefix ❌ $message', error, stackTrace);
  }
  
  /// لاگ پیشرفت
  static void progress(String service, double percentage) {
    if (kDebugMode) {
      final bars = (percentage / 10).round();
      final progress = '█' * bars + '░' * (10 - bars);
      talker.info('$_prefix $progress ${percentage.toStringAsFixed(0)}% - $service');
    }
  }
}
```

## 3. Bootstrap Error Handler

### فایل: `lib/core/bootstrap/bootstrap_error_handler.dart`

```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'bootstrap_logger.dart';

/// مدیریت خطاهای Bootstrap
class BootstrapErrorHandler {
  /// Handle Flutter errors
  static void setupFlutterErrorHandler() {
    FlutterError.onError = (FlutterErrorDetails details) {
      BootstrapLogger.error(
        'Flutter Error',
        details.exception,
        details.stack,
      );
      
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
    };
  }
  
  /// Handle async errors
  static void setupAsyncErrorHandler() {
    PlatformDispatcher.instance.onError = (error, stack) {
      BootstrapLogger.error(
        'Async Error',
        error,
        stack,
      );
      return true;
    };
  }
  
  /// Handle Zone errors
  static Future<T> runInErrorZone<T>(Future<T> Function() body) async {
    return runZonedGuarded<Future<T>>(
      body,
      (error, stack) {
        BootstrapLogger.error(
          'Zone Error',
          error,
          stack,
        );
      },
    ) as Future<T>;
  }
}
```

## 4. Bootstrap Initializers

### فایل: `lib/core/bootstrap/bootstrap_initializers.dart`

```dart
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/config/app_config.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';
import 'package:zero_setup_flutter/core/storage/secure_storage_service.dart';
import 'bootstrap_logger.dart';

/// مجموعه Initializers
class BootstrapInitializers {
  /// مقداردهی Flutter Bindings
  static Future<void> initializeFlutterBindings() async {
    BootstrapLogger.start('Initializing Flutter Bindings...');
    WidgetsFlutterBinding.ensureInitialized();
    BootstrapLogger.success('Flutter Bindings initialized');
  }
  
  /// مقداردهی Preferences
  static Future<PreferencesService> initializePreferences() async {
    BootstrapLogger.start('Initializing Preferences...');
    final service = PreferencesService();
    await service.init();
    BootstrapLogger.success('Preferences initialized');
    return service;
  }
  
  /// مقداردهی Secure Storage
  static Future<SecureStorageService> initializeSecureStorage() async {
    BootstrapLogger.start('Initializing Secure Storage...');
    final service = SecureStorageService();
    BootstrapLogger.success('Secure Storage initialized');
    return service;
  }
  
  /// مقداردهی Logger
  static Future<void> initializeLogger() async {
    BootstrapLogger.start('Initializing Logger...');
    // تنظیمات Logger بر اساس Environment
    final env = AppConfig.env;
    if (env.showRuntimeLog) {
      // فعال‌سازی لاگ‌ها
    }
    BootstrapLogger.success('Logger initialized');
  }
  
  /// مقداردهی Crashlytics
  static Future<void> initializeCrashlytics() async {
    BootstrapLogger.start('Initializing Crashlytics...');
    final env = AppConfig.env;
    
    if (env.enableCrashlytics) {
      // TODO: Initialize Firebase Crashlytics
      BootstrapLogger.success('Crashlytics initialized');
    } else {
      BootstrapLogger.info('Crashlytics disabled for ${env.name}');
    }
  }
  
  /// مقداردهی Analytics
  static Future<void> initializeAnalytics() async {
    BootstrapLogger.start('Initializing Analytics...');
    final env = AppConfig.env;
    
    if (env.enableAnalytics) {
      // TODO: Initialize Firebase Analytics
      BootstrapLogger.success('Analytics initialized');
    } else {
      BootstrapLogger.info('Analytics disabled for ${env.name}');
    }
  }
  
  /// مقداردهی Database
  static Future<void> initializeDatabase() async {
    BootstrapLogger.start('Initializing Database...');
    // TODO: Initialize local database (SQLite, Hive, etc.)
    BootstrapLogger.success('Database initialized');
  }
  
  /// مقداردهی Network
  static Future<void> initializeNetwork() async {
    BootstrapLogger.start('Initializing Network...');
    // TODO: Initialize Dio, interceptors, etc.
    BootstrapLogger.success('Network initialized');
  }
}
```

## 5. Main Bootstrap Class

### فایل: `lib/core/bootstrap/bootstrap.dart`

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/config/app_config.dart';
import 'package:zero_setup_flutter/config/env/env.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';
import 'package:zero_setup_flutter/core/storage/secure_storage_service.dart';

import 'bootstrap_config.dart';
import 'bootstrap_error_handler.dart';
import 'bootstrap_initializers.dart';
import 'bootstrap_logger.dart';

/// اصلی‌ترین کلاس Bootstrap
class Bootstrap {
  /// مقداردهی کامل اپلیکیشن
  static Future<ProviderContainer> initialize({
    required Env environment,
    BootstrapConfig? config,
  }) async {
    final bootstrapConfig = config ?? 
      (environment.isProduction 
        ? BootstrapConfig.production() 
        : BootstrapConfig.development());

    try {
      BootstrapLogger.start('Starting app initialization...');
      BootstrapLogger.info('Environment: ${environment.name}');
      
      // تنظیم Error Handlers
      BootstrapErrorHandler.setupFlutterErrorHandler();
      BootstrapErrorHandler.setupAsyncErrorHandler();
      
      // مقداردهی Environment
      AppConfig.initialize(environment);
      BootstrapLogger.success('Environment configured: ${environment.name}');
      
      // مقداردهی با Timeout
      await _initializeWithTimeout(
        bootstrapConfig.initializeTimeout,
        () => _performInitialization(bootstrapConfig),
      );
      
      // ایجاد Provider Container با overrides
      final container = await _createProviderContainer(bootstrapConfig);
      
      BootstrapLogger.success('✨ App initialization completed!');
      return container;
      
    } catch (error, stackTrace) {
      BootstrapLogger.error('Failed to initialize app', error, stackTrace);
      rethrow;
    }
  }
  
  /// انجام مقداردهی‌ها
  static Future<void> _performInitialization(BootstrapConfig config) async {
    // 1. Flutter Bindings (0%)
    await BootstrapInitializers.initializeFlutterBindings();
    BootstrapLogger.progress('Flutter Bindings', 10);
    
    // 2. Logger (10%)
    await BootstrapInitializers.initializeLogger();
    BootstrapLogger.progress('Logger', 20);
    
    // 3. Preferences (20%)
    await BootstrapInitializers.initializePreferences();
    BootstrapLogger.progress('Preferences', 40);
    
    // 4. Secure Storage (40%)
    await BootstrapInitializers.initializeSecureStorage();
    BootstrapLogger.progress('Secure Storage', 50);
    
    // 5. Database (50%)
    await BootstrapInitializers.initializeDatabase();
    BootstrapLogger.progress('Database', 70);
    
    // 6. Network (70%)
    await BootstrapInitializers.initializeNetwork();
    BootstrapLogger.progress('Network', 80);
    
    // 7. Crashlytics (80%)
    if (config.enableCrashlytics) {
      await BootstrapInitializers.initializeCrashlytics();
    }
    BootstrapLogger.progress('Crashlytics', 90);
    
    // 8. Analytics (90%)
    if (config.enableAnalytics) {
      await BootstrapInitializers.initializeAnalytics();
    }
    BootstrapLogger.progress('Analytics', 100);
  }
  
  /// مقداردهی با Timeout
  static Future<void> _initializeWithTimeout(
    int timeoutMs,
    Future<void> Function() initializer,
  ) async {
    try {
      await initializer().timeout(
        Duration(milliseconds: timeoutMs),
        onTimeout: () {
          throw TimeoutException(
            'Initialization timeout after ${timeoutMs}ms',
          );
        },
      );
    } catch (e) {
      BootstrapLogger.error('Initialization failed', e);
      rethrow;
    }
  }
  
  /// ایجاد Provider Container
  static Future<ProviderContainer> _createProviderContainer(
    BootstrapConfig config,
  ) async {
    // مقداردهی سرویس‌ها
    final preferencesService = PreferencesService();
    await preferencesService.init();
    
    final secureStorage = SecureStorageService();
    
    // ایجاد container با overrides
    final container = ProviderContainer(
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
        secureStorageProvider.overrideWithValue(secureStorage),
      ],
    );
    
    return container;
  }
}

/// استثنای Timeout
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => 'TimeoutException: $message';
}
```

## 6. استفاده در main.dart

### فایل: `lib/main_dev.dart`

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/config/env/env_dev.dart';
import 'package:zero_setup_flutter/core/bootstrap/bootstrap.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';

void main() async {
  // Bootstrap
  final container = await Bootstrap.initialize(
    environment: const EnvDev(),
  );
  
  // Run App
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ProviderScope(
        observers: [talkerRiverpodObserver],
        child: App(),
      ),
    ),
  );
}
```

## مزایای این رویکرد

✅ **مدولار**: هر بخش مستقل و قابل تست
✅ **قابل پیگیری**: لاگ دقیق از هر مرحله
✅ **ایمن**: مدیریت خطا در همه سطوح
✅ **انعطاف‌پذیر**: راحت می‌توان سرویس جدید اضافه کرد
✅ **خوانا**: کد تمیز و سازماندهی شده

## نکات مهم

⚠️ **Performance**: مقداردهی سنگین را lazy انجام دهید
⚠️ **Error Handling**: همیشه خطاها را مدیریت کنید
⚠️ **Logging**: در production لاگ‌های حساس را غیرفعال کنید
⚠️ **Timeout**: برای هر سرویس timeout مناسب تعیین کنید

---

**بعدی**: [مرحله 4: ادغام و تست](./04_integration_testing.md)
