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
  String get bundleId => 'com.example.zero_setup_flutter';

  // ==================== Feature Flags ====================

  @override
  bool get showRuntimeLog => false;

  @override
  bool get showNetworkLog => false;

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
