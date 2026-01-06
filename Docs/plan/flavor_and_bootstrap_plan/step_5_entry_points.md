# Step 5: Entry Points

This step involves creating separate `main` files for each flavor. These files will be the entry points for the `dev`, `stag`, and `prod` environments.

## 1. Create `lib/main_dev.dart`

```dart
// lib/main_dev.dart

import 'package:zero_setup_flutter/app/bootstrap.dart';
import 'package:zero_setup_flutter/env/env_dev.dart';

void main() {
  bootstrap(devConfig);
}
```

## 2. Create `lib/main_stag.dart`

```dart
// lib/main_stag.dart

import 'package:zero_setup_flutter/app/bootstrap.dart';
import 'package:zero_setup_flutter/env/env_stag.dart';

void main() {
  bootstrap(stagConfig);
}
```

## 3. Create `lib/main_prod.dart`

```dart
// lib/main_prod.dart

import 'package:zero_setup_flutter/app/bootstrap.dart';
import 'package:zero_setup_flutter/env/env_prod.dart';

void main() {
  bootstrap(prodConfig);
}
```

### Explanation:

Each of these files has a single responsibility: to import the correct environment configuration and pass it to the `bootstrap` function. This keeps the main entry point of the app clean and makes it easy to manage different environments.

The `main.dart` file can be kept for development purposes or removed if you prefer to always use flavors. For this plan, we will assume `main.dart` is no longer the primary entry point.
