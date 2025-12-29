# 🗄️ Database Service (Drift/SQLite)

A comprehensive SQLite database implementation using Drift for Flutter apps with full JSON column support.

## 📦 Features

- **Type-safe queries**: Full Dart type safety with generated code
- **JSON columns**: Store complex JSON objects in SQLite
- **Reactive streams**: Watch data changes in real-time
- **DAOs**: Organized data access objects for each table
- **Migrations**: Version-based database migrations
- **Cache support**: Built-in cache table with expiration

## 🚀 Quick Start

### 1. Import

```dart
import 'package:zero_setup_flutter/core/core.dart';
```

### 2. Access database via Riverpod

```dart
final db = ref.watch(appDatabaseProvider);
```

## 📋 Available Tables

| Table | Purpose | DAO |
|-------|---------|-----|
| `Favorites` | Store user's favorites with JSON metadata | `favoritesDao` |
| `CacheEntries` | Cache API responses with expiration | `cacheDao` |
| `Settings` | Key-value storage with JSON support | `settingsDao` |
| `UserData` | User profile and preferences | - |

## 🎯 Usage Examples

### Favorites DAO

```dart
final db = ref.watch(appDatabaseProvider);

// ═══════════════════════════════════════════════════════════════════════════
// INSERT
// ═══════════════════════════════════════════════════════════════════════════

// Add favorite with JSON metadata
await db.favoritesDao.insertFavorite(
  FavoritesCompanion.insert(
    itemId: 'product_123',
    itemType: 'product',
    title: 'Cool Product',
    description: const Value('A great product'),
    imageUrl: const Value('https://example.com/image.jpg'),
    metadata: Value({
      'price': 99.99,
      'currency': 'USD',
      'tags': ['electronics', 'sale'],
      'rating': 4.5,
      'specs': {
        'color': 'black',
        'weight': '500g',
      },
    }),
  ),
);

// Toggle favorite (add if not exists, remove if exists)
final isNowFavorite = await db.favoritesDao.toggleFavorite(
  itemId: 'product_123',
  itemType: 'product',
  title: 'Cool Product',
  metadata: {'price': 99.99},
);

// ═══════════════════════════════════════════════════════════════════════════
// READ
// ═══════════════════════════════════════════════════════════════════════════

// Get all favorites
final allFavorites = await db.favoritesDao.getAllFavorites();

// Get favorite by ID
final favorite = await db.favoritesDao.getFavoriteById(1);

// Get favorites by type
final products = await db.favoritesDao.getFavoritesByType('product');

// Check if item is favorite
final isFav = await db.favoritesDao.isFavorite('product_123', 'product');

// Search favorites
final results = await db.favoritesDao.searchFavorites('cool');

// ═══════════════════════════════════════════════════════════════════════════
// WATCH (Reactive Streams)
// ═══════════════════════════════════════════════════════════════════════════

// Watch all favorites (auto-updates UI when data changes)
db.favoritesDao.watchAllFavorites().listen((favorites) {
  print('Favorites updated: ${favorites.length}');
});

// In widget with flutter_hooks
final favoritesStream = useMemoized(() => db.favoritesDao.watchAllFavorites(), [db]);
final favorites = useStream(favoritesStream);

// ═══════════════════════════════════════════════════════════════════════════
// UPDATE
// ═══════════════════════════════════════════════════════════════════════════

// Update metadata
await db.favoritesDao.updateMetadata(1, {
  'price': 79.99,
  'discount': true,
});

// ═══════════════════════════════════════════════════════════════════════════
// DELETE
// ═══════════════════════════════════════════════════════════════════════════

// Delete by ID
await db.favoritesDao.deleteFavoriteById(1);

// Delete by item
await db.favoritesDao.deleteFavoriteByItem('product_123', 'product');

// Delete all
await db.favoritesDao.deleteAllFavorites();

// Delete all by type
await db.favoritesDao.deleteAllFavoritesByType('product');
```

### Cache DAO

```dart
final db = ref.watch(appDatabaseProvider);

// ═══════════════════════════════════════════════════════════════════════════
// CACHE API RESPONSES
// ═══════════════════════════════════════════════════════════════════════════

// Store JSON data with expiration
await db.cacheDao.setCache(
  key: 'users_list',
  data: {
    'users': [
      {'id': 1, 'name': 'John', 'email': 'john@test.com'},
      {'id': 2, 'name': 'Jane', 'email': 'jane@test.com'},
    ],
    'total': 2,
    'page': 1,
  },
  expiration: const Duration(hours: 1),
);

// Read cached data (returns null if expired)
final data = await db.cacheDao.getCache('users_list');
if (data != null) {
  final users = data['users'] as List;
  print('Cached ${users.length} users');
} else {
  // Cache expired or not found, fetch from API
}

// Check if valid cache exists
final hasCache = await db.cacheDao.hasValidCache('users_list');

// Delete specific cache
await db.cacheDao.deleteCache('users_list');

// Delete all expired cache
await db.cacheDao.deleteExpiredCache();

// Clear all cache
await db.cacheDao.clearAllCache();
```

### Settings DAO (Key-Value Store)

```dart
final db = ref.watch(appDatabaseProvider);

// ═══════════════════════════════════════════════════════════════════════════
// STRING
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.setString('username', 'john_doe');
final username = await db.settingsDao.getString('username');

// ═══════════════════════════════════════════════════════════════════════════
// INT
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.setInt('login_count', 42);
final count = await db.settingsDao.getInt('login_count');

// ═══════════════════════════════════════════════════════════════════════════
// DOUBLE
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.setDouble('last_latitude', 35.6762);
final lat = await db.settingsDao.getDouble('last_latitude');

// ═══════════════════════════════════════════════════════════════════════════
// BOOL
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.setBool('dark_mode', true);
final isDark = await db.settingsDao.getBool('dark_mode');

// ═══════════════════════════════════════════════════════════════════════════
// JSON (Map<String, dynamic>)
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.setJson('app_config', {
  'version': '1.0.0',
  'features': {
    'darkMode': true,
    'notifications': true,
    'analytics': false,
  },
  'limits': {
    'maxItems': 100,
    'timeout': 30,
  },
});

final config = await db.settingsDao.getJson('app_config');
if (config != null) {
  final features = config['features'] as Map<String, dynamic>;
  final isDarkMode = features['darkMode'] as bool;
}

// ═══════════════════════════════════════════════════════════════════════════
// LIST (List<dynamic>)
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.setList('recent_searches', ['flutter', 'dart', 'riverpod']);
final searches = await db.settingsDao.getList('recent_searches');

// ═══════════════════════════════════════════════════════════════════════════
// UTILITY
// ═══════════════════════════════════════════════════════════════════════════
await db.settingsDao.deleteSetting('username');
final exists = await db.settingsDao.hasSetting('dark_mode');
await db.settingsDao.clearAllSettings();
```

## 🏗️ JSON Storage in SQLite

### How it works

Drift stores JSON as TEXT columns using a `TypeConverter`:

```dart
// In table definition
TextColumn get metadata => text().map(const JsonConverter()).nullable()();

// JsonConverter handles serialization
class JsonConverter extends TypeConverter<Map<String, dynamic>, String> {
  @override
  Map<String, dynamic> fromSql(String fromDb) => json.decode(fromDb);

  @override
  String toSql(Map<String, dynamic> value) => json.encode(value);
}
```

### Querying JSON data

SQLite doesn't natively support JSON queries, but you can:

1. **Filter after fetch**: Load all rows and filter in Dart
2. **Use raw SQL**: Use SQLite's `json_extract()` function

```dart
// Raw SQL query with JSON
final results = await db.customSelect(
  "SELECT * FROM favorites WHERE json_extract(metadata, '\$.price') < ?",
  variables: [Variable.withReal(100.0)],
).get();
```

## 📁 File Structure

```
lib/core/database/
├── database.dart              # Barrel export
├── app_database.dart          # Main database class & tables
└── dao/
    ├── favorites_dao.dart     # Favorites operations
    ├── cache_dao.dart         # Cache operations
    └── settings_dao.dart      # Key-value operations
```

## 🔧 Adding New Tables

### 1. Define table in `app_database.dart`

```dart
class MyNewTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get data => text().map(const JsonConverter()).nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

### 2. Create DAO

```dart
// lib/core/database/dao/my_new_dao.dart
part 'my_new_dao.g.dart';

@DriftAccessor(tables: [MyNewTable])
class MyNewDao extends DatabaseAccessor<AppDatabase> with _$MyNewDaoMixin {
  MyNewDao(super.db);

  Future<List<MyNewTableData>> getAll() => select(myNewTable).get();
  // ... other methods
}
```

### 3. Register in database

```dart
@DriftDatabase(
  tables: [Favorites, CacheEntries, Settings, UserData, MyNewTable],
  daos: [FavoritesDao, CacheDao, SettingsDao, MyNewDao],
)
class AppDatabase extends _$AppDatabase {
  // ...
  MyNewDao get myNewDao => MyNewDao(this);
}
```

### 4. Run build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 🔄 Migrations

When changing schema, increment version and add migration:

```dart
@override
int get schemaVersion => 2; // Increment version

@override
MigrationStrategy get migration {
  return MigrationStrategy(
    onCreate: (m) async => await m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Add new column
        await m.addColumn(favorites, favorites.newColumn);
        // Or create new table
        await m.createTable(myNewTable);
      }
    },
  );
}
```

## 🧪 Testing

```dart
// Create in-memory database for testing
final db = AppDatabase.forTesting(NativeDatabase.memory());

// Use normally
await db.favoritesDao.insertFavorite(...);
final favorites = await db.favoritesDao.getAllFavorites();

// Close after test
await db.close();
```

## 📋 Best Practices

1. **Use DAOs**: Keep database operations organized
2. **Watch streams**: Use reactive streams for real-time UI updates
3. **Cache wisely**: Set appropriate expiration times
4. **Clean up**: Delete expired cache periodically
5. **Test migrations**: Test schema changes before release
6. **Close database**: Close when app terminates

## 🆚 When to Use What

| Use Case | Storage |
|----------|---------|
| Simple settings | `SharedPreferences` |
| Sensitive data (tokens) | `SecureStorage` |
| Complex/relational data | `Drift (SQLite)` |
| Cached API responses | `Drift CacheDao` |
| Offline-first data | `Drift` |
| User favorites with metadata | `Drift FavoritesDao` |

## 🚨 Troubleshooting

**"Table not found"**
- Run `dart run build_runner build --delete-conflicting-outputs`

**"Migration failed"**
- Check `schemaVersion` is incremented
- Ensure migration handles all schema changes

**JSON not parsing**
- Ensure JSON is valid before storing
- Check `JsonConverter` is applied to column

---

For more examples, see [fav_screen.dart](../../../features/fav/presentation/screen/fav_screen.dart) which demonstrates all storage types.