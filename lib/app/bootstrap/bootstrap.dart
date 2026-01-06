import 'package:flutter/widgets.dart';
import 'package:zero_setup_flutter/app/config/app_config.dart';
import 'package:zero_setup_flutter/app/config/env/env.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';
import 'package:zero_setup_flutter/core/storage/secure_storage_service.dart';

/// Bootstrap data returned after initialization
class BootstrapData {
  final PreferencesService preferencesService;
  final SecureStorageService secureStorage;

  const BootstrapData({required this.preferencesService, required this.secureStorage});
}

/// Main Bootstrap class for application initialization
/// Uses Talker for logging
class Bootstrap {
  Bootstrap._();

  static bool _isInitialized = false;

  /// Check if bootstrap has completed
  static bool get isInitialized => _isInitialized;

  /// Initialize the application with environment configuration
  static Future<BootstrapData> initialize({required Env environment}) async {
    final stopwatch = Stopwatch()..start();

    // Ensure Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    talker.info('🚀 Bootstrap started for ${environment.name} environment');

    try {
      // 1. Initialize app configuration
      talker.debug('Initializing app configuration...');
      AppConfig.initialize(environment);
      talker.good('✓ App configuration initialized');

      // 2. Initialize storage services
      talker.debug('Initializing storage services...');
      final preferencesService = PreferencesService();
      await preferencesService.init();
      final secureStorage = SecureStorageService();
      talker.good('✓ Storage services initialized');

      _isInitialized = true;
      stopwatch.stop();
      talker.good('🎉 Bootstrap completed in ${stopwatch.elapsedMilliseconds}ms');

      return BootstrapData(preferencesService: preferencesService, secureStorage: secureStorage);
    } catch (error, stackTrace) {
      talker.error('Bootstrap failed', error, stackTrace);
      rethrow;
    }
  }
}
