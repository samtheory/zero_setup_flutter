/// کلیدهای Storage - یه جا، تمیز، بدون اشتباه تایپی
abstract final class StorageKeys {
  // ═══════════════════════════════════════════════════════════
  // Secure Storage Keys (Tokens & Secrets)
  // ═══════════════════════════════════════════════════════════
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';

  // ═══════════════════════════════════════════════════════════
  // Shared Preferences Keys (Settings & Flags)
  // ═══════════════════════════════════════════════════════════
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
  static const String isFirstLaunch = 'is_first_launch';
  static const String isOnboardingComplete = 'is_onboarding_complete';
}
