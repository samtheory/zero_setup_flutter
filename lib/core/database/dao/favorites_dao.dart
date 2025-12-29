import 'package:drift/drift.dart';

import '../app_database.dart';

// ═══════════════════════════════════════════════════════════════════════════
// FAVORITES DAO (Data Access Object)
//
// All database operations for the Favorites table.
// ═══════════════════════════════════════════════════════════════════════════

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [Favorites])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  // ═══════════════════════════════════════════════════════════════════════════
  // CREATE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Insert a new favorite
  Future<int> insertFavorite(FavoritesCompanion favorite) {
    return into(favorites).insert(favorite);
  }

  /// Insert or update a favorite (upsert)
  Future<int> upsertFavorite(FavoritesCompanion favorite) {
    return into(favorites).insertOnConflictUpdate(favorite);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // READ
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get all favorites
  Future<List<Favorite>> getAllFavorites() {
    return select(favorites).get();
  }

  /// Watch all favorites (reactive stream)
  Stream<List<Favorite>> watchAllFavorites() {
    return select(favorites).watch();
  }

  /// Get favorite by ID
  Future<Favorite?> getFavoriteById(int id) {
    return (select(favorites)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Get favorite by itemId and itemType
  Future<Favorite?> getFavoriteByItem(String itemId, String itemType) {
    return (select(favorites)..where((t) => t.itemId.equals(itemId) & t.itemType.equals(itemType))).getSingleOrNull();
  }

  /// Get favorites by type
  Future<List<Favorite>> getFavoritesByType(String itemType) {
    return (select(favorites)..where((t) => t.itemType.equals(itemType))).get();
  }

  /// Watch favorites by type
  Stream<List<Favorite>> watchFavoritesByType(String itemType) {
    return (select(favorites)..where((t) => t.itemType.equals(itemType))).watch();
  }

  /// Check if item is favorite
  Future<bool> isFavorite(String itemId, String itemType) async {
    final favorite = await getFavoriteByItem(itemId, itemType);
    return favorite != null;
  }

  /// Search favorites by title
  Future<List<Favorite>> searchFavorites(String query) {
    return (select(favorites)..where((t) => t.title.like('%$query%'))).get();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UPDATE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Update a favorite
  Future<bool> updateFavorite(Favorite favorite) {
    return update(favorites).replace(favorite);
  }

  /// Update favorite metadata
  Future<int> updateMetadata(int id, Map<String, dynamic> metadata) {
    return (update(favorites)..where((t) => t.id.equals(id))).write(
      FavoritesCompanion(metadata: Value(metadata), updatedAt: Value(DateTime.now())),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DELETE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Delete a favorite by ID
  Future<int> deleteFavoriteById(int id) {
    return (delete(favorites)..where((t) => t.id.equals(id))).go();
  }

  /// Delete by itemId and itemType
  Future<int> deleteFavoriteByItem(String itemId, String itemType) {
    return (delete(favorites)..where((t) => t.itemId.equals(itemId) & t.itemType.equals(itemType))).go();
  }

  /// Toggle favorite (add if not exists, remove if exists)
  Future<bool> toggleFavorite({
    required String itemId,
    required String itemType,
    required String title,
    String? description,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) async {
    final existing = await getFavoriteByItem(itemId, itemType);

    if (existing != null) {
      await deleteFavoriteById(existing.id);
      return false; // Removed from favorites
    } else {
      await insertFavorite(
        FavoritesCompanion.insert(
          itemId: itemId,
          itemType: itemType,
          title: title,
          description: Value(description),
          imageUrl: Value(imageUrl),
          metadata: Value(metadata),
        ),
      );
      return true; // Added to favorites
    }
  }

  /// Delete all favorites
  Future<int> deleteAllFavorites() {
    return delete(favorites).go();
  }

  /// Delete all favorites by type
  Future<int> deleteAllFavoritesByType(String itemType) {
    return (delete(favorites)..where((t) => t.itemType.equals(itemType))).go();
  }
}
