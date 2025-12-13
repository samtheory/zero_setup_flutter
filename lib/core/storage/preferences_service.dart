import 'package:shared_preferences/shared_preferences.dart';

import 'storage_keys.dart';

/// Service برای ذخیره Settings و Preferences
class PreferencesService {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  void _ensureInitialized() {
    if (_prefs == null) {
      throw StateError(
        'PreferencesService not initialized! '
        'Call await preferencesService.init() first.',
      );
    }
  }

  // ═══════════════════════════════════════════════════════════
  // Theme
  // ═══════════════════════════════════════════════════════════

  Future<void> setThemeMode(String mode) async {
    _ensureInitialized();
    await _prefs!.setString(StorageKeys.themeMode, mode);
  }

  String getThemeMode() {
    _ensureInitialized();
    return _prefs!.getString(StorageKeys.themeMode) ?? 'system';
  }

  // ═══════════════════════════════════════════════════════════
  // Locale
  // ═══════════════════════════════════════════════════════════

  Future<void> setLocale(String locale) async {
    _ensureInitialized();
    await _prefs!.setString(StorageKeys.locale, locale);
  }

  String getLocale() {
    _ensureInitialized();
    return _prefs!.getString(StorageKeys.locale) ?? 'fa';
  }

  // ═══════════════════════════════════════════════════════════
  // First Launch / Onboarding
  // ═══════════════════════════════════════════════════════════

  Future<void> setFirstLaunchComplete() async {
    _ensureInitialized();
    await _prefs!.setBool(StorageKeys.isFirstLaunch, false);
  }

  bool isFirstLaunch() {
    _ensureInitialized();
    return _prefs!.getBool(StorageKeys.isFirstLaunch) ?? true;
  }

  Future<void> setOnboardingComplete() async {
    _ensureInitialized();
    await _prefs!.setBool(StorageKeys.isOnboardingComplete, true);
  }

  bool isOnboardingComplete() {
    _ensureInitialized();
    return _prefs!.getBool(StorageKeys.isOnboardingComplete) ?? false;
  }

  // ═══════════════════════════════════════════════════════════
  // Generic Methods
  // ═══════════════════════════════════════════════════════════

  Future<void> setString(String key, String value) async {
    _ensureInitialized();
    await _prefs!.setString(key, value);
  }

  String? getString(String key) {
    _ensureInitialized();
    return _prefs!.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    _ensureInitialized();
    await _prefs!.setBool(key, value);
  }

  bool? getBool(String key) {
    _ensureInitialized();
    return _prefs!.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    _ensureInitialized();
    await _prefs!.setInt(key, value);
  }

  int? getInt(String key) {
    _ensureInitialized();
    return _prefs!.getInt(key);
  }

  Future<void> clearAll() async {
    _ensureInitialized();
    await _prefs!.clear();
  }

  Future<void> remove(String key) async {
    _ensureInitialized();
    await _prefs!.remove(key);
  }
}
