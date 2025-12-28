# 📋 Project Coding Rules & Conventions

> **IMPORTANT**: Always follow these rules when generating or modifying code in this project.

---

## 🔧 State Management (Riverpod)

### ✅ ALWAYS use `Notifier` pattern (NOT StateNotifier)

```dart
// ✅ CORRECT - Use Notifier
class MyNotifier extends Notifier<MyState> {
  @override
  MyState build() {
    // Inject dependencies here
    final repo = ref.watch(myRepositoryProvider);
    return MyState.initial();
  }
  
  void doAction() {
    state = state.copyWith(...);
  }
}

final myProvider = NotifierProvider<MyNotifier, MyState>(MyNotifier.new);
```

```dart
// ❌ WRONG - Don't use StateNotifier (legacy)
class MyNotifier extends StateNotifier<MyState> { ... }
final myProvider = StateNotifierProvider<MyNotifier, MyState>((ref) => ...);
```

### Provider Types Reference:
| Use Case | Provider Type |
|----------|---------------|
| State + Actions | `NotifierProvider<N, S>(N.new)` |
| Async State + Actions | `AsyncNotifierProvider<N, S>(N.new)` |
| Simple value/service | `Provider<T>((ref) => ...)` |
| Future data | `FutureProvider<T>((ref) async => ...)` |
| Stream data | `StreamProvider<T>((ref) => ...)` |

---

## 📦 Freezed Models

### ✅ ALWAYS use `sealed` keyword for Freezed classes

```dart
// ✅ CORRECT - Use sealed
@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

```dart
// ❌ WRONG - Don't use plain class
@freezed
class UserModel with _$UserModel { ... }
```

### State classes should also be sealed:
```dart
@freezed
sealed class MyState with _$MyState {
  const factory MyState({
    @Default(false) bool isLoading,
    String? error,
  }) = _MyState;

  const MyState._();

  // Computed getters
  bool get hasError => error != null;
}
```

---

## 🌐 API Services (Data Layer)

### ✅ ALWAYS use Retrofit for API services

```dart
// ✅ CORRECT - Use Retrofit
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'my_api_service.g.dart';

@RestApi()
abstract class MyApiService {
  factory MyApiService(Dio dio, {String baseUrl}) = _MyApiService;

  @GET('/items')
  Future<List<ItemModel>> getItems();

  @GET('/items/{id}')
  Future<ItemModel> getItem(@Path('id') int id);

  @POST('/items')
  Future<ItemModel> createItem(@Body() CreateItemRequest request);

  @PUT('/items/{id}')
  Future<ItemModel> updateItem(@Path('id') int id, @Body() UpdateItemRequest request);

  @DELETE('/items/{id}')
  Future<void> deleteItem(@Path('id') int id);
}
```

```dart
// ❌ WRONG - Don't use raw Dio calls in services
class MyApiService {
  final Dio _dio;
  Future<List<Item>> getItems() async {
    final response = await _dio.get('/items');
    return ...;
  }
}
```

---

## 📁 Feature Structure

```
lib/features/my_feature/
├── data/
│   ├── models/           # Freezed models (sealed)
│   │   └── my_model.dart
│   ├── repositories/     # Repository implementations
│   │   └── my_repository_impl.dart
│   └── services/         # Retrofit API services
│       └── my_api_service.dart
├── domain/
│   ├── repositories/     # Abstract interfaces
│   │   └── my_repository.dart
│   └── usecases/         # Business logic (optional)
│       └── my_usecase.dart
├── presentation/
│   ├── providers/        # Notifier + State
│   │   ├── my_provider.dart
│   │   └── my_state.dart
│   ├── screens/          # UI screens
│   │   └── my_screen.dart
│   └── widgets/          # Feature widgets
│       └── my_widget.dart
└── my_feature.dart       # Barrel exports
```

---

## 📝 Quick Checklist

When generating/modifying code, verify:

- [ ] Using `Notifier` not `StateNotifier`
- [ ] Using `NotifierProvider` not `StateNotifierProvider`
- [ ] Freezed models are `sealed`
- [ ] API services use `@RestApi()` Retrofit annotation
- [ ] Dependencies injected via `ref.watch()` in `build()` method
- [ ] Repository interface in `domain/` layer
- [ ] Repository implementation in `data/` layer

---

## 🏷️ Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Models | `XxxModel` | `UserModel`, `ItemModel` |
| Requests | `XxxRequest` | `CreateUserRequest`, `UpdateItemRequest` |
| States | `XxxState` | `UserState`, `ItemListState` |
| Notifiers | `XxxNotifier` | `UserNotifier`, `ItemListNotifier` |
| Repositories | `XxxRepository` | `UserRepository` (interface) |
| Repo Impl | `XxxRepositoryImpl` | `UserRepositoryImpl` |
| API Services | `XxxApiService` | `UserApiService` |
| UseCases | `XxxUseCase` | `LogoutUseCase`, `GetUserUseCase` |
| Providers | `xxxProvider` | `userProvider`, `itemListProvider` |
| Screens | `XxxScreen` | `UserProfileScreen`, `ItemListScreen` |

---

*Last updated: December 2025*
