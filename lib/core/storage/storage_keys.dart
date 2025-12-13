// lib/core/storage/storage_keys.dart

abstract class StorageKeys {
  // ═══════════════════════════════════════════
  // Secure Keys (flutter_secure_storage)
  // ═══════════════════════════════════════════
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const userPin = 'user_pin';

  // ═══════════════════════════════════════════
  // Regular Keys (shared_preferences)
  // ═══════════════════════════════════════════
  static const themeMode = 'theme_mode';        // 'light' | 'dark' | 'system'
  static const locale = 'locale';                // 'fa' | 'en'
  static const isFirstLaunch = 'is_first_launch';
  static const userId = 'user_id';
  static const userJson = 'user_json';           // Cached user profile
  static const lastSyncTime = 'last_sync_time';
}
