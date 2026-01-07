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
  String get bundleId => 'com.example.zero_setup_flutter.dev';

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
  String? get googleMapsApiKey => null;

  @override
  String? get firebaseApiKey => null;

  @override
  String? get sentryDsn => null;

  @override
  Map<String, dynamic> toMap() => {
    'name': name,
    'isDevelopment': isDevelopment,
    'isStaging': isStaging,
    'isProduction': isProduction,
    'baseUrl': baseUrl,
    'appName': appName,
    'debugMode': debugMode,
  };
}
