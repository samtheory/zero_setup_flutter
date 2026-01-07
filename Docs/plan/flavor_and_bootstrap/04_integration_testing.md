# مرحله 4: ادغام و تست

## مقدمه

در این مرحله تمام قطعات را به هم متصل کرده و سیستم کامل را تست می‌کنیم.

## چک‌لیست ادغام

### ✅ Environment Configuration
- [ ] فایل‌های env ایجاد شده‌اند
- [ ] AppConfig به درستی کار می‌کند
- [ ] متغیرهای محیطی در دسترس هستند

### ✅ Android Flavors
- [ ] Flavors در build.gradle تعریف شده‌اند
- [ ] نام‌های اپلیکیشن درست هستند
- [ ] Package names متفاوت هستند
- [ ] آیکون‌ها تنظیم شده‌اند

### ✅ Bootstrap System
- [ ] Bootstrap class پیاده‌سازی شده
- [ ] Error handling فعال است
- [ ] Logging کار می‌کند
- [ ] Initializers به درستی اجرا می‌شوند

## ساختار نهایی پروژه

```
zero_setup_flutter/
├── lib/
│   ├── config/
│   │   ├── env/
│   │   │   ├── env.dart
│   │   │   ├── env_dev.dart
│   │   │   ├── env_staging.dart
│   │   │   └── env_prod.dart
│   │   └── app_config.dart
│   ├── core/
│   │   └── bootstrap/
│   │       ├── bootstrap.dart
│   │       ├── bootstrap_config.dart
│   │       ├── bootstrap_initializers.dart
│   │       ├── bootstrap_logger.dart
│   │       └── bootstrap_error_handler.dart
│   ├── main_dev.dart
│   ├── main_staging.dart
│   └── main_prod.dart
├── android/
│   └── app/
│       ├── build.gradle.kts
│       └── src/
│           ├── dev/
│           ├── staging/
│           └── prod/
└── Docs/
    └── plan/
        └── flavor_and_bootstrap/
            ├── 00_overview.md
            ├── 01_environment_setup.md
            ├── 02_android_flavors.md
            ├── 03_bootstrap_system.md
            └── 04_integration_testing.md
```

## تست‌های مورد نیاز

### 1. تست Environment

```dart
// test/config/env_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zero_setup_flutter/config/env/env_dev.dart';
import 'package:zero_setup_flutter/config/env/env_staging.dart';
import 'package:zero_setup_flutter/config/env/env_prod.dart';

void main() {
  group('Environment Tests', () {
    test('Dev environment should have correct values', () {
      const env = EnvDev();
      
      expect(env.name, 'development');
      expect(env.isDevelopment, true);
      expect(env.showRuntimeLog, true);
      expect(env.debugMode, true);
      expect(env.baseUrl, contains('dev'));
    });
    
    test('Staging environment should have correct values', () {
      const env = EnvStaging();
      
      expect(env.name, 'staging');
      expect(env.isStaging, true);
      expect(env.enableCrashlytics, true);
      expect(env.baseUrl, contains('staging'));
    });
    
    test('Production environment should have correct values', () {
      const env = EnvProd();
      
      expect(env.name, 'production');
      expect(env.isProduction, true);
      expect(env.showRuntimeLog, false);
      expect(env.debugMode, false);
      expect(env.enableCrashlytics, true);
      expect(env.enableAnalytics, true);
    });
  });
}
```

### 2. تست AppConfig

```dart
// test/config/app_config_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zero_setup_flutter/config/app_config.dart';
import 'package:zero_setup_flutter/config/env/env_dev.dart';

void main() {
  group('AppConfig Tests', () {
    test('Should initialize with correct environment', () {
      const env = EnvDev();
      AppConfig.initialize(env);
      
      expect(AppConfig.env, env);
      expect(AppConfig.env.name, 'development');
    });
    
    test('Should create environment from string', () {
      final devEnv = AppConfig.fromString('dev');
      expect(devEnv.isDevelopment, true);
      
      final stagingEnv = AppConfig.fromString('staging');
      expect(stagingEnv.isStaging, true);
      
      final prodEnv = AppConfig.fromString('prod');
      expect(prodEnv.isProduction, true);
    });
    
    test('Should throw error for unknown environment', () {
      expect(
        () => AppConfig.fromString('unknown'),
        throwsArgumentError,
      );
    });
  });
}
```

### 3. تست Bootstrap

```dart
// test/core/bootstrap/bootstrap_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zero_setup_flutter/config/env/env_dev.dart';
import 'package:zero_setup_flutter/core/bootstrap/bootstrap.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Bootstrap Tests', () {
    test('Should initialize successfully', () async {
      final container = await Bootstrap.initialize(
        environment: const EnvDev(),
      );
      
      expect(container, isNotNull);
    });
    
    test('Should handle initialization errors', () async {
      // تست خطاها
    });
  });
}
```

## دستورات Build و Test

### Development

```bash
# Run
flutter run --flavor dev -t lib/main_dev.dart

# Build APK
flutter build apk --flavor dev -t lib/main_dev.dart

# Build App Bundle
flutter build appbundle --flavor dev -t lib/main_dev.dart

# Install
flutter install --flavor dev
```

### Staging

```bash
# Run
flutter run --flavor staging -t lib/main_staging.dart

# Build APK
flutter build apk --flavor staging -t lib/main_staging.dart

# Build App Bundle
flutter build appbundle --flavor staging -t lib/main_staging.dart
```

### Production

```bash
# Run
flutter run --flavor prod -t lib/main_prod.dart

# Build APK (Release)
flutter build apk --flavor prod -t lib/main_prod.dart --release

# Build App Bundle (Release)
flutter build appbundle --flavor prod -t lib/main_prod.dart --release
```

## CI/CD Pipeline

### فایل: `.github/workflows/build.yml`

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        flavor: [dev, staging, prod]
    
    steps:
      - uses: actions/checkout@v3
      
      - uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '17'
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run tests
        run: flutter test
      
      - name: Build APK
        run: flutter build apk --flavor ${{ matrix.flavor }} -t lib/main_${{ matrix.flavor }}.dart
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: app-${{ matrix.flavor }}.apk
          path: build/app/outputs/flutter-apk/app-${{ matrix.flavor }}-release.apk
```

## بررسی نهایی

### چک‌لیست قبل از Release

#### Development
- [ ] اپلیکیشن با flavor dev اجرا می‌شود
- [ ] لاگ‌ها نمایش داده می‌شوند
- [ ] نام اپ "Zero Setup (Dev)" است
- [ ] آیکون آبی نمایش داده می‌شود
- [ ] می‌توان همزمان با staging/prod نصب کرد

#### Staging
- [ ] اپلیکیشن با flavor staging اجرا می‌شود
- [ ] Crashlytics فعال است
- [ ] نام اپ "Zero Setup (Staging)" است
- [ ] آیکون نارنجی نمایش داده می‌شود
- [ ] با staging API ارتباط برقرار می‌کند

#### Production
- [ ] اپلیکیشن با flavor prod اجرا می‌شود
- [ ] لاگ‌ها غیرفعال هستند
- [ ] Crashlytics فعال است
- [ ] Analytics فعال است
- [ ] نام اپ "Zero Setup" است
- [ ] آیکون اصلی نمایش داده می‌شود
- [ ] با production API ارتباط برقرار می‌کند
- [ ] ProGuard فعال است
- [ ] Code obfuscation انجام شده

## مستندسازی برای تیم

### فایل: `README_FLAVORS.md`

```markdown
# راهنمای Flavors و محیط‌ها

## محیط‌های موجود

### Development (dev)
- **هدف**: توسعه و debug
- **Package**: com.example.zero_setup_flutter.dev
- **API**: https://dev-api.example.com
- **نام**: Zero Setup (Dev)
- **رنگ آیکون**: آبی

### Staging (staging)
- **هدف**: تست قبل از production
- **Package**: com.example.zero_setup_flutter.staging
- **API**: https://staging-api.example.com
- **نام**: Zero Setup (Staging)
- **رنگ آیکون**: نارنجی

### Production (prod)
- **هدف**: نسخه نهایی
- **Package**: com.example.zero_setup_flutter
- **API**: https://api.example.com
- **نام**: Zero Setup
- **آیکون**: اصلی

## دستورات سریع

\`\`\`bash
# Development
flutter run --flavor dev

# Staging
flutter run --flavor staging

# Production
flutter run --flavor prod --release
\`\`\`

## تنظیمات IDE

در VS Code از Run Configurations استفاده کنید:
- کلید F5 برای اجرا
- انتخاب flavor از منوی بالا
```

## خطاهای رایج و راه‌حل

### خطا: "No flavor specified"

**راه‌حل**: همیشه `--flavor` را مشخص کنید
```bash
flutter run --flavor dev
```

### خطا: "Duplicate class found"

**راه‌حل**: `flutter clean` را اجرا کنید
```bash
flutter clean
flutter pub get
flutter run --flavor dev
```

### خطا: "BuildConfig not found"

**راه‌حل**: در `build.gradle.kts` اضافه کنید:
```kotlin
android {
    buildFeatures {
        buildConfig = true
    }
}
```

## بهینه‌سازی‌های پیشنهادی

### 1. Lazy Loading

```dart
class Bootstrap {
  static Future<void> initializeLazy() async {
    // سرویس‌های غیرضروری را بعداً مقداردهی کنید
    Future.delayed(const Duration(seconds: 2), () {
      // Initialize non-critical services
    });
  }
}
```

### 2. Parallel Initialization

```dart
static Future<void> _performInitialization() async {
  await Future.wait([
    BootstrapInitializers.initializePreferences(),
    BootstrapInitializers.initializeSecureStorage(),
    BootstrapInitializers.initializeDatabase(),
  ]);
}
```

### 3. Cache Warming

```dart
static Future<void> warmupCache() async {
  // پیش‌بارگذاری داده‌های مهم
  await Future.wait([
    _loadUserPreferences(),
    _loadCachedData(),
  ]);
}
```

## نتیجه‌گیری

با پیاده‌سازی کامل این سیستم:

✅ **مدیریت حرفه‌ای محیط‌ها**: جداسازی کامل dev, staging, production
✅ **Bootstrap تمیز**: راه‌اندازی منظم و قابل پیگیری
✅ **قابل نگهداری**: کد تمیز و مستند
✅ **قابل تست**: تست‌های جامع
✅ **قابل توسعه**: راحت می‌توان feature جدید اضافه کرد

## منابع بیشتر

- [Flutter Flavors Documentation](https://flutter.dev/docs/deployment/flavors)
- [Riverpod Documentation](https://riverpod.dev)
- [Android Build Variants](https://developer.android.com/studio/build/build-variants)

---

**پایان مستندات** 🎉

برای شروع پیاده‌سازی، به [مرحله 1](./01_environment_setup.md) مراجعه کنید.
