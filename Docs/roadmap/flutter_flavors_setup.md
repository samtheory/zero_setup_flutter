# 🌟 Flutter Flavors Setup Guide

## Overview

Flutter flavors allow you to create different versions of your app from the same codebase. Each flavor can have different configurations, assets, icons, and even different code paths. This is essential for managing development, staging, and production environments.

## 🎯 When & Why Use Flavors

### When to Use Flavors

1. **Multiple Environments**: Dev, Staging, Production
2. **Different App Stores**: Free vs Paid versions
3. **White-label Apps**: Different branding for clients
4. **Feature Flags**: Experimental features per environment
5. **Different API Endpoints**: Dev vs Prod APIs
6. **Different Configurations**: Analytics, crash reporting, etc.

### Why Flavors Matter

- ✅ **Environment Separation**: Clean dev/staging/prod isolation
- ✅ **Safe Deployments**: Test in staging before production
- ✅ **Feature Testing**: Enable/disable features per environment
- ✅ **App Store Management**: Different apps for different markets
- ✅ **Cost Optimization**: Use free tiers in dev, paid in prod
- ✅ **Security**: Different API keys per environment

---

## 📋 Flavors Setup

### Step 1: Update pubspec.yaml

Add flavors configuration:

```yaml
name: zero_setup_flutter
description: "A Template Flutter project."

# Remove version from here - define per flavor
# version: 0.0.1+1

flavorDimensions: "environment"

flavors:
  dev:
    app:
      name: "Zero Setup Dev"
    android:
      applicationId: "com.example.zero_setup_flutter.dev"
      versionCode: 1
      versionName: "1.0.0-dev"
    ios:
      bundleId: "com.example.zeroSetupFlutter.dev"
      version: "1.0.0-dev"
      buildNumber: "1"
    macos:
      bundleId: "com.example.zeroSetupFlutter.dev"
    windows:
      applicationId: "com.example.zeroSetupFlutter.dev"

  staging:
    app:
      name: "Zero Setup Staging"
    android:
      applicationId: "com.example.zero_setup_flutter.staging"
      versionCode: 1
      versionName: "1.0.0-staging"
    ios:
      bundleId: "com.example.zeroSetupFlutter.staging"
      version: "1.0.0-staging"
      buildNumber: "1"
    macos:
      bundleId: "com.example.zeroSetupFlutter.staging"
    windows:
      applicationId: "com.example.zeroSetupFlutter.staging"

  prod:
    app:
      name: "Zero Setup Flutter"
    android:
      applicationId: "com.example.zero_setup_flutter"
      versionCode: 1
      versionName: "1.0.0"
    ios:
      bundleId: "com.example.zeroSetupFlutter"
      version: "1.0.0"
      buildNumber: "1"
    macos:
      bundleId: "com.example.zeroSetupFlutter"
    windows:
      applicationId: "com.example.zeroSetupFlutter"
```

### Step 2: Environment Configuration with Envied

Create environment files:

**lib/core/config/env/.env.dev**
```env
# API Configuration
API_BASE_URL=https://api-dev.example.com
API_TIMEOUT=30000

# Authentication
AUTH_CLIENT_ID=dev_client_id
AUTH_CLIENT_SECRET=dev_client_secret

# Analytics
ANALYTICS_ENABLED=false
ANALYTICS_API_KEY=dev_analytics_key

# Logging
LOG_LEVEL=verbose
LOG_TO_FILE=true

# Features
EXPERIMENTAL_FEATURES=true
DEBUG_MODE=true
```

**lib/core/config/env/.env.staging**
```env
# API Configuration
API_BASE_URL=https://api-staging.example.com
API_TIMEOUT=30000

# Authentication
AUTH_CLIENT_ID=staging_client_id
AUTH_CLIENT_SECRET=staging_client_secret

# Analytics
ANALYTICS_ENABLED=true
ANALYTICS_API_KEY=staging_analytics_key

# Logging
LOG_LEVEL=info
LOG_TO_FILE=false

# Features
EXPERIMENTAL_FEATURES=false
DEBUG_MODE=false
```

**lib/core/config/env/.env.prod**
```env
# API Configuration
API_BASE_URL=https://api.example.com
API_TIMEOUT=15000

# Authentication
AUTH_CLIENT_ID=prod_client_id
AUTH_CLIENT_SECRET=prod_client_secret

# Analytics
ANALYTICS_ENABLED=true
ANALYTICS_API_KEY=prod_analytics_key

# Logging
LOG_LEVEL=warning
LOG_TO_FILE=false

# Features
EXPERIMENTAL_FEATURES=false
DEBUG_MODE=false
```

### Step 3: Environment Class with Envied

**lib/core/config/env/env.dart**
```dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', useConstantCase: true)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'API_TIMEOUT')
  static const int apiTimeout = _Env.apiTimeout;

  @EnviedField(varName: 'AUTH_CLIENT_ID')
  static const String authClientId = _Env.authClientId;

  @EnviedField(varName: 'AUTH_CLIENT_SECRET')
  static const String authClientSecret = _Env.authClientSecret;

  @EnviedField(varName: 'ANALYTICS_ENABLED')
  static const bool analyticsEnabled = _Env.analyticsEnabled;

  @EnviedField(varName: 'ANALYTICS_API_KEY')
  static const String analyticsApiKey = _Env.analyticsApiKey;

  @EnviedField(varName: 'LOG_LEVEL')
  static const String logLevel = _Env.logLevel;

  @EnviedField(varName: 'LOG_TO_FILE')
  static const bool logToFile = _Env.logToFile;

  @EnviedField(varName: 'EXPERIMENTAL_FEATURES')
  static const bool experimentalFeatures = _Env.experimentalFeatures;

  @EnviedField(varName: 'DEBUG_MODE')
  static const bool debugMode = _Env.debugMode;
}
```

### Step 4: Flavor-Specific Assets

Create flavor-specific asset folders:

```
assets/
├── dev/
│   ├── images/
│   │   ├── logo.png
│   │   └── splash.png
│   └── config/
│       └── app_config.json
├── staging/
│   ├── images/
│   │   ├── logo.png
│   │   └── splash.png
│   └── config/
│       └── app_config.json
└── prod/
    ├── images/
      ├── logo.png
      └── splash.png
    └── config/
        └── app_config.json
```

Update pubspec.yaml assets:

```yaml
flutter:
  assets:
    # Flavor-specific assets
    - assets/dev/
    - assets/staging/
    - assets/prod/
```

### Step 5: Flavor-Specific Icons

Create flavor-specific launcher icons:

```
android/app/src/dev/res/mipmap-xxxhdpi/ic_launcher.png
android/app/src/staging/res/mipmap-xxxhdpi/ic_launcher.png
android/app/src/prod/res/mipmap-xxxhdpi/ic_launcher.png

ios/Runner/Assets.xcassets/AppIcon-dev.appiconset/
ios/Runner/Assets.xcassets/AppIcon-staging.appiconset/
ios/Runner/Assets.xcassets/AppIcon-prod.appiconset/
```

### Step 6: Android Configuration

**android/app/build.gradle**
```gradle
android {
    flavorDimensions "environment"

    productFlavors {
        dev {
            dimension "environment"
            applicationId "com.example.zero_setup_flutter.dev"
            versionCode 1
            versionName "1.0.0-dev"
            resValue "string", "app_name", "Zero Setup Dev"
        }

        staging {
            dimension "environment"
            applicationId "com.example.zero_setup_flutter.staging"
            versionCode 1
            versionName "1.0.0-staging"
            resValue "string", "app_name", "Zero Setup Staging"
        }

        prod {
            dimension "environment"
            applicationId "com.example.zero_setup_flutter"
            versionCode 1
            versionName "1.0.0"
            resValue "string", "app_name", "Zero Setup Flutter"
        }
    }
}
```

### Step 7: iOS Configuration

**ios/Runner.xcodeproj/xcshareddata/xcschemes/**
Create separate schemes for each flavor:

- zero_setup_flutter_dev.xcscheme
- zero_setup_flutter_staging.xcscheme
- zero_setup_flutter_prod.xcscheme

**ios/Flutter/Dev.xcconfig**
```xcconfig
#include "Generated.xcconfig"

FLUTTER_TARGET=lib/main_dev.dart
BUNDLE_DISPLAY_NAME=Zero Setup Dev
PRODUCT_BUNDLE_IDENTIFIER=com.example.zeroSetupFlutter.dev
```

**ios/Flutter/Staging.xcconfig**
```xcconfig
#include "Generated.xcconfig"

FLUTTER_TARGET=lib/main_staging.dart
BUNDLE_DISPLAY_NAME=Zero Setup Staging
PRODUCT_BUNDLE_IDENTIFIER=com.example.zeroSetupFlutter.staging
```

**ios/Flutter/Release.xcconfig**
```xcconfig
#include "Generated.xcconfig"

FLUTTER_TARGET=lib/main_prod.dart
BUNDLE_DISPLAY_NAME=Zero Setup Flutter
PRODUCT_BUNDLE_IDENTIFIER=com.example.zeroSetupFlutter
```

### Step 8: Flavor-Specific Entry Points

**lib/main_dev.dart**
```dart
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/config/env/env.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize with dev environment
  await _initializeApp(Environment.dev);

  runApp(
    ProviderScope(
      observers: [talkerRiverpodObserver],
      child: const App(),
    ),
  );
}
```

**lib/main_staging.dart**
```dart
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/config/env/env.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize with staging environment
  await _initializeApp(Environment.staging);

  runApp(
    ProviderScope(
      observers: [talkerRiverpodObserver],
      child: const App(),
    ),
  );
}
```

**lib/main_prod.dart**
```dart
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/config/env/env.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize with prod environment
  await _initializeApp(Environment.prod);

  runApp(
    ProviderScope(
      observers: [talkerRiverpodObserver],
      child: const App(),
    ),
  );
}
```

### Step 9: Environment Manager

**lib/core/config/environment.dart**
```dart
enum Environment {
  dev,
  staging,
  prod;

  String get name {
    switch (this) {
      case Environment.dev:
        return 'Development';
      case Environment.staging:
        return 'Staging';
      case Environment.prod:
        return 'Production';
    }
  }

  bool get isDev => this == Environment.dev;
  bool get isStaging => this == Environment.staging;
  bool get isProd => this == Environment.prod;

  bool get enableLogging => isDev || isStaging;
  bool get enableAnalytics => !isDev;
  bool get enableCrashReporting => !isDev;
}

class EnvironmentManager {
  static Environment? _currentEnvironment;

  static Environment get current => _currentEnvironment ?? Environment.dev;

  static void setEnvironment(Environment environment) {
    _currentEnvironment = environment;
  }

  static String getAssetPath(String asset, {Environment? environment}) {
    final env = environment ?? current;
    return 'assets/${env.name.toLowerCase()}/$asset';
  }
}
```

---

## 🚀 Build & Run Commands

### Android Commands

```bash
# Development
flutter run --flavor dev --target lib/main_dev.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor prod --target lib/main_prod.dart

# Build APKs
flutter build apk --flavor dev --target lib/main_dev.dart
flutter build apk --flavor staging --target lib/main_staging.dart
flutter build apk --flavor prod --target lib/main_prod.dart

# Build App Bundles
flutter build appbundle --flavor dev --target lib/main_dev.dart
flutter build appbundle --flavor staging --target lib/main_staging.dart
flutter build appbundle --flavor prod --target lib/main_prod.dart
```

### iOS Commands

```bash
# Development
flutter run --flavor dev --target lib/main_dev.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor prod --target lib/main_prod.dart

# Build for iOS
flutter build ios --flavor dev --target lib/main_dev.dart
flutter build ios --flavor staging --target lib/main_staging.dart
flutter build ios --flavor prod --target lib/main_prod.dart
```

### Web Commands

```bash
# Development
flutter run -d chrome --flavor dev --target lib/main_dev.dart

# Staging
flutter run -d chrome --flavor staging --target lib/main_staging.dart

# Production
flutter run -d chrome --flavor prod --target lib/main_prod.dart

# Build for web
flutter build web --flavor dev --target lib/main_dev.dart
flutter build web --flavor staging --target lib/main_staging.dart
flutter build web --flavor prod --target lib/main_prod.dart
```

### VS Code Launch Configurations

**.vscode/launch.json**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dev",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart",
      "args": ["--flavor", "dev"]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_staging.dart",
      "args": ["--flavor", "staging"]
    },
    {
      "name": "Prod",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_prod.dart",
      "args": ["--flavor", "prod"]
    }
  ]
}
```

---

## 🔧 Development Debug Setup

### 1. Environment Banner

**lib/app/app.dart** - Add environment indicator:

```dart
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment = EnvironmentManager.current;

    return MaterialApp.router(
      title: 'Zero Setup Flutter',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            if (!environment.isProd)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: environment.isDev ? Colors.red : Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    environment.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
```

### 2. Debug Menu

**lib/shared/widgets/debug_menu.dart**
```dart
class DebugMenu extends StatelessWidget {
  const DebugMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final environment = EnvironmentManager.current;

    if (environment.isProd) return const SizedBox.shrink();

    return Positioned(
      bottom: 100,
      right: 16,
      child: FloatingActionButton(
        onPressed: () => _showDebugMenu(context),
        child: const Icon(Icons.bug_report),
      ),
    );
  }

  void _showDebugMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const DebugOptionsSheet(),
    );
  }
}
```

### 3. Logging Configuration

**lib/core/logger/app_logger.dart** - Environment-aware logging:

```dart
final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    enabled: EnvironmentManager.current.enableLogging,
    useHistory: EnvironmentManager.current.isDev,
    maxHistoryItems: EnvironmentManager.current.isDev ? 500 : 100,
    useConsoleLogs: EnvironmentManager.current.enableLogging,
  ),
  logger: TalkerLogger(
    output: debugPrint,
    settings: TalkerLoggerSettings(
      enableColors: EnvironmentManager.current.isDev,
      maxLineWidth: 120,
    ),
  ),
);
```

---

## 🔄 Passing Different Environments

### 1. Runtime Environment Detection

**lib/core/config/environment_detector.dart**
```dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class EnvironmentDetector {
  static Environment detectEnvironment() {
    // Web environment detection
    if (kIsWeb) {
      final hostname = Uri.base.host;
      if (hostname.contains('dev') || hostname.contains('localhost')) {
        return Environment.dev;
      } else if (hostname.contains('staging')) {
        return Environment.staging;
      } else {
        return Environment.prod;
      }
    }

    // Mobile environment detection via build flavor
    if (Platform.isAndroid) {
      // Check package name
      // This requires platform-specific code
      return _detectAndroidEnvironment();
    } else if (Platform.isIOS) {
      return _detectIosEnvironment();
    }

    return Environment.dev; // Default fallback
  }

  static Environment _detectAndroidEnvironment() {
    // Implementation would check BuildConfig.FLAVOR
    // For now, return based on main entry point
    return Environment.dev;
  }

  static Environment _detectIosEnvironment() {
    // Implementation would check bundle identifier
    return Environment.dev;
  }
}
```

### 2. Dynamic Asset Loading

**lib/core/utils/asset_loader.dart**
```dart
class AssetLoader {
  static String getAssetPath(String asset) {
    final environment = EnvironmentManager.current;
    return 'assets/${environment.name.toLowerCase()}/$asset';
  }

  static Future<String> loadConfigFile(String filename) async {
    final path = getAssetPath('config/$filename');
    return rootBundle.loadString(path);
  }

  static ImageProvider getImageProvider(String imageName) {
    final path = getAssetPath('images/$imageName');
    return AssetImage(path);
  }
}
```

### 3. Feature Flags Based on Environment

**lib/core/config/feature_flags.dart**
```dart
class FeatureFlags {
  static bool get experimentalFeatures =>
      EnvironmentManager.current.isDev || Env.experimentalFeatures;

  static bool get analyticsEnabled =>
      EnvironmentManager.current.enableAnalytics && Env.analyticsEnabled;

  static bool get crashReportingEnabled =>
      EnvironmentManager.current.enableCrashReporting;

  static bool get debugMode =>
      EnvironmentManager.current.isDev || Env.debugMode;
}
```

---

## 📊 Environment-Specific Configurations

### API Client Configuration

**lib/core/network/dio_client.dart**
```dart
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Env.apiBaseUrl,
        connectTimeout: Duration(milliseconds: Env.apiTimeout),
        receiveTimeout: Duration(milliseconds: Env.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (Env.authClientId.isNotEmpty)
            'X-Client-ID': Env.authClientId,
        },
      ),
    );

    // Add interceptors based on environment
    if (EnvironmentManager.current.enableLogging) {
      _dio.interceptors.add(TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: EnvironmentManager.current.isDev,
          printResponseHeaders: EnvironmentManager.current.isDev,
          printRequestData: EnvironmentManager.current.isDev,
          printResponseData: EnvironmentManager.current.isDev,
        ),
      ));
    }

    // Add auth interceptor
    _dio.interceptors.add(AuthInterceptor());
  }

  Dio get dio => _dio;
}
```

### Analytics Configuration

**lib/core/analytics/analytics_service.dart**
```dart
class AnalyticsService {
  static Future<void> initialize() async {
    if (!FeatureFlags.analyticsEnabled) return;

    // Initialize analytics based on environment
    switch (EnvironmentManager.current) {
      case Environment.dev:
        // Use debug analytics
        break;
      case Environment.staging:
      case Environment.prod:
        // Use production analytics
        await _initializeProductionAnalytics();
        break;
    }
  }

  static Future<void> _initializeProductionAnalytics() async {
    // Initialize Firebase Analytics, Mixpanel, etc.
  }

  static void trackEvent(String event, Map<String, dynamic> parameters) {
    if (!FeatureFlags.analyticsEnabled) return;

    // Track event with environment context
    final envParams = {
      ...parameters,
      'environment': EnvironmentManager.current.name,
      'version': Env.version,
    };

    // Send to analytics service
  }
}
```

---

## 🧪 Testing with Flavors

### Unit Tests with Environment

**test/core/config/environment_test.dart**
```dart
void main() {
  group('Environment', () {
    test('dev environment has correct properties', () {
      EnvironmentManager.setEnvironment(Environment.dev);

      expect(EnvironmentManager.current, Environment.dev);
      expect(EnvironmentManager.current.isDev, true);
      expect(EnvironmentManager.current.enableLogging, true);
      expect(EnvironmentManager.current.enableAnalytics, false);
    });

    test('prod environment has correct properties', () {
      EnvironmentManager.setEnvironment(Environment.prod);

      expect(EnvironmentManager.current, Environment.prod);
      expect(EnvironmentManager.current.isProd, true);
      expect(EnvironmentManager.current.enableLogging, false);
      expect(EnvironmentManager.current.enableAnalytics, true);
    });
  });
}
```

### Integration Tests

**integration_test/app_test.dart**
```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('app starts with correct environment banner',
        (tester) async {
      EnvironmentManager.setEnvironment(Environment.dev);

      await tester.pumpWidget(const MyApp());

      // Check for dev banner
      expect(find.text('Development'), findsOneWidget);
    });
  });
}
```

---

## 🚀 CI/CD with Flavors

### GitHub Actions Example

**.github/workflows/build.yml**
```yaml
name: Build and Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.1'

      - name: Run tests
        run: flutter test --coverage

  build-dev:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.1'

      - name: Build Android Dev APK
        run: flutter build apk --flavor dev --target lib/main_dev.dart

      - name: Upload Dev APK
        uses: actions/upload-artifact@v3
        with:
          name: dev-apk
          path: build/app/outputs/flutter-apk/app-dev-release.apk

  build-prod:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.1'

      - name: Build Android Prod AAB
        run: flutter build appbundle --flavor prod --target lib/main_prod.dart

      - name: Upload to Play Store
        # Use appropriate action for Play Store deployment
```

---

## 📋 Quick Reference

### Environment Variables
- Use `.env` files for each flavor
- Generate with `envied_generator`
- Access via `Env` class

### Build Commands
```bash
# Android
flutter build apk --flavor dev --target lib/main_dev.dart

# iOS
flutter build ios --flavor prod --target lib/main_prod.dart

# Web
flutter build web --flavor staging --target lib/main_staging.dart
```

### Common Issues
1. **Flavor not recognized**: Check `pubspec.yaml` flavor configuration
2. **Assets not loading**: Verify asset paths in `pubspec.yaml`
3. **Icons not changing**: Check launcher icon paths per flavor
4. **Environment not detected**: Implement proper environment detection

### Best Practices
- ✅ Keep flavors simple - don't over-engineer
- ✅ Use environment variables for configuration
- ✅ Test all flavors regularly
- ✅ Document flavor-specific behavior
- ✅ Use CI/CD for automated builds
- ✅ Separate app store listings per flavor

This setup provides a robust foundation for managing multiple environments while maintaining code quality and developer productivity.</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\Docs\roadmap\flutter_flavors_setup.md