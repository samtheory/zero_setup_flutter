# Step 4: Bootstrap Process

This step details the implementation of the `bootstrap.dart` file. The purpose of this file is to centralize the initialization of services and dependencies, thus simplifying the `main.dart` file.

## 1. Modify `lib/app/bootstrap.dart`

Open the `lib/app/bootstrap.dart` file and replace its content with the following:

```dart
// lib/app/bootstrap.dart

import 'package:flutter/material.dart';
import 'package.hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/config/app_config.dart';
import 'package:zero_setup_flutter/core/database/app_database.dart';
import 'package:zero_setup_flutter/core/logger/logger_provider.dart';
import 'package:zero_setup_flutter/core/network/dio_client.dart';
import 'package:zero_setup_flutter/core/providers/config_provider.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';
import 'package:zero_setup_flutter/core/storage/secure_storage_service.dart';

Future<void> bootstrap(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final preferencesService = PreferencesService();
  await preferencesService.init();
  final secureStorage = SecureStorageService();
  final talker = TalkerFlutter.init();
  final dio = createDioClient(talker);
  final db = AppDatabase();

  runApp(
    ProviderScope(
      observers: [talkerRiverpodObserver],
      overrides: [
        // Core Providers
        appConfigProvider.overrideWithValue(appConfig),
        preferencesServiceProvider.overrideWithValue(preferencesService),
        secureStorageProvider.overrideWithValue(secureStorage),
        talkerProvider.overrideWithValue(talker),
        dioProvider.overrideWithValue(dio),
        appDatabaseProvider.overrideWithValue(db),
      ],
      child: const App(),
    ),
  );
}
```

### Explanation:

*   **`Future<void> bootstrap(AppConfig appConfig)`:** The `bootstrap` function now accepts an `AppConfig` object. This allows us to pass the environment-specific configuration to the initialization process.
*   **Service Initialization:** All the core services are initialized here. This includes `PreferencesService`, `SecureStorageService`, `Talker`, `Dio`, and `AppDatabase`.
*   **Provider Overrides:** The `ProviderScope`'s `overrides` property is used to provide the initialized services to the rest of the application. The `appConfigProvider` is also overridden with the `appConfig` that was passed into the `bootstrap` function.

This approach keeps the `main.dart` files clean and focused on their single responsibility: setting up the environment and calling the bootstrap process.
