// import 'package:go_router/go_router.dart';
// import 'package:zero_setup_flutter/features/test_pages/home.dart';

// // GoRouter configuration
// final appRouter = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomeScreen(),
//     ),
//   ],
// );

// ⭐ (مغز Navigation)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_setup_flutter/features/fav/presentation/screen/db_test_screen.dart';
import 'package:zero_setup_flutter/features/map_feature/presentation/screens/map_screen.dart';

import '../shells/main_shell/main_shell.dart';
import '../../shared/domain/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/test_feature/presentation/screens/item_list_screen.dart';
import '../../features/test_feature/presentation/screens/item_detail_screen.dart';
import '../../features/test_feature/presentation/screens/item_form_screen.dart';
import '../../features/ex_user_feature/presentation/screens/user_profile_screen.dart';
import 'routes.dart';

/// کلید Navigator برای refresh
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  // وقتی Auth تغییر کنه، Router خودکار refresh میشه
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    debugLogDiagnostics: true, // برای دیباگ - توی Production غیرفعال کن

    redirect: (context, state) {
      final uri = state.uri;

      // Handle zeroapp://map
      if (uri.scheme == 'zeroapp' && uri.host == 'map') {
        return Routes.map;
      }
      // Handle zeroapp://map?id=123&mode=view
      if (uri.scheme == 'zeroapp' && uri.host == 'map') {
        final query = uri.query.isNotEmpty ? '?${uri.query}' : '';
        return '${Routes.map}$query';
      }
      
      // 🛡️ Auth Guard
      final isLoggedIn = authState.isAuthenticated;
      final isLoggingIn = state.matchedLocation == Routes.login;

      // اگه لاگین نیست و داره میره جایی غیر از Login → برو Login
      if (!isLoggedIn && !isLoggingIn) {
        return Routes.login;
      }

      // اگه لاگینه و داره میره Login → برو Home
      if (isLoggedIn && isLoggingIn) {
        return Routes.home;
      }

      // در غیر این صورت، اجازه بده
      return null;
      // 🛡️End of ------> Auth Guard
    },

    routes: [
      // 🔐 Login Route (بدون Shell)
      GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),

      // 🧪 Test Feature Routes (بدون Shell برای نمایش مستقل)
      GoRoute(path: Routes.testFeature, builder: (context, state) => const ItemListScreen()),
      GoRoute(
        path: '${Routes.testFeatureDetail}/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return ItemDetailScreen(itemId: id);
        },
      ),
      GoRoute(
        path: Routes.testFeatureForm,
        builder: (context, state) {
          final id = int.tryParse(state.uri.queryParameters['id'] ?? '');
          return ItemFormScreen(itemId: id);
        },
      ),

      // ===============================
      //   Feature Application Routes
      // ===============================

      // 🗺️ Map Feature Route
      GoRoute(
        path: Routes.map,
        pageBuilder: (context, state) => const NoTransitionPage(child: MapScreen()),
      ),

      // 👤 Example User Feature Route
      GoRoute(path: Routes.exUserProfile, builder: (context, state) => const UserProfileScreen()),

      // 🏠 Main Shell با Bottom Navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // 🏠 Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                pageBuilder: (context, state) =>  NoTransitionPage(child: HomeScreen()),
              ),
              GoRoute(
                path: Routes.favScreen,
                pageBuilder: (context, state) => const NoTransitionPage(child: DBTestScreen()),
              ),
            ],
          ),

          // 👤 Branch 1: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                pageBuilder: (context, state) => const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),

          // ⚙️ Branch 2: Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
              ),
            ],
          ),
        ],
      ),
    ],

    // 404 Page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('۴۰۴ - صفحه پیدا نشد!', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('مسیر: ${state.matchedLocation}'),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => context.go(Routes.home), child: const Text('برگرد به خانه')),
          ],
        ),
      ),
    ),
  );
});
