import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/core/core.dart';



// ═══════════════════════════════════════════════════════════════════════════
// FAV SCREEN - Storage Examples
//
// This screen demonstrates:
// 1. SharedPreferences - Simple key-value storage
// 2. SecureStorage - Encrypted storage for sensitive data
// 3. Drift (SQLite) - Relational database with JSON support
// ═══════════════════════════════════════════════════════════════════════════

class DBTestScreen extends HookConsumerWidget {
  const DBTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get storage services
    final prefs = ref.watch(preferencesServiceProvider);
    final secureStorage = ref.watch(secureStorageProvider);
    final db = ref.watch(appDatabaseProvider);

    // Local state for UI
    final isLoading = useState(false);
    final resultText = useState<String>('');

    // Watch favorites from database (reactive stream)
    final favoritesStream = useMemoized(() => db.favoritesDao.watchAllFavorites(), [db]);
    final favorites = useStream(favoritesStream);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage Examples'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _clearAllData(context, prefs, secureStorage, db, resultText),
            tooltip: 'Clear All Data',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ═══════════════════════════════════════════════════════════════════
          // RESULT DISPLAY
          // ═══════════════════════════════════════════════════════════════════
          if (resultText.value.isNotEmpty)
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.terminal, size: 16),
                        const SizedBox(width: 8),
                        const Text('Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          onPressed: () => resultText.value = '',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(resultText.value, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),

          // ═══════════════════════════════════════════════════════════════════
          // 1. SHARED PREFERENCES
          // ═══════════════════════════════════════════════════════════════════
          _SectionCard(
            title: '📦 SharedPreferences',
            subtitle: 'Simple key-value storage (non-sensitive data)',
            children: [
              _ActionTile(
                title: 'Save Theme Mode',
                subtitle: 'setString("theme", "dark")',
                icon: Icons.dark_mode,
                onTap: () async {
                  await prefs.setThemeMode('dark');
                  resultText.value = '✅ Theme saved: dark';
                  context.notify.showSuccess('Theme saved!');
                },
              ),
              _ActionTile(
                title: 'Read Theme Mode',
                subtitle: 'getString("theme")',
                icon: Icons.visibility,
                onTap: () {
                  final theme = prefs.getThemeMode();
                  resultText.value = '📖 Theme: $theme';
                },
              ),
              _ActionTile(
                title: 'Save JSON Data',
                subtitle: 'setString("user_prefs", json)',
                icon: Icons.data_object,
                onTap: () async {
                  await prefs.setString('user_prefs', '{"notifications": true, "sound": false}');
                  resultText.value = '✅ JSON saved to SharedPreferences';
                },
              ),
              _ActionTile(
                title: 'Read JSON Data',
                subtitle: 'getString("user_prefs")',
                icon: Icons.read_more,
                onTap: () {
                  final json = prefs.getString('user_prefs');
                  resultText.value = '📖 User Prefs: $json';
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ═══════════════════════════════════════════════════════════════════
          // 2. SECURE STORAGE
          // ═══════════════════════════════════════════════════════════════════
          _SectionCard(
            title: '🔐 SecureStorage',
            subtitle: 'Encrypted storage for sensitive data (tokens, keys)',
            children: [
              _ActionTile(
                title: 'Save Access Token',
                subtitle: 'saveAccessToken("eyJhbGc...")',
                icon: Icons.key,
                onTap: () async {
                  await secureStorage.saveAccessToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test_token');
                  resultText.value = '✅ Access token saved securely';
                  context.notify.showSuccess('Token saved securely!');
                },
              ),
              _ActionTile(
                title: 'Read Access Token',
                subtitle: 'getAccessToken()',
                icon: Icons.visibility,
                onTap: () async {
                  final token = await secureStorage.getAccessToken();
                  resultText.value = '📖 Token: ${token ?? "null"}';
                },
              ),
              _ActionTile(
                title: 'Save User Credentials',
                subtitle: 'saveTokens(access, refresh, userId)',
                icon: Icons.person_pin,
                onTap: () async {
                  await secureStorage.saveTokens(
                    accessToken: 'access_token_123',
                    refreshToken: 'refresh_token_456',
                    userId: 'user_789',
                  );
                  resultText.value = '✅ All credentials saved';
                },
              ),
              _ActionTile(
                title: 'Check Auth Status',
                subtitle: 'hasToken()',
                icon: Icons.verified_user,
                onTap: () async {
                  final hasTokens = await secureStorage.hasToken();
                  resultText.value = '📖 Has token: $hasTokens';
                },
              ),
              _ActionTile(
                title: 'Clear Auth',
                subtitle: 'clearAuth()',
                icon: Icons.logout,
                isDestructive: true,
                onTap: () async {
                  await secureStorage.clearAuth();
                  resultText.value = '🗑️ Auth cleared';
                  context.notify.showInfo('Auth cleared');
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ═══════════════════════════════════════════════════════════════════
          // 3. DRIFT DATABASE (SQLite)
          // ═══════════════════════════════════════════════════════════════════
          _SectionCard(
            title: '🗄️ Drift Database (SQLite)',
            subtitle: 'Relational database with JSON column support',
            children: [
              // Favorites operations
              _ActionTile(
                title: 'Add Favorite with JSON',
                subtitle: 'Insert item with metadata JSON',
                icon: Icons.favorite_border,
                onTap: () async {
                  final id = DateTime.now().millisecondsSinceEpoch.toString();
                  await db.favoritesDao.insertFavorite(
                    FavoritesCompanion.insert(
                      itemId: 'product_$id',
                      itemType: 'product',
                      title: 'Product #$id',
                      description: const Value('A sample product'),
                      imageUrl: const Value('https://picsum.photos/200'),
                      metadata: Value({
                        'price': 99.99,
                        'currency': 'USD',
                        'tags': ['electronics', 'sale'],
                        'rating': 4.5,
                        'reviews': 128,
                      }),
                    ),
                  );
                  resultText.value = '✅ Favorite added with JSON metadata';
                  context.notify.showSuccess('Added to favorites!');
                },
              ),
              _ActionTile(
                title: 'Toggle Favorite',
                subtitle: 'Add/remove from favorites',
                icon: Icons.favorite,
                onTap: () async {
                  final added = await db.favoritesDao.toggleFavorite(
                    itemId: 'toggle_item_1',
                    itemType: 'location',
                    title: 'My Favorite Location',
                    metadata: {'lat': 35.6762, 'lng': 51.4241, 'city': 'Tehran'},
                  );
                  resultText.value = added ? '✅ Added to favorites' : '🗑️ Removed from favorites';
                },
              ),

              // Cache operations
              const Divider(),
              _ActionTile(
                title: 'Cache API Response',
                subtitle: 'Store JSON with 1-hour expiration',
                icon: Icons.cached,
                onTap: () async {
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
                  resultText.value = '✅ API response cached for 1 hour';
                },
              ),
              _ActionTile(
                title: 'Read Cached Data',
                subtitle: 'Get cached JSON (returns null if expired)',
                icon: Icons.download,
                onTap: () async {
                  final data = await db.cacheDao.getCache('users_list');
                  if (data != null) {
                    resultText.value = '📖 Cached: ${data.toString()}';
                  } else {
                    resultText.value = '⏰ Cache expired or not found';
                  }
                },
              ),

              // Settings operations
              const Divider(),
              _ActionTile(
                title: 'Save JSON Setting',
                subtitle: 'Store complex settings as JSON',
                icon: Icons.settings,
                onTap: () async {
                  await db.settingsDao.setJson('app_config', {
                    'version': '1.0.0',
                    'features': {'darkMode': true, 'notifications': true},
                    'limits': {'maxItems': 100, 'timeout': 30},
                  });
                  resultText.value = '✅ JSON config saved to SQLite';
                },
              ),
              _ActionTile(
                title: 'Read JSON Setting',
                subtitle: 'Get complex settings',
                icon: Icons.settings_applications,
                onTap: () async {
                  final config = await db.settingsDao.getJson('app_config');
                  resultText.value = '📖 Config: $config';
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ═══════════════════════════════════════════════════════════════════
          // FAVORITES LIST (Reactive Stream)
          // ═══════════════════════════════════════════════════════════════════
          _SectionCard(
            title: '⭐ Favorites (Live Stream)',
            subtitle: 'Auto-updates when database changes',
            children: [
              if (favorites.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator())
              else if (favorites.data?.isEmpty ?? true)
                const ListTile(
                  leading: Icon(Icons.inbox),
                  title: Text('No favorites yet'),
                  subtitle: Text('Add some favorites above'),
                )
              else
                ...favorites.data!.map(
                  (fav) => ListTile(
                    leading: CircleAvatar(
                      child: Text(fav.title[0]),
                    ),
                    title: Text(fav.title),
                    subtitle: Text('${fav.itemType} • ${fav.itemId}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await db.favoritesDao.deleteFavoriteById(fav.id);
                        context.notify.showInfo('Removed from favorites');
                      },
                    ),
                    onTap: () {
                      resultText.value = '''
📦 Favorite Details:
  ID: ${fav.id}
  Item ID: ${fav.itemId}
  Type: ${fav.itemType}
  Title: ${fav.title}
  Description: ${fav.description ?? 'null'}
  Metadata: ${fav.metadata?.toString() ?? 'null'}
  Created: ${fav.createdAt}''';
                    },
                  ),
                ),
            ],
          ),

          const SizedBox(height: 100), // Bottom padding
        ],
      ),
    );
  }

  Future<void> _clearAllData(
    BuildContext context,
    PreferencesService prefs,
    SecureStorageService secureStorage,
    AppDatabase db,
    ValueNotifier<String> resultText,
  ) async {
    final confirmed = await context.notify.showConfirmation(
      title: 'Clear All Data?',
      message: 'This will delete all stored data including preferences, tokens, and database.',
    );

    if (confirmed) {
      // Clear SharedPreferences
      await prefs.clearAll();

      // Clear SecureStorage
      await secureStorage.clearAll();

      // Clear Database
      await db.favoritesDao.deleteAllFavorites();
      await db.cacheDao.clearAllCache();
      await db.settingsDao.clearAllSettings();

      resultText.value = '🗑️ All data cleared!';
      if (context.mounted) {
        context.notify.showSuccess('All data cleared!');
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// UI COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : null),
      title: Text(title, style: TextStyle(color: isDestructive ? Colors.red : null)),
      subtitle: Text(subtitle, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
      trailing: const Icon(Icons.play_arrow),
      onTap: onTap,
    );
  }
}
