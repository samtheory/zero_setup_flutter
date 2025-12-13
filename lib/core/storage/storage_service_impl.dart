// lib/core/storage/storage_service_impl.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zero_setup_flutter/core/storage/storage_service.dart';

class StorageServiceImpl implements StorageService {
  late final SharedPreferences _prefs;
  final FlutterSecureStorage _secure = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ═══════════════════════════════════════════
  // Secure Storage (Tokens, Secrets)
  // ═══════════════════════════════════════════
  
  @override
  Future<void> setSecure(String key, String value) => 
      _secure.write(key: key, value: value);

  @override
  Future<String?> getSecure(String key) => 
      _secure.read(key: key);

  @override
  Future<void> deleteSecure(String key) => 
      _secure.delete(key: key);

  // ═══════════════════════════════════════════
  // Regular Storage (Settings, Theme)
  // ═══════════════════════════════════════════
  
  @override
  Future<void> setString(String key, String value) async => 
      _prefs.setString(key, value);

  @override
  Future<String?> getString(String key) async => 
      _prefs.getString(key);

  @override
  Future<void> setBool(String key, bool value) async => 
      _prefs.setBool(key, value);

  @override
  Future<bool?> getBool(String key) async => 
      _prefs.getBool(key);

  @override
  Future<void> setInt(String key, int value) async => 
      _prefs.setInt(key, value);

  @override
  Future<int?> getInt(String key) async => 
      _prefs.getInt(key);

  @override
  Future<void> clear() async {
    await _prefs.clear();
    await _secure.deleteAll();
  }
}
