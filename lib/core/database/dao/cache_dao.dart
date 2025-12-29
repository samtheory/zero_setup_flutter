import 'package:drift/drift.dart';

import '../app_database.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CACHE DAO (Data Access Object)
//
// All database operations for the CacheEntries table.
// Useful for caching API responses with expiration.
// ═══════════════════════════════════════════════════════════════════════════

part 'cache_dao.g.dart';

@DriftAccessor(tables: [CacheEntries])
class CacheDao extends DatabaseAccessor<AppDatabase> with _$CacheDaoMixin {
  CacheDao(super.db);

  // ═══════════════════════════════════════════════════════════════════════════
  // CREATE / UPDATE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Store data in cache with expiration
  Future<int> setCache({
    required String key,
    required Map<String, dynamic> data,
    Duration expiration = const Duration(hours: 1),
  }) {
    return into(cacheEntries).insertOnConflictUpdate(
      CacheEntriesCompanion.insert(cacheKey: key, data: data, expiresAt: DateTime.now().add(expiration)),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // READ
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get cached data by key (returns null if expired or not found)
  Future<Map<String, dynamic>?> getCache(String key) async {
    final entry = await (select(cacheEntries)..where((t) => t.cacheKey.equals(key))).getSingleOrNull();

    if (entry == null) return null;

    // Check if expired
    if (entry.expiresAt.isBefore(DateTime.now())) {
      await deleteCache(key);
      return null;
    }

    return entry.data;
  }

  /// Get cached data regardless of expiration
  Future<CacheEntry?> getCacheEntry(String key) {
    return (select(cacheEntries)..where((t) => t.cacheKey.equals(key))).getSingleOrNull();
  }

  /// Check if cache exists and is valid
  Future<bool> hasValidCache(String key) async {
    final data = await getCache(key);
    return data != null;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DELETE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Delete cache by key
  Future<int> deleteCache(String key) {
    return (delete(cacheEntries)..where((t) => t.cacheKey.equals(key))).go();
  }

  /// Delete all expired cache entries
  Future<int> deleteExpiredCache() {
    return (delete(cacheEntries)..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now()))).go();
  }

  /// Clear all cache
  Future<int> clearAllCache() {
    return delete(cacheEntries).go();
  }
}
