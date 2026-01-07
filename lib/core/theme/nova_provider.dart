import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nova_theme.dart';

/// Theme mode storage key
const _themeModeKey = 'nova_theme_mode';

/// Theme mode provider - persists theme preference
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

/// Theme mode notifier with persistence
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.system;
  }

  /// Load saved theme mode from storage
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeModeKey);
    if (savedMode != null) {
      state = ThemeMode.values.firstWhere((mode) => mode.name == savedMode, orElse: () => ThemeMode.system);
    }
  }

  /// Save theme mode to storage
  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.name);
  }

  /// Set light theme
  void setLight() {
    state = ThemeMode.light;
    _saveThemeMode(state);
  }

  /// Set dark theme
  void setDark() {
    state = ThemeMode.dark;
    _saveThemeMode(state);
  }

  /// Set system theme (follows device)
  void setSystem() {
    state = ThemeMode.system;
    _saveThemeMode(state);
  }

  /// Toggle between light and dark
  void toggle() {
    if (state == ThemeMode.light) {
      setDark();
    } else {
      setLight();
    }
  }

  /// Cycle through all modes: system -> light -> dark -> system
  void cycle() {
    switch (state) {
      case ThemeMode.system:
        setLight();
      case ThemeMode.light:
        setDark();
      case ThemeMode.dark:
        setSystem();
    }
  }
}

/// Current theme data provider
final novaThemeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  switch (themeMode) {
    case ThemeMode.light:
      return novaLightTheme;
    case ThemeMode.dark:
      return novaDarkTheme;
    case ThemeMode.system:
      // Default to light, actual system theme handled by MaterialApp
      return novaLightTheme;
  }
});

/// Check if currently dark mode
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode == ThemeMode.dark;
});
