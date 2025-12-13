# Router Implementation - Architecture Decision Record

> **Status:** ✅ Approved  
> **Date:** 1404/09/22  
> **Solution:** go_router v14.x  
> **Pattern:** StatefulShellRoute + Global Auth Guard

---

## 1. Decision Summary

| Criteria | go_router | auto_route | Navigator 2.0 |
|----------|-----------|------------|---------------|
| Learning Curve | 🟢 Low | 🟡 Medium | 🔴 High |
| Code Generation | ✅ None | ❌ Required | ✅ None |
| Deep Links | ✅ Native | ✅ Native | ⚠️ Manual |
| Shell Routes | ✅ Built-in | ✅ Built-in | ⚠️ Manual |
| Google Support | ✅ Official | ❌ Community | ✅ Core |

**Winner:** go_router ✅

---

## 2. Route Constants
```dart
// lib/core/router/app_routes.dart
abstract class AppRoutes {
  // Public Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Protected Routes (Shell)
  static const String home = '/home';
  static const String search = '/search';
  static const String profile = '/profile';

  // Parameterized Routes
  static String postDetail(String id) => '/post/$id';
  static String userProfile(String id) => '/user/$id';

  // Public Route List
  static const List<String> publicRoutes = [
splash, login, register, forgotPassword,
  ];
}

---

## 3. Auth Guard (Global Redirect)

dart
// Inside GoRouter configuration
redirect: (BuildContext context, GoRouterState state) {
  final authState = ref.read(authStateProvider);
  final currentPath = state.matchedLocation;

  final isLoggedIn = authState.maybeWhen(
authenticated: (_) => true,
orElse: () => false,
  );

  final isPublicRoute = AppRoutes.publicRoutes.contains(currentPath);
  final isAuthRoute = currentPath == AppRoutes.login;

  // Not authenticated → Login
  if (!isLoggedIn && !isPublicRoute) {
return '${AppRoutes.login}?redirect=$currentPath';
  }

  // Authenticated on login → Home
  if (isLoggedIn && isAuthRoute) {
return AppRoutes.home;
  }

  return null;
},

---

## 4. Shell Route (IndexedStack)

dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
return MainShell(navigationShell: navigationShell);
  },
  branches: [
// Home Branch
StatefulShellBranch(
routes: [
GoRoute(
path: AppRoutes.home,
builder: (context, state) => const HomeScreen(),
routes: [
GoRoute(
path: 'post/:id',
builder: (context, state) => PostDetailScreen(
postId: state.pathParameters['id']!,
),
),
],
),
],
),
// Search Branch
StatefulShellBranch(
routes: [
GoRoute(
path: AppRoutes.search,
builder: (context, state) => const SearchScreen(),
),
],
),
// Profile Branch
StatefulShellBranch(
routes: [
GoRoute(
path: AppRoutes.profile,
builder: (context, state) => const ProfileScreen(),
),
],
),
  ],
),

---

## 5. Main Shell Widget

dart
// lib/core/router/main_shell.dart
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
return Scaffold(
body: navigationShell,
bottomNavigationBar: NavigationBar(
selectedIndex: navigationShell.currentIndex,
onDestinationSelected: (index) {
navigationShell.goBranch(
index,
initialLocation: index == navigationShell.currentIndex,
);
},
destinations: const [
NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
],
),
);
  }
}

---

## 6. Router Refresh Stream

dart
// lib/core/router/router_refresh_stream.dart
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
_subscription = stream.asBroadcastStream().listen((_) {
notifyListeners();
});
  }

  @override
  void dispose() {
_subscription.cancel();
super.dispose();
  }
}

---

## 7. Error Handling

dart
// Inside GoRouter configuration
errorBuilder: (context, state) {
  return Scaffold(
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Icon(Icons.error_outline, size: 64),
const SizedBox(height: 16),
const Text('Page Not Found'),
const SizedBox(height: 24),
ElevatedButton(
onPressed: () => context.go(AppRoutes.home),
child: const Text('Go Home'),
),
],
),
),
  );
},

---

## 8. Full Router Provider

dart
// lib/core/router/app_router.dart
final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.read(authStateProvider.notifier);

  return GoRouter(
initialLocation: AppRoutes.splash,
debugLogDiagnostics: kDebugMode,
refreshListenable: GoRouterRefreshStream(authNotifier.stream),
redirect: (context, state) {
// Auth guard logic here
},
errorBuilder: (context, state) => const ErrorScreen(),
routes: [
// Public routes
GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
GoRoute(path: AppRoutes.register, builder: (_, __) => const RegisterScreen()),

// Shell route with branches
StatefulShellRoute.indexedStack(/* ... */),
],
  );
});

---

## 9. Navigation Flow


User Request → Global Redirect Guard
│
┌────────┴────────┐
│                 │
Authenticated?    Public Route?
│                 │
Yes               Yes
│                 │
▼                 ▼
Allow Access      Allow Access
│
No
│
▼
   Redirect to /login?redirect=/original-path

---

## 10. Key Decisions

| Decision | Choice | Reason |
|----------|--------|--------|
| Router Package | go_router | Official, no codegen |
| Auth Guard | Global Redirect | Single source of truth |
| Shell Pattern | IndexedStack | Preserves tab state |
| Deep Links | Native Support | Built into go_router |
| Error Handling | errorBuilder | Centralized 404 handling |

---

**Status:** ✅ Ready for Implementation


---

تمیز، مختصر، کپی‌پیست‌شدنی! 🎯