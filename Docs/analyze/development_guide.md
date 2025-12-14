# Development Guide: Zero Setup Flutter

## Suggestions for Project Structure and Libraries

### 1. Database Migration
**Issue**: Architecture docs specify Isar, but pubspec uses Drift.
**Recommendation**: Migrate to Isar for better performance and features.

**Steps**:
1. Remove Drift dependencies
2. Add Isar dependencies
3. Update storage layer
4. Regenerate code

### 2. Feature Structure Standardization
**Current Issue**: Features have inconsistent structure.
**Recommendation**: Standardize all features with this structure:
```
features/
  feature_name/
    ├── data/
    │   ├── models/          # Freezed models
    │   ├── repositories/    # Repository implementations
    │   └── services/        # API services (Retrofit)
    ├── domain/
    │   ├── entities/        # Domain entities
    │   ├── repositories/    # Abstract repositories
    │   └── usecases/        # Business logic
    └── presentation/
        ├── providers/       # Riverpod providers
        ├── screens/         # UI screens
        ├── widgets/         # Feature-specific widgets
        └── controllers/     # State controllers
```

### 3. Environment Configuration
**Missing**: Environment-specific configs.
**Recommendation**: Add envied for environment variables.

### 4. Testing Enhancement
**Current**: Basic unit testing.
**Recommendation**: Add Patrol for E2E testing and improve test coverage.

### 5. Error Handling
**Enhancement**: Implement global error handling with Talker.

---

## 1. How to Define New Routes

### Location
- **Routes**: `lib/app/router/routes.dart`
- **Router Config**: `lib/app/router/router.dart`
- **Shells**: `lib/app/shells/` (if needed)

### Steps
1. **Add route constant** in `routes.dart`:
```dart
abstract class Routes {
  // Existing routes...
  static const newFeature = '/new-feature';
}
```

2. **Add route to router** in `router.dart`:
```dart
routes: [
  // Existing routes...
  GoRoute(
    path: Routes.newFeature,
    builder: (context, state) => const NewFeatureScreen(),
  ),
],
```

3. **For shell routes**, add to appropriate branch:
```dart
StatefulShellBranch(
  routes: [
    GoRoute(
      path: Routes.newFeature,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NewFeatureScreen(),
      ),
    ),
  ],
),
```

### Best Practices
- Use kebab-case for route paths: `/new-feature`
- Add auth guards if needed
- Use `NoTransitionPage` for shell routes to prevent transitions

---

## 2. How to Define New Feature

### Structure
Create new feature folder: `lib/features/new_feature/`

```
lib/features/new_feature/
├── data/
│   ├── models/
│   │   └── new_feature_model.dart
│   ├── repositories/
│   │   └── new_feature_repository_impl.dart
│   └── services/
│       └── new_feature_api.dart
├── domain/
│   ├── entities/
│   │   └── new_feature_entity.dart
│   ├── repositories/
│   │   └── new_feature_repository.dart
│   └── usecases/
│       └── get_new_feature_usecase.dart
└── presentation/
    ├── providers/
    │   └── new_feature_provider.dart
    ├── screens/
    │   └── new_feature_screen.dart
    ├── widgets/
    │   └── new_feature_widget.dart
    └── controllers/
        └── new_feature_controller.dart
```

### Implementation Steps

1. **Create Freezed Model** (`data/models/new_feature_model.dart`):
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_feature_model.freezed.dart';
part 'new_feature_model.g.dart';

@freezed
class NewFeatureModel with _$NewFeatureModel {
  const factory NewFeatureModel({
    required String id,
    required String name,
  }) = _NewFeatureModel;

  factory NewFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$NewFeatureModelFromJson(json);
}
```

2. **Create API Service** (`data/services/new_feature_api.dart`):
```dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/new_feature_model.dart';

part 'new_feature_api.g.dart';

@RestApi()
abstract class NewFeatureApi {
  factory NewFeatureApi(Dio dio) = _NewFeatureApi;

  @GET('/new-feature')
  Future<List<NewFeatureModel>> getNewFeatures();
}
```

3. **Create Repository** (`domain/repositories/new_feature_repository.dart`):
```dart
import '../entities/new_feature_entity.dart';

abstract class NewFeatureRepository {
  Future<List<NewFeatureEntity>> getNewFeatures();
}
```

4. **Create Repository Implementation** (`data/repositories/new_feature_repository_impl.dart`):
```dart
import '../../domain/repositories/new_feature_repository.dart';
import '../services/new_feature_api.dart';
import '../models/new_feature_model.dart';

class NewFeatureRepositoryImpl implements NewFeatureRepository {
  final NewFeatureApi _api;

  NewFeatureRepositoryImpl(this._api);

  @override
  Future<List<NewFeatureEntity>> getNewFeatures() async {
    final models = await _api.getNewFeatures();
    return models.map((model) => model.toEntity()).toList();
  }
}
```

5. **Create Provider** (`presentation/providers/new_feature_provider.dart`):
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/new_feature_repository.dart';

part 'new_feature_provider.g.dart';

@riverpod
class NewFeatureNotifier extends _$NewFeatureNotifier {
  @override
  Future<List<NewFeatureEntity>> build() async {
    final repository = ref.watch(newFeatureRepositoryProvider);
    return repository.getNewFeatures();
  }
}

@riverpod
NewFeatureRepository newFeatureRepository(NewFeatureRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  final api = NewFeatureApi(dio);
  return NewFeatureRepositoryImpl(api);
}
```

6. **Create Screen** (`presentation/screens/new_feature_screen.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/new_feature_provider.dart';

class NewFeatureScreen extends HookConsumerWidget {
  const NewFeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newFeatures = ref.watch(newFeatureNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('New Feature')),
      body: newFeatures.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(data[index].name),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
```

### Best Practices
- Use Freezed for all models
- Implement repository pattern
- Use Riverpod for state management
- Add error handling
- Write tests for each layer

---

## 3. How to Add New APIs to Network Core Services

### Location
- **API Services**: `lib/core/network/` and feature `data/services/`
- **Endpoints**: `lib/core/network/api_endpoints.dart`
- **Dio Client**: `lib/core/network/dio_client.dart`

### Steps

1. **Add endpoints** in `api_endpoints.dart`:
```dart
class ApiEndpoints {
  static const String baseUrl = 'https://api.example.com';
  static const String newFeature = '$baseUrl/new-feature';
}
```

2. **Create Retrofit API** in feature:
```dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'new_api.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class NewApi {
  factory NewApi(Dio dio) = _NewApi;

  @GET('/new-endpoint')
  Future<ResponseData> getNewData();
}
```

3. **Register in providers** (`lib/core/providers/core_providers.dart`):
```dart
final newApiProvider = Provider<NewApi>((ref) {
  final dio = ref.watch(dioProvider);
  return NewApi(dio);
});
```

4. **Add to DioClient** if global interceptor needed.

### Places to Change
- `lib/core/network/api_endpoints.dart` - Add endpoints
- `lib/core/network/dio_client.dart` - Add interceptors if needed
- `lib/core/providers/core_providers.dart` - Register API providers
- Feature `data/services/` - Create Retrofit services

---

## 4. How to Define New Store

### Location
- **Storage Services**: `lib/core/storage/`
- **Keys**: `lib/core/storage/storage_keys.dart`
- **Providers**: `lib/core/providers/core_providers.dart`

### For SharedPreferences
1. **Add key** in `storage_keys.dart`:
```dart
abstract class StorageKeys {
  static const String newSetting = 'new_setting';
}
```

2. **Add method** in `preferences_service.dart`:
```dart
Future<void> setNewSetting(String value) async {
  await _prefs.setString(StorageKeys.newSetting, value);
}

String? getNewSetting() {
  return _prefs.getString(StorageKeys.newSetting);
}
```

### For Secure Storage
1. **Add method** in `secure_storage_service.dart`:
```dart
Future<void> setToken(String token) async {
  await _storage.write(key: 'auth_token', value: token);
}

Future<String?> getToken() async {
  return await _storage.read(key: 'auth_token');
}
```

### For App Settings
Create a settings provider:
```dart
@riverpod
class AppSettingsNotifier extends _$AppSettingsNotifier {
  @override
  AppSettings build() {
    final prefs = ref.watch(preferencesServiceProvider);
    return AppSettings(
      theme: prefs.getTheme(),
      language: prefs.getLanguage(),
    );
  }

  Future<void> updateTheme(String theme) async {
    final prefs = ref.watch(preferencesServiceProvider);
    await prefs.setTheme(theme);
    state = state.copyWith(theme: theme);
  }
}
```

### Best Practices
- Use secure storage for sensitive data
- Use shared preferences for app settings
- Create typed providers for settings
- Handle migrations for storage changes

---

## 5. How to Define New Provider

### Location
- **Core Providers**: `lib/core/providers/core_providers.dart`
- **Feature Providers**: `features/feature/presentation/providers/`
- **Shared Providers**: `lib/shared/domain/providers/`

### Types of Providers

1. **Simple Provider** (for services):
```dart
final myServiceProvider = Provider<MyService>((ref) {
  return MyService();
});
```

2. **StateNotifier Provider** (for state management):
```dart
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  MyState build() {
    return MyState.initial();
  }

  void updateData(String data) {
    state = state.copyWith(data: data);
  }
}
```

3. **Future Provider** (for async data):
```dart
@riverpod
Future<List<Item>> items(ItemsRef ref) async {
  final repository = ref.watch(repositoryProvider);
  return repository.getItems();
}
```

4. **Stream Provider** (for real-time data):
```dart
@riverpod
Stream<List<Item>> itemsStream(ItemsStreamRef ref) {
  final repository = ref.watch(repositoryProvider);
  return repository.watchItems();
}
```

### Where to Put Providers
- **Core services**: `lib/core/providers/`
- **Feature-specific**: `features/feature/presentation/providers/`
- **Shared domain**: `lib/shared/domain/providers/`

### Best Practices
- Use `riverpod_annotation` for code generation
- Keep providers close to where they're used
- Use family providers for parameterized providers
- Add proper error handling

---

## 6. How to Call Toast and BottomSheet/Modal

### Toast Notifications (using toastification)

1. **Show Toast**:
```dart
import 'package:toastification/toastification.dart';

void showSuccessToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    title: const Text('Success'),
    description: Text(message),
    type: ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 3),
  );
}

void showErrorToast(BuildContext context, String message) {
  toastification.show(
    context: context,
    title: const Text('Error'),
    description: Text(message),
    type: ToastificationType.error,
    autoCloseDuration: const Duration(seconds: 5),
  );
}
```

2. **Setup in App** (add to `lib/app/app.dart`):
```dart
return ToastificationWrapper(
  child: MaterialApp.router(
    // ... existing config
  ),
);
```

### Bottom Sheet

1. **Simple Bottom Sheet**:
```dart
void showSimpleBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Bottom Sheet Content'),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    ),
  );
}
```

2. **Custom Bottom Sheet Widget**:
```dart
class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Content
        ],
      ),
    );
  }
}

// Usage
showModalBottomSheet(
  context: context,
  builder: (context) => const CustomBottomSheet(),
);
```

### Modal/Dialog

1. **Simple Dialog**:
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Confirm'),
    content: const Text('Are you sure?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('Confirm'),
      ),
    ],
  ),
);
```

2. **Custom Modal**:
```dart
showDialog(
  context: context,
  builder: (context) => Dialog(
    child: Container(
      padding: const EdgeInsets.all(16),
      child: const Text('Custom Modal'),
    ),
  ),
);
```

### Best Practices
- Use toastification for consistent toasts
- Create reusable bottom sheet widgets
- Handle responsive design for modals
- Add proper animations
- Consider accessibility

---

## 7. Logs with Talker

### Setup
Talker is already configured in the project.

### Usage

1. **Get Talker Instance**:
```dart
final talker = ref.watch(talkerProvider);
```

2. **Log Different Levels**:
```dart
// Info
talker.info('User logged in', userId);

// Error
talker.error('API call failed', error);

// Warning
talker.warning('Deprecated API usage');

// Debug
talker.debug('Processing data', data);

// Verbose
talker.verbose('Detailed debug info');
```

3. **Log with Context**:
```dart
talker.logTyped(
  MyCustomLog('Custom message'),
  title: 'Custom Title',
);
```

4. **Handle Exceptions**:
```dart
try {
  // risky operation
} catch (e, st) {
  talker.handle(e, st, 'Operation failed');
}
```

### Dio Logging
Dio requests/responses are automatically logged via `talker_dio_logger`.

### Riverpod Logging
Provider changes are automatically logged via `talker_riverpod_logger`.

### Custom Logs
Create custom log types:
```dart
class ApiLog extends TalkerLog {
  ApiLog(String message) : super(message);

  @override
  String get title => 'API';

  @override
  AnsiPen get pen => AnsiPen()..xterm(46); // Green color
}
```

### Best Practices
- Use appropriate log levels
- Include context in logs
- Use structured logging
- Don't log sensitive data
- Use handle() for exceptions
- Check logs in Talker Flutter UI

---

## 8. Freezed Code Generation

### Current Version
The project uses `freezed: ^3.2.3` and `freezed_annotation: ^3.1.0`.

### Basic Usage

1. **Create Freezed Class**:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required int age,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

2. **Generate Code**:
```bash
flutter pub run build_runner build
```

### Advanced Features

1. **Union Types**:
```dart
@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.error(String message) = Error<T>;
}
```

2. **Custom Methods**:
```dart
@freezed
class User with _$User {
  const User._(); // Add private constructor for methods

  const factory User({
    required String firstName,
    required String lastName,
  }) = _User;

  String get fullName => '$firstName $lastName';
}
```

3. **Validation**:
```dart
@freezed
class Email with _$Email {
  const Email._();

  const factory Email(String value) = _Email;

  @override
  String toString() => value;

  bool get isValid => RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value);
}
```

4. **JSON Key Customization**:
```dart
@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'user_id') required String id,
    @JsonKey(defaultValue: '') required String name,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

### Best Practices
- Use `const` constructors when possible
- Add `fromJson` for API models
- Use union types for state management
- Add custom methods in private constructor
- Use JSON keys for API compatibility
- Run `build_runner` after changes

---

## 9. Testing Strategy

### Current Setup
- Unit tests with `flutter_test`
- Mocking with `mocktail`
- Fake data with `faker`
- Screenshot tests with `golden_toolkit`

### Should You Add Patrol?

**Yes, recommended for E2E testing.**

### Patrol Setup

1. **Add Dependencies**:
```yaml
dev_dependencies:
  patrol: ^3.0.0
  patrol_cli: ^0.0.1
```

2. **Install Patrol CLI**:
```bash
flutter pub global activate patrol_cli
```

3. **Configure** in `pubspec.yaml`:
```yaml
flutter:
  # ... existing config
  
patrol:
  app_name: Zero Setup Flutter
  android:
    package_name: com.example.zero_setup_flutter
  ios:
    bundle_id: com.example.zeroSetupFlutter
```

### Testing Structure

```
test/
├── unit/                    # Unit tests
│   ├── core/
│   ├── features/
│   └── shared/
├── widget/                  # Widget tests
│   ├── core/
│   ├── features/
│   └── shared/
├── integration/             # Integration tests
│   └── flows/
└── e2e/                     # E2E tests (Patrol)
    ├── features/
    └── flows/
```

### Test-Driven Development (TDD) Approach

1. **Write Test First**:
```dart
// test/features/auth/presentation/providers/auth_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MockAuthRepository mockRepository;
  late AuthNotifier notifier;

  setUp(() {
    mockRepository = MockAuthRepository();
    notifier = AuthNotifier(repository: mockRepository);
  });

  group('AuthNotifier', () {
    test('should emit loading then success on successful login', () async {
      // Arrange
      when(() => mockRepository.login(any(), any()))
          .thenAnswer((_) async => const Right(user));

      // Act
      await notifier.login('email', 'password');

      // Assert
      verify(() => mockRepository.login('email', 'password')).called(1);
      expect(notifier.state, isA<AuthStateAuthenticated>());
    });
  });
}
```

2. **Implement Code** to make test pass.

3. **Refactor** while keeping tests green.

### What to Test

1. **Unit Tests**:
   - Repository implementations
   - Use cases
   - Providers (business logic)
   - Utilities
   - Models (serialization)

2. **Widget Tests**:
   - UI components
   - Screen interactions
   - State changes in UI

3. **Integration Tests**:
   - Full feature flows
   - API integration
   - Database operations

4. **E2E Tests (Patrol)**:
   - User journeys
   - Critical flows
   - Cross-platform compatibility

### Best Practices

1. **Test Pyramid**:
   - 70% Unit tests
   - 20% Integration tests
   - 10% E2E tests

2. **Test Naming**: `describe_what_it_does_when_condition`

3. **Mock External Dependencies**: API calls, database, file system

4. **Use Fakes for Complex Dependencies**

5. **Test Error Cases**: Don't just test happy paths

6. **Keep Tests Fast**: Unit tests should be < 100ms

### Running Tests

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# E2E tests (Patrol)
patrol test
```

### CI/CD Integration
Add to your pipeline:
```yaml
- run: flutter test --coverage
- run: flutter test integration_test/
- run: patrol test --coverage
```

This comprehensive testing strategy ensures your app is reliable, maintainable, and ready for production.</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\docs\analyze\development_guide.md