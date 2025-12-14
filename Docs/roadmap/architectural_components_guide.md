# 🏗️ Architectural Components Guide

## Overview

This document explains the architectural components used in the Zero Setup Flutter project. The architecture follows **Clean Architecture** principles with **Feature-Based** organization, using modern Flutter tools and patterns for scalable, maintainable, and testable code.

## 🏛️ Core Architecture Principles

### 1. **Clean Architecture Layers**
```
📱 Presentation Layer (UI)
    ↓
🔄 Domain Layer (Business Logic)
    ↓
💾 Data Layer (External APIs/Databases)
```

### 2. **Feature-Based Organization**
```
lib/
├── features/          # Feature modules
├── core/             # Shared infrastructure
├── shared/           # Cross-cutting concerns
└── app/              # App-level configuration
```

### 3. **SOLID Principles**
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Subtypes are substitutable for base types
- **Interface Segregation**: Clients depend only on methods they use
- **Dependency Inversion**: Depend on abstractions, not concretions

---

## 📋 Architectural Components

### 1. 🎯 **Riverpod (State Management)**

#### What It Is
Riverpod is a reactive state management library that provides compile-time safe dependency injection and state management for Flutter applications.

#### How It Works
- **Providers**: Define how to create/fetch data
- **StateNotifier**: Manage mutable state
- **ConsumerWidget**: React to state changes
- **Ref**: Access providers and manage dependencies

#### Types of Providers

**1.1 Simple Provider (Services)**
```dart
final loggerProvider = Provider<Talker>((ref) => talker);
```
*Use for*: Stateless services, utilities, configurations

**1.2 StateNotifier Provider (State Management)**
```dart
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login() async {
    state = state.copyWith(isLoading: true);
    // Business logic
    state = AuthState(user: user, isLoading: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
```
*Use for*: Complex state with business logic, user sessions, form states

**1.3 Future Provider (Async Data)**
```dart
@riverpod
Future<List<Product>> products(ProductsRef ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
}
```
*Use for*: API calls, database queries, async operations

**1.4 Stream Provider (Real-time Data)**
```dart
@riverpod
Stream<List<Message>> messages(MessagesRef ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return repository.watchMessages();
}
```
*Use for*: WebSocket connections, real-time updates, live data

#### Where to Put It

**📍 Core Providers** (`lib/core/providers/`)
```dart
// Infrastructure services
final dioProvider = Provider<Dio>((ref) => DioClient().dio);
final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});
```

**📍 Feature Providers** (`features/feature/presentation/providers/`)
```dart
// Feature-specific state management
@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<List<Product>> build() async {
    final repository = ref.watch(productRepositoryProvider);
    return repository.getProducts();
  }
}
```

**📍 Shared Providers** (`lib/shared/domain/providers/`)
```dart
// Cross-cutting concerns
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
```

#### When to Use Each Type

| Scenario | Provider Type | Example |
|----------|---------------|---------|
| Static configuration | Simple Provider | API endpoints, theme config |
| User authentication | StateNotifier | Login/logout state |
| API data fetching | Future Provider | Load user profile |
| Real-time updates | Stream Provider | Chat messages, notifications |
| Form state | StateNotifier | Registration form |
| Feature toggle | Simple Provider | Feature flags |

#### Why Riverpod?
- ✅ **Compile-time safety**: No runtime errors from missing providers
- ✅ **Testability**: Easy to mock and test
- ✅ **Performance**: Automatic dependency tracking and disposal
- ✅ **Scalability**: Works well with large codebases
- ✅ **Developer experience**: Great IDE support and error messages

---

### 2. 🛣️ **Go Router (Navigation)**

#### What It Is
Go Router is a declarative routing library for Flutter that provides URL-based navigation with deep linking support.

#### How It Works
- **GoRouter**: Main router configuration
- **GoRoute**: Define individual routes
- **StatefulShellRoute**: Persistent navigation (bottom tabs)
- **Redirect**: Authentication guards and conditional navigation

#### Router Configuration

**2.1 Basic Routes**
```dart
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
```

**2.2 Stateful Shell Routes (Bottom Navigation)**
```dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return MainShell(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
)
```

**2.3 Authentication Guards**
```dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/home';
      return null;
    },
    routes: [...],
  );
});
```

#### Navigation Methods

**2.4 Programmatic Navigation**
```dart
// Navigate to route
context.go('/home');

// Navigate with replacement
context.go('/login');

// Go back
context.pop();

// Navigate with parameters
context.go('/product/123');

// Pass extra data
context.go('/checkout', extra: orderData);
```

#### Where to Put It

**📍 Router Configuration** (`lib/app/router/router.dart`)
```dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) => _handleRedirect(authState, state),
    routes: _buildRoutes(),
  );
});
```

**📍 Route Constants** (`lib/app/router/routes.dart`)
```dart
abstract class Routes {
  static const home = '/home';
  static const login = '/login';
  static const profile = '/profile';
  static const product = '/product/:id';
}
```

**📍 Shell Components** (`lib/app/shells/`)
```dart
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(...),
    );
  }
}
```

#### When to Use Different Navigation Patterns

| Scenario | Pattern | Example |
|----------|---------|---------|
| Simple screen transition | `context.go()` | Navigate to settings |
| Replace current screen | `context.go()` with replacement | Login → Home |
| Modal overlay | `showDialog()` + `context.go()` | Product details modal |
| Bottom sheet | `showModalBottomSheet()` | Quick actions |
| Deep linking | URL parameters | `/product/123` |
| Authentication flow | Redirect + guards | Login required screens |

#### Why Go Router?
- ✅ **URL-based**: Deep linking and browser history support
- ✅ **Type-safe**: Compile-time route validation
- ✅ **Flexible**: Supports complex navigation patterns
- ✅ **Integrated**: Works seamlessly with Riverpod
- ✅ **Future-proof**: Web and mobile navigation patterns

---

### 3. 🔄 **Freezed (Data Classes)**

#### What It Is
Freezed is a code generation library that creates immutable data classes with built-in JSON serialization, copy methods, and pattern matching.

#### How It Works
- **@freezed**: Annotation for code generation
- **factory constructors**: Define different variants
- **copyWith**: Immutable updates
- **toJson/fromJson**: Automatic serialization

#### Data Class Patterns

**3.1 Simple Entity**
```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

**3.2 Union Types (State Management)**
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
```

**3.3 API Models**
```dart
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default([]) List<String> tags,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
```

#### Where to Put It

**📍 Domain Entities** (`lib/shared/domain/entities/`)
```dart
// Business logic models
@freezed
class User with _$User {
  const factory User({...}) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

**📍 API Models** (`features/feature/data/models/`)
```dart
// API response models
@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({...}) = _ProductModel;
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
```

**📍 State Classes** (`features/feature/presentation/providers/`)
```dart
// UI state management
@freezed
class ProductState with _$ProductState {
  const factory ProductState.loading() = _Loading;
  const factory ProductState.data(List<Product> products) = _Data;
  const factory ProductState.error(String message) = _Error;
}
```

#### When to Use Freezed

| Scenario | Pattern | Example |
|----------|---------|---------|
| API responses | Simple factory + fromJson | User profile data |
| Domain entities | Simple factory + fromJson | Business objects |
| UI states | Union types | Loading/success/error states |
| Form data | Simple factory | Registration form |
| Configuration | Simple factory | App settings |
| Events | Union types | User actions |

#### Why Freezed?
- ✅ **Immutability**: Prevents accidental mutations
- ✅ **Type Safety**: Compile-time guarantees
- ✅ **Code Generation**: Reduces boilerplate by 80%
- ✅ **JSON Support**: Automatic serialization
- ✅ **Pattern Matching**: Powerful state handling

---

### 4. 🌐 **Dio + Retrofit (Networking)**

#### What It Is
Dio is a powerful HTTP client for Dart/Flutter, and Retrofit generates type-safe API clients from interface definitions.

#### How It Works
- **Dio**: HTTP client with interceptors and middleware
- **Retrofit**: Annotation-based API client generation
- **Interceptors**: Request/response/error handling

#### API Client Setup

**4.1 Dio Configuration**
```dart
class DioClient {
  late final Dio _dio;

  DioClient(SecureStorageService storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _setupInterceptors(storage);
  }

  void _setupInterceptors(SecureStorageService storage) {
    _dio.interceptors.addAll([
      AuthInterceptor(storage),     // Add auth tokens
      ErrorInterceptor(),           // Handle errors
      TalkerDioLogger(talker: talker), // Logging
    ]);
  }
}
```

**4.2 Retrofit API Definition**
```dart
@RestApi(baseUrl: 'https://api.example.com')
abstract class ProductApi {
  factory ProductApi(Dio dio) = _ProductApi;

  @GET('/products')
  Future<List<ProductModel>> getProducts({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('/products/{id}')
  Future<ProductModel> getProduct(@Path('id') String id);

  @POST('/products')
  Future<ProductModel> createProduct(@Body() CreateProductRequest request);

  @PUT('/products/{id}')
  Future<ProductModel> updateProduct(
    @Path('id') String id,
    @Body() UpdateProductRequest request,
  );

  @DELETE('/products/{id}')
  Future<void> deleteProduct(@Path('id') String id);
}
```

**4.3 Request/Response Models**
```dart
@freezed
class CreateProductRequest with _$CreateProductRequest {
  const factory CreateProductRequest({
    required String name,
    required String description,
    required double price,
  }) = _CreateProductRequest;

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductRequestFromJson(json);
}
```

#### Where to Put It

**📍 Dio Client** (`lib/core/network/dio_client.dart`)
```dart
// HTTP client configuration
class DioClient {
  // Global Dio setup with interceptors
}
```

**📍 API Services** (`features/feature/data/services/`)
```dart
// Feature-specific API clients
@RestApi()
abstract class FeatureApi {
  // API endpoints
}
```

**📍 Interceptors** (`lib/core/network/interceptors/`)
```dart
// Request/response middleware
class AuthInterceptor extends Interceptor {
  // Add auth headers
}

class ErrorInterceptor extends Interceptor {
  // Handle HTTP errors
}
```

#### When to Use Different HTTP Methods

| Operation | Method | Use Case |
|-----------|--------|----------|
| Fetch data | GET | List items, get details |
| Create resource | POST | New user, new product |
| Update resource | PUT/PATCH | Modify existing item |
| Delete resource | DELETE | Remove item |
| File upload | POST (multipart) | Image/document upload |

#### Why Dio + Retrofit?
- ✅ **Type Safety**: Compile-time API contract validation
- ✅ **Interceptors**: Centralized request/response handling
- ✅ **Error Handling**: Global error management
- ✅ **Logging**: Built-in request/response logging
- ✅ **Testing**: Easy to mock and test

---

### 5. 💾 **Drift (Database)**

#### What It Is
Drift is a reactive persistence library for Flutter that generates type-safe SQL code at compile time.

#### How It Works
- **Tables**: Define database schema
- **DAOs**: Data Access Objects for queries
- **Migrations**: Schema version management
- **Streams**: Reactive data updates

#### Database Setup

**5.1 Table Definition**
```dart
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text()();
  RealColumn get price => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**5.2 Database Class**
```dart
@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Queries
  Future<List<Product>> getAllProducts() => select(products).get();
  Future<Product?> getProduct(int id) => (select(products)..where((p) => p.id.equals(id))).getSingleOrNull();
  Future<int> insertProduct(ProductsCompanion product) => into(products).insert(product);
  Future<bool> updateProduct(ProductsCompanion product) => update(products).replace(product);
  Future<int> deleteProduct(int id) => (delete(products)..where((p) => p.id.equals(id))).delete();
}
```

**5.3 Repository Implementation**
```dart
class ProductRepositoryImpl implements ProductRepository {
  final AppDatabase _database;

  ProductRepositoryImpl(this._database);

  @override
  Future<List<Product>> getProducts() => _database.getAllProducts();

  @override
  Future<Product?> getProduct(int id) => _database.getProduct(id);

  @override
  Future<void> saveProduct(Product product) async {
    await _database.insertProduct(product.toCompanion());
  }
}
```

#### Where to Put It

**📍 Database Schema** (`lib/core/database/`)
```dart
// Table definitions and database class
@DriftDatabase(tables: [Users, Products])
class AppDatabase extends _$AppDatabase {
  // Database implementation
}
```

**📍 DAOs** (`lib/core/database/daos/`)
```dart
// Data Access Objects
@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> {
  // Custom queries
}
```

**📍 Migrations** (`lib/core/database/migrations/`)
```dart
// Schema migrations
@override
MigrationStrategy get migration => MigrationStrategy(
  onCreate: (m) async => m.createAll(),
  onUpgrade: (m, from, to) async {
    // Migration logic
  },
);
```

#### When to Use Drift

| Scenario | Pattern | Example |
|----------|---------|---------|
| User data | Local cache | User preferences, offline data |
| App state | Persistent storage | Draft forms, navigation state |
| Complex queries | Custom DAOs | Filtered/search results |
| Relationships | Foreign keys | User posts, product categories |
| Migrations | Version management | Schema updates |

#### Why Drift?
- ✅ **Type Safety**: Compile-time SQL validation
- ✅ **Reactive**: Stream-based data updates
- ✅ **Migrations**: Safe schema evolution
- ✅ **Performance**: Optimized queries
- ✅ **Testing**: Easy to mock and test

---

### 6. 📝 **Talker (Logging)**

#### What It Is
Talker is a powerful logging library for Flutter with structured logging, error tracking, and beautiful console output.

#### How It Works
- **Talker**: Main logger instance
- **Observers**: Riverpod and Dio integration
- **Themes**: Customizable log formatting
- **Filters**: Log level filtering

#### Logger Setup

**6.1 Basic Configuration**
```dart
final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    enabled: kDebugMode,
    useHistory: kDebugMode,
    maxHistoryItems: 500,
  ),
  logger: TalkerLogger(
    output: debugPrint,
    settings: TalkerLoggerSettings(
      enableColors: true,
      maxLineWidth: 120,
    ),
  ),
);
```

**6.2 Riverpod Integration**
```dart
final talkerRiverpodObserver = TalkerRiverpodObserver(
  talker: talker,
  settings: TalkerRiverpodLoggerSettings(
    enabled: true,
    printProviderAdded: true,
    printProviderDisposed: true,
    printProviderUpdated: true,
  ),
);
```

**6.3 Dio Integration**
```dart
_dio.interceptors.add(
  TalkerDioLogger(
    talker: talker,
    settings: TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseData: true,
      printErrorData: true,
    ),
  ),
);
```

#### Logging Usage

**6.4 Different Log Levels**
```dart
// Info logs
talker.info('User logged in', userId);

// Error logs
talker.error('API call failed', error);

// Debug logs
talker.debug('Processing data', {'count': items.length});

// Warning logs
talker.warning('Deprecated API usage');

// Custom logs
talker.logTyped(ApiLog('Custom API message'));
```

**6.5 Exception Handling**
```dart
try {
  await riskyOperation();
} catch (e, st) {
  talker.handle(e, st, 'Operation failed');
}
```

#### Where to Put It

**📍 Logger Configuration** (`lib/core/logger/`)
```dart
// Logger setup and configuration
final talker = TalkerFlutter.init(...);
```

**📍 Custom Log Types** (`lib/core/logger/logs/`)
```dart
class ApiLog extends TalkerLog {
  ApiLog(String message) : super(message);

  @override
  String get title => 'API';

  @override
  AnsiPen get pen => AnsiPen()..xterm(46); // Green
}
```

**📍 Logger Integration** (`lib/main.dart`)
```dart
runApp(
  ProviderScope(
    observers: [talkerRiverpodObserver],
    child: const App(),
  ),
);
```

#### When to Use Different Log Levels

| Level | When to Use | Example |
|-------|-------------|---------|
| verbose | Detailed debugging | Variable values, function calls |
| debug | Development info | API responses, state changes |
| info | Important events | User actions, successful operations |
| warning | Potential issues | Deprecated usage, retry attempts |
| error | Errors and exceptions | Failed API calls, crashes |
| critical | System failures | App crashes, data corruption |

#### Why Talker?
- ✅ **Structured Logging**: Rich context and metadata
- ✅ **Beautiful Output**: Color-coded, formatted logs
- ✅ **Integration**: Works with Riverpod, Dio, Flutter
- ✅ **Error Tracking**: Automatic exception handling
- ✅ **Performance**: Minimal impact in production

---

### 7. ⚙️ **Envied (Environment Variables)**

#### What It Is
Envied is a code generation library that creates type-safe environment variable access with compile-time validation.

#### How It Works
- **@Envied**: Annotation for environment files
- **useConstantCase**: Generate SCREAMING_SNAKE_CASE constants
- **obfuscate**: Hide sensitive values in production

#### Environment Setup

**7.1 Environment File** (`.env.dev`)
```env
API_BASE_URL=https://api-dev.example.com
API_TIMEOUT=30000
AUTH_CLIENT_ID=dev_client_id
ANALYTICS_ENABLED=false
DEBUG_MODE=true
```

**7.2 Generated Class**
```dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', useConstantCase: true)
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'API_TIMEOUT')
  static const int apiTimeout = _Env.apiTimeout;

  @EnviedField(varName: 'DEBUG_MODE')
  static const bool debugMode = _Env.debugMode;
}
```

#### Where to Put It

**📍 Environment Files** (`lib/core/config/env/`)
```
.env.dev
.env.staging
.env.prod
```

**📍 Generated Class** (`lib/core/config/env/env.dart`)
```dart
@Envied(path: '.env.dev')  // Different path per flavor
abstract class Env {
  // Environment variables
}
```

**📍 Environment Manager** (`lib/core/config/environment.dart`)
```dart
class EnvironmentManager {
  static Environment get current => _currentEnvironment;

  static String getAssetPath(String asset) {
    return 'assets/${current.name.toLowerCase()}/$asset';
  }
}
```

#### When to Use Environment Variables

| Type | Use Case | Example |
|------|----------|---------|
| API URLs | Different endpoints per environment | `api.dev.com`, `api.prod.com` |
| API Keys | External service credentials | Analytics, payment keys |
| Feature Flags | Environment-specific features | Debug menus, test features |
| Timeouts | Environment-specific timing | Longer timeouts in dev |
| Limits | Different limits per environment | API rate limits, cache sizes |

#### Why Envied?
- ✅ **Type Safety**: Compile-time validation
- ✅ **Security**: Obfuscated sensitive values
- ✅ **IDE Support**: Auto-completion and refactoring
- ✅ **Performance**: Zero runtime cost
- ✅ **Maintainability**: Single source of truth

---

## 🎯 Architecture Decision Scenarios

### Scenario 1: User Authentication Flow

**Components Used:**
- Riverpod (StateNotifier) → Auth state management
- Go Router → Navigation guards
- Freezed → Auth state classes
- Dio + Retrofit → Login API calls
- Drift → User session storage
- Talker → Auth event logging

**File Structure:**
```
features/auth/
├── data/
│   ├── services/auth_api.dart
│   └── repositories/auth_repository_impl.dart
├── domain/
│   ├── entities/user.dart
│   ├── repositories/auth_repository.dart
│   └── usecases/login_usecase.dart
└── presentation/
    ├── providers/auth_provider.dart
    ├── screens/login_screen.dart
    └── widgets/auth_form.dart
```

### Scenario 2: Product Catalog with Search

**Components Used:**
- Riverpod (FutureProvider) → Product data fetching
- Freezed → Product models and search state
- Dio + Retrofit → Product API
- Drift → Offline product cache
- Go Router → Product detail navigation

**File Structure:**
```
features/products/
├── data/
│   ├── models/product_model.dart
│   ├── services/product_api.dart
│   └── repositories/product_repository_impl.dart
├── domain/
│   ├── entities/product.dart
│   ├── repositories/product_repository.dart
│   └── usecases/search_products_usecase.dart
└── presentation/
    ├── providers/product_provider.dart
    ├── screens/product_list_screen.dart
    ├── screens/product_detail_screen.dart
    └── widgets/product_card.dart
```

### Scenario 3: Real-time Chat Feature

**Components Used:**
- Riverpod (StreamProvider) → Real-time messages
- Freezed → Message entities and chat state
- Dio + WebSocket → Real-time connection
- Drift → Message history storage
- Talker → Connection and message logging

**File Structure:**
```
features/chat/
├── data/
│   ├── models/message_model.dart
│   ├── services/chat_api.dart
│   └── repositories/chat_repository_impl.dart
├── domain/
│   ├── entities/message.dart
│   ├── entities/chat_room.dart
│   ├── repositories/chat_repository.dart
│   └── usecases/send_message_usecase.dart
└── presentation/
    ├── providers/chat_provider.dart
    ├── screens/chat_screen.dart
    └── widgets/message_bubble.dart
```

---

## 📊 Component Usage Guidelines

### When to Create a New Feature
- **Independent Business Domain**: User management, product catalog
- **Reusable Across App**: Authentication, notifications
- **Complex UI/Logic**: Multi-screen flows, complex state
- **Team Ownership**: Different developers working on different features

### When to Use Shared Components
- **Cross-cutting Concerns**: Logging, networking, storage
- **Common UI Elements**: Buttons, dialogs, loading indicators
- **Utility Functions**: Date formatting, validation
- **Global State**: User session, app settings

### Performance Considerations
- **Provider Scoping**: Use `ref.keepAlive()` for expensive providers
- **Lazy Loading**: Load data only when needed
- **Caching**: Cache API responses and computed values
- **Debouncing**: Prevent excessive API calls
- **Memory Management**: Dispose subscriptions and controllers

### Testing Strategy
- **Unit Tests**: Test business logic and utilities
- **Widget Tests**: Test UI components and interactions
- **Integration Tests**: Test feature flows
- **E2E Tests**: Test complete user journeys

This architecture provides a solid foundation for building scalable, maintainable, and testable Flutter applications while following industry best practices and modern development patterns.</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\Docs\roadmap\architectural_components_guide.md