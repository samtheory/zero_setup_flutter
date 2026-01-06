# Step 1: Setup FlexColorScheme 8.4.0

## Installation

Add to `pubspec.yaml`:
```yaml
dependencies:
  flex_color_scheme: ^8.4.0
  # Keep your existing dependencies
  flutter_riverpod: ^2.4.9
  # ... other deps
```

Run:
```bash
flutter pub get
```

## Basic Setup Structure

### 1. Create Theme Provider (Riverpod)

```dart
// lib/core/theme/theme_provider.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setLight() => state = ThemeMode.light;
  void setDark() => state = ThemeMode.dark;
  void setSystem() => state = ThemeMode.system;
}

/// Theme data provider
final themeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themeMode = ref.watch(themeModeProvider);

  // We'll build this in the next steps
  return FlexThemeData.light(
    scheme: FlexScheme.red,
    useMaterial3: true,
  );
});
```

### 2. Update main.dart

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_setup_flutter/app/app.dart';
import 'package:zero_setup_flutter/core/theme/theme_provider.dart';

void main() async {
  final bootstrapData = await Bootstrap.initialize(environment: EnvDev());

  runApp(
    ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(bootstrapData.preferencesService),
        secureStorageProvider.overrideWithValue(bootstrapData.secureStorage),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(themeDataProvider(context));

    return MaterialApp(
      theme: lightTheme,
      darkTheme: lightTheme, // We'll add dark theme later
      themeMode: themeMode,
      home: const App(),
    );
  }
}
```

## Key Concepts

### FlexScheme
Predefined color schemes that FlexColorScheme provides:
- `FlexScheme.red` - Your primary red color
- `FlexScheme.blue` - Your secondary blue color
- Custom schemes (we'll create yours)

### useMaterial3
Set to `true` for Material 3 design system with:
- Updated color system
- New component styles
- Better accessibility

### Theme Extensions
FlexColorScheme supports theme extensions for custom properties:
```dart
class MyThemeExtension extends ThemeExtension<MyThemeExtension> {
  // Your custom properties
}
```

## Next Step

Continue to [02_migrate_color_palettes.md](02_migrate_color_palettes.md) to convert your `PalletColor` system to FlexColorScheme format.
