import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'dao/cache_dao.dart';
import 'dao/favorites_dao.dart';
import 'dao/settings_dao.dart';

part 'app_database.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// DRIFT DATABASE (SQLite)
//
// This database supports:
// - Typed tables with auto-generated models
// - JSON storage as TEXT columns
// - Migrations and versioning
// - Full SQL query support
//
// Usage:
//   final db = ref.watch(appDatabaseProvider);
//   await db.favoritesDao.insertFavorite(FavoritesCompanion(...));
// ═══════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
// TABLES
// ═══════════════════════════════════════════════════════════════════════════

/// Favorites table - stores user's favorite items with JSON metadata
class Favorites extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Unique identifier for the favorite item (e.g., product ID)
  TextColumn get itemId => text().withLength(min: 1, max: 100)();

  /// Type of favorite (e.g., 'product', 'location', 'user')
  TextColumn get itemType => text().withLength(min: 1, max: 50)();

  /// Title/name of the favorite
  TextColumn get title => text().withLength(min: 1, max: 200)();

  /// Optional description
  TextColumn get description => text().nullable()();

  /// Optional image URL
  TextColumn get imageUrl => text().nullable()();

  /// JSON metadata (store any additional data as JSON string)
  TextColumn get metadata => text().map(const JsonConverter()).nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().nullable()();

  /// Ensure itemId is unique per itemType
  @override
  List<Set<Column>> get uniqueKeys => [
    {itemId, itemType},
  ];
}

/// Cache table - stores cached API responses with JSON data
class CacheEntries extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Cache key (e.g., 'users_list', 'product_123')
  TextColumn get cacheKey => text().unique()();

  /// Cached JSON data
  TextColumn get data => text().map(const JsonConverter())();

  /// Expiration timestamp
  DateTimeColumn get expiresAt => dateTime()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Settings table - key-value store with JSON support
class Settings extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Setting key
  TextColumn get key => text().unique()();

  /// Setting value (can be JSON for complex values)
  TextColumn get value => text()();

  /// Value type hint (string, int, bool, json)
  TextColumn get valueType => text().withDefault(const Constant('string'))();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// User data table - stores user-related JSON data
class UserData extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// User ID (could be local or from server)
  TextColumn get userId => text().unique()();

  /// User profile data as JSON
  TextColumn get profileData => text().map(const JsonConverter()).nullable()();

  /// User preferences as JSON
  TextColumn get preferences => text().map(const JsonConverter()).nullable()();

  /// Last sync timestamp
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  /// Created timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Updated timestamp
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

// ═══════════════════════════════════════════════════════════════════════════
// JSON CONVERTER
// ═══════════════════════════════════════════════════════════════════════════

/// Converter for storing JSON data as TEXT in SQLite
class JsonConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    return json.decode(fromDb) as Map<String, dynamic>;
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return json.encode(value);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATABASE CLASS
// ═══════════════════════════════════════════════════════════════════════════

@DriftDatabase(tables: [Favorites, CacheEntries, Settings, UserData], daos: [FavoritesDao, CacheDao, SettingsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Named constructor for testing
  AppDatabase.forTesting(super.e);

  // ═══════════════════════════════════════════════════════════════════════════
  // DAOs (Data Access Objects)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Access favorites operations
  @override
  FavoritesDao get favoritesDao => FavoritesDao(this);

  /// Access cache operations
  @override
  CacheDao get cacheDao => CacheDao(this);

  /// Access settings operations
  @override
  SettingsDao get settingsDao => SettingsDao(this);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add migration logic for future versions
        // if (from < 2) {
        //   await m.addColumn(favorites, favorites.newColumn);
        // }
      },
      beforeOpen: (details) async {
        // Enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// Open database connection
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'zero_setup_app_db');
  }
}
