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
  String get bundleId => 'com.example.zero_setup_flutter.staging';

  // ==================== Feature Flags ====================

  @override
  bool get showRuntimeLog => true;

  @override
  bool get showNetworkLog => true;

  @override
  bool get enableCrashlytics => true;

  @override
  bool get enableAnalytics => false;

  @override
  bool get debugMode => false;

  // ==================== Storage Configuration ====================

  @override
  String get databaseName => 'zero_setup_staging.db';

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
