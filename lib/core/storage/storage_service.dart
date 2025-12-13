// lib/core/storage/storage_service.dart

abstract class StorageService {
  Future<void> init();
  
  // Secure (Token, etc.)
  Future<void> setSecure(String key, String value);
  Future<String?> getSecure(String key);
  Future<void> deleteSecure(String key);
  
  // Regular (Settings, Theme, etc.)
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  
  Future<void> clear();
}
