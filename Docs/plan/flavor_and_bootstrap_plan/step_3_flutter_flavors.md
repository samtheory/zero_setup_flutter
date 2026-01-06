# Step 3: Flutter Flavors (Dart Code)

This step covers the Dart side of implementing flavors. We will create a configuration class and environment-specific files to hold the settings for each flavor.

## 1. Create the `AppConfig` class

Create a new directory `lib/core/config` and inside it, a file named `app_config.dart`.

```dart
// lib/core/config/app_config.dart

enum Environment { dev, stag, prod }

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.apiBaseUrl,
  });

  final Environment environment;
  final String appName;
  final String apiBaseUrl;
}
```

This class defines the structure of our environment configuration.

## 2. Create Environment-Specific Configuration Files

Create a new directory `lib/env`. Inside this directory, create the following files:

### `lib/env/env_dev.dart`
```dart
// lib/env/env_dev.dart

import 'package:zero_setup_flutter/core/config/app_config.dart';

final AppConfig devConfig = AppConfig(
  environment: Environment.dev,
  appName: 'Zero Setup (Dev)',
  apiBaseUrl: 'https://api.dev.example.com',
);
```

### `lib/env/env_stag.dart`
```dart
// lib/env/env_stag.dart

import 'package:zero_setup_flutter/core/config/app_config.dart';

final AppConfig stagConfig = AppConfig(
  environment: Environment.stag,
  appName: 'Zero Setup (Stag)',
  apiBaseUrl: 'https://api.stag.example.com',
);
```

### `lib/env/env_prod.dart`
```dart
// lib/env/env_prod.dart

import 'package:zero_setup_flutter/core/config/app_config.dart';

final AppConfig prodConfig = AppConfig(
  environment: Environment.prod,
  appName: 'Zero Setup',
  apiBaseUrl: 'https://api.example.com',
);
```

These files provide the concrete configuration values for each environment.

## 3. Provide the `AppConfig`

We need a way to access the `AppConfig` throughout the app. We will use a `Provider` for this.

Create a new file `lib/core/providers/config_provider.dart`

```dart
// lib/core/providers/config_provider.dart

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/core/config/app_config.dart';

// This provider will be overridden in the main entry point of each flavor.
final appConfigProvider = Provider<AppConfig>((ref) {
  // The default value can be any of the configs, but it will be overridden.
  // It's good practice to throw an error if it's not overridden.
  throw UnimplementedError('appConfigProvider must be overridden');
});
```

We will override this provider in the `main_` file for each flavor.
