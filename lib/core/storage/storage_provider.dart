// lib/core/storage/storage_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:zero_setup_flutter/core/storage/storage_keys.dart';
import 'package:zero_setup_flutter/core/storage/storage_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

// ═══════════════════════════════════════════
// Convenience Providers
// ═══════════════════════════════════════════

final accessTokenProvider = FutureProvider<String?>((ref) async {
  final storage = ref.watch(storageServiceProvider);
  return storage.getSecure(StorageKeys.accessToken);
});

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return ThemeModeNotifier(storage);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final StorageService _storage;

  ThemeModeNotifier(this._storage) : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    final value = await _storage.getString(StorageKeys.themeMode);
    state = _parseThemeMode(value);
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await _storage.setString(StorageKeys.themeMode, mode.name);
  }

  ThemeMode _parseThemeMode(String? value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
