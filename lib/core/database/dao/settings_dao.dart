import 'dart:convert';

import 'package:drift/drift.dart';

import '../app_database.dart';

// ═══════════════════════════════════════════════════════════════════════════
// SETTINGS DAO (Data Access Object)
//
// Key-value storage in SQLite with JSON support.
// Alternative to SharedPreferences with better querying capabilities.
// ═══════════════════════════════════════════════════════════════════════════

part 'settings_dao.g.dart';

@DriftAccessor(tables: [Settings])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  // ═══════════════════════════════════════════════════════════════════════════
  // STRING
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setString(String key, String value) async {
    await into(
      settings,
    ).insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value, valueType: const Value('string')));
  }

  Future<String?> getString(String key) async {
    final setting = await (select(settings)..where((t) => t.key.equals(key))).getSingleOrNull();
    return setting?.value;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // INT
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setInt(String key, int value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: value.toString(), valueType: const Value('int')),
    );
  }

  Future<int?> getInt(String key) async {
    final value = await getString(key);
    return value != null ? int.tryParse(value) : null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DOUBLE
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setDouble(String key, double value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: value.toString(), valueType: const Value('double')),
    );
  }

  Future<double?> getDouble(String key) async {
    final value = await getString(key);
    return value != null ? double.tryParse(value) : null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOOL
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setBool(String key, bool value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: value.toString(), valueType: const Value('bool')),
    );
  }

  Future<bool?> getBool(String key) async {
    final value = await getString(key);
    return value != null ? value == 'true' : null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // JSON (Map<String, dynamic>)
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: json.encode(value), valueType: const Value('json')),
    );
  }

  Future<Map<String, dynamic>?> getJson(String key) async {
    final value = await getString(key);
    if (value == null) return null;

    try {
      return json.decode(value) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIST (List<dynamic>)
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setList(String key, List<dynamic> value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: key, value: json.encode(value), valueType: const Value('list')),
    );
  }

  Future<List<dynamic>?> getList(String key) async {
    final value = await getString(key);
    if (value == null) return null;

    try {
      return json.decode(value) as List<dynamic>;
    } catch (_) {
      return null;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ═══════════════════════════════════════════════════════════════════════════

  /// Delete a setting
  Future<int> deleteSetting(String key) {
    return (delete(settings)..where((t) => t.key.equals(key))).go();
  }

  /// Check if setting exists
  Future<bool> hasSetting(String key) async {
    final setting = await (select(settings)..where((t) => t.key.equals(key))).getSingleOrNull();
    return setting != null;
  }

  /// Get all settings
  Future<List<Setting>> getAllSettings() {
    return select(settings).get();
  }

  /// Clear all settings
  Future<int> clearAllSettings() {
    return delete(settings).go();
  }
}
