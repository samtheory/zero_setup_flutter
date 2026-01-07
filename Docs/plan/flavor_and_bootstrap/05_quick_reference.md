# Quick Reference Guide - Flavor & Bootstrap System

## 📋 Overview
This guide provides quick commands and configurations for working with the flavor and bootstrap system.

## 🚀 Running the App

### Development Environment
```bash
# Debug mode
flutter run --flavor dev -t lib/main_dev.dart

# Profile mode
flutter run --flavor dev -t lib/main_dev.dart --profile

# Via VS Code: Select "Dev (Development)" from Run menu
```

### Staging Environment
```bash
# Debug mode
flutter run --flavor staging -t lib/main_staging.dart

# Via VS Code: Select "Staging" from Run menu
```

### Production Environment
```bash
# Debug mode
flutter run --flavor prod -t lib/main_prod.dart

# Release mode
flutter run --flavor prod -t lib/main_prod.dart --release

# Via VS Code: Select "Prod (Production)" from Run menu
```

## 🔨 Building the App

### Build APK
```bash
# Development
flutter build apk --flavor dev -t lib/main_dev.dart

# Staging
flutter build apk --flavor staging -t lib/main_staging.dart

# Production (Release)
flutter build apk --flavor prod -t lib/main_prod.dart --release
```

### Build App Bundle (AAB)
```bash
# Development
flutter build appbundle --flavor dev -t lib/main_dev.dart

# Staging
flutter build appbundle --flavor staging -t lib/main_staging.dart

# Production (Release)
flutter build appbundle --flavor prod -t lib/main_prod.dart --release
```

## 📦 Package IDs
Each flavor has a unique package ID to allow simultaneous installation:

- **Dev**: `com.example.zero_setup_flutter.dev`
- **Staging**: `com.example.zero_setup_flutter.staging`
- **Prod**: `com.example.zero_setup_flutter`

## 📱 App Names
Each flavor displays a different app name:

- **Dev**: "Zero Setup (Dev)"
- **Staging**: "Zero Setup (Staging)"
- **Prod**: "Zero Setup"

## 🔧 Environment Configuration

### API Endpoints
```dart
// Development
baseUrl: 'https://dev-api.example.com'

// Staging
baseUrl: 'https://staging-api.example.com'

// Production
baseUrl: 'https://api.example.com'
```

### Feature Flags
```dart
// Development
showRuntimeLog: true
showNetworkLog: true
enableCrashlytics: false
enableAnalytics: false
debugMode: true

// Staging
showRuntimeLog: true
showNetworkLog: true
enableCrashlytics: true  // Enable for testing
enableAnalytics: false
debugMode: true

// Production
showRuntimeLog: false
showNetworkLog: false
enableCrashlytics: true
enableAnalytics: true
debugMode: false
```

## 🏗️ Project Structure

### Configuration Files
```
lib/config/
├── app_config.dart           # Global singleton configuration manager
└── env/
    ├── env.dart              # Base environment interface
    ├── env_dev.dart          # Development configuration
    ├── env_staging.dart      # Staging configuration
    └── env_prod.dart         # Production configuration
```

### Bootstrap System
```
lib/core/bootstrap/
├── bootstrap.dart                    # Main bootstrap class
├── bootstrap_config.dart             # Configuration model
├── bootstrap_logger.dart             # Logging system
├── bootstrap_error_handler.dart      # Error handling
└── bootstrap_initializers.dart       # Service initializers
```

### Entry Points
```
lib/
├── main_dev.dart       # Development entry point
├── main_staging.dart   # Staging entry point
└── main_prod.dart      # Production entry point
```

### Android Flavors
```
android/app/
├── build.gradle.kts              # Flavor configuration
└── src/
    ├── dev/res/values/strings.xml
    ├── staging/res/values/strings.xml
    └── prod/res/values/strings.xml
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests (by flavor)
```bash
# Development
flutter test integration_test --flavor dev -t lib/main_dev.dart

# Staging
flutter test integration_test --flavor staging -t lib/main_staging.dart

# Production
flutter test integration_test --flavor prod -t lib/main_prod.dart
```

## 🐛 Troubleshooting

### Clean Build
If you encounter build issues:
```bash
flutter clean
flutter pub get
flutter run --flavor dev -t lib/main_dev.dart
```

### Gradle Issues
```bash
cd android
./gradlew clean
cd ..
flutter run --flavor dev -t lib/main_dev.dart
```

### Reset Android Build
```bash
rm -rf android/build
rm -rf build
flutter clean
flutter pub get
```

## 📝 Common Tasks

### Add New Environment Variable
1. Add property to `lib/config/env/env.dart`
2. Implement in `env_dev.dart`, `env_staging.dart`, `env_prod.dart`
3. Update `toMap()` method if needed

### Add New Service Initializer
1. Open `lib/core/bootstrap/bootstrap_initializers.dart`
2. Create new `initializeXxx()` method
3. Add to `initializeAll()` sequence
4. Handle errors with `errorHandler.handleError()`

### Change App Name
Update the following files:
- `android/app/src/dev/res/values/strings.xml`
- `android/app/src/staging/res/values/strings.xml`
- `android/app/src/prod/res/values/strings.xml`

### Change Package ID
Update `android/app/build.gradle.kts`:
```kotlin
defaultConfig {
    applicationId = "com.yourcompany.yourapp"
}
```

## 🔐 Security Best Practices

1. **Never commit secrets**: Use environment variables or secure storage
2. **API Keys**: Store in secure backend, not in app config
3. **Signing Keys**: Keep production keys separate and secure
4. **Obfuscation**: Enable for production builds:
   ```bash
   flutter build apk --flavor prod -t lib/main_prod.dart --obfuscate --split-debug-info=build/debug-info
   ```

## 📚 Documentation
For detailed information, see:
- [Overview](00_overview.md)
- [Environment Setup](01_environment_setup.md)
- [Android Flavors](02_android_flavors.md)
- [Bootstrap System](03_bootstrap_system.md)
- [Integration & Testing](04_integration_testing.md)

## 🎯 Next Steps

1. ✅ Update API endpoints in environment files
2. ✅ Configure Firebase for each environment
3. ✅ Set up signing configs for production
4. ✅ Add integration tests
5. ✅ Configure CI/CD pipeline
6. ✅ Test all three flavors on devices
