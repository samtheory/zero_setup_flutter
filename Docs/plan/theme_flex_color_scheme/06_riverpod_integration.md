# Step 6: Riverpod Integration

## Theme State Management with Riverpod

Your current system uses `ThemeType` enum (light, dark, system). We'll enhance this with Riverpod for reactive theme switching.

## Enhanced Theme Provider

### 1. Update Theme Provider

```dart
// lib/core/theme/theme_provider.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_flex_scheme.dart';
import 'theme_extensions.dart';
import 'button_themes.dart';
import 'component_extensions.dart';

/// Theme mode enum (enhanced from your ThemeType)
enum AppThemeMode {
  light,
  dark,
  system;

  String get displayName {
    switch (this) {
      case AppThemeMode.light:
        return 'روشن'; // Persian for Light
      case AppThemeMode.dark:
        return 'تیره'; // Persian for Dark
      case AppThemeMode.system:
        return 'سیستم'; // Persian for System
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

/// Theme mode notifier with persistence
class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  ThemeModeNotifier() : super(AppThemeMode.system) {
    _loadThemeMode();
  }

  static const String _themeKey = 'app_theme_mode';

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeKey);
    if (savedMode != null) {
      state = AppThemeMode.values.firstWhere(
        (mode) => mode.name == savedMode,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  Future<void> _saveThemeMode(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<void> setLight() async {
    state = AppThemeMode.light;
    await _saveThemeMode(state);
  }

  Future<void> setDark() async {
    state = AppThemeMode.dark;
    await _saveThemeMode(state);
  }

  Future<void> setSystem() async {
    state = AppThemeMode.system;
    await _saveThemeMode(state);
  }

  Future<void> toggle() async {
    switch (state) {
      case AppThemeMode.light:
        await setDark();
        break;
      case AppThemeMode.dark:
        await setSystem();
        break;
      case AppThemeMode.system:
        await setLight();
        break;
    }
  }
}

/// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// Computed theme mode for MaterialApp
final materialThemeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeModeProvider).themeMode;
});
```

### 2. Separate Light and Dark Theme Providers

```dart
/// Light theme data provider
final lightThemeDataProvider = Provider<ThemeData>((ref) {
  final colorScheme = CustomFlexScheme.redScheme.light.toColorScheme(Brightness.light);
  final buttonTheme = createButtonTheme(colorScheme);
  final switchTheme = createSwitchTheme(colorScheme);
  final checkboxTheme = createCheckboxTheme(colorScheme);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      // ... your light theme sub themes
    ),
    extensions: [
      _createLightExtension(),
      buttonTheme,
      switchTheme,
      checkboxTheme,
    ],
  );
});

/// Dark theme data provider
final darkThemeDataProvider = Provider<ThemeData>((ref) {
  final colorScheme = CustomFlexScheme.redScheme.dark.toColorScheme(Brightness.dark);
  final buttonTheme = createButtonTheme(colorScheme);
  final switchTheme = createSwitchTheme(colorScheme);
  final checkboxTheme = createCheckboxTheme(colorScheme);

  return FlexThemeData.dark(
    colors: CustomFlexScheme.redScheme.dark,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      // ... your dark theme sub themes
    ),
    extensions: [
      _createDarkExtension(),
      buttonTheme,
      switchTheme,
      checkboxTheme,
    ],
  );
});

/// Create dark theme extension
AppThemeExtension _createDarkExtension() {
  return const AppThemeExtension(
    colors: AppColorPalette(
      primary: Colors.red, // Darker red for dark mode
      secondary: Colors.blue, // Darker blue for dark mode
      text: Colors.grey,
      sunriseYellow: MaterialColor(0xFFFFD700, {/* dark shades */}),
      green: MaterialColor(0xFF10B981, {/* dark shades */}),
      base: MaterialColor(0xFF6B7280, {/* dark shades */}),
    ),
    typography: AppTypography(
      displayLarge: TextStyle(/* dark mode IRANSansX styles */),
      // ... other dark text styles
    ),
    decorations: AppDecorations(
      shadows: AppShadows(
        small: [BoxShadow(/* darker shadows */)],
        // ... other dark shadows
      ),
      gradients: AppGradients(
        primary: LinearGradient(/* dark gradients */),
        // ... other dark gradients
      ),
    ),
  );
}
```

### 3. Update main.dart

```dart
// lib/main.dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(materialThemeModeProvider);
    final lightTheme = ref.watch(lightThemeDataProvider);
    final darkTheme = ref.watch(darkThemeDataProvider);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const App(),
    );
  }
}
```

## Theme Switcher Widget

### 1. Create Theme Switcher

```dart
// lib/shared/widgets/theme_switcher.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_setup_flutter/core/theme/theme_provider.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return PopupMenuButton<AppThemeMode>(
      onSelected: (mode) async {
        switch (mode) {
          case AppThemeMode.light:
            await ref.read(themeModeProvider.notifier).setLight();
            break;
          case AppThemeMode.dark:
            await ref.read(themeModeProvider.notifier).setDark();
            break;
          case AppThemeMode.system:
            await ref.read(themeModeProvider.notifier).setSystem();
            break;
        }
      },
      itemBuilder: (context) => AppThemeMode.values.map((mode) {
        return PopupMenuItem(
          value: mode,
          child: Row(
            children: [
              Icon(mode.icon),
              const SizedBox(width: 8),
              Text(mode.displayName),
              if (currentMode == mode) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(currentMode.icon),
            const SizedBox(width: 8),
            Text(currentMode.displayName),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
```

### 2. Create Quick Theme Toggle Button

```dart
// lib/shared/widgets/theme_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_setup_flutter/core/theme/theme_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return IconButton(
      onPressed: () async {
        await ref.read(themeModeProvider.notifier).toggle();
      },
      icon: Icon(currentMode.icon),
      tooltip: 'تغییر تم (${currentMode.displayName})',
    );
  }
}
```

## Usage in App

### 1. Add to AppBar

```dart
// lib/app/app.dart
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: const [
          ThemeSwitcher(),
          // or use ThemeToggleButton() for simple toggle
        ],
      ),
      body: const HomePage(),
    );
  }
}
```

### 2. Add to Settings Page

```dart
// lib/features/settings/settings_page.dart
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(currentMode.displayName),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Show theme selection dialog
              showDialog(
                context: context,
                builder: (context) => const ThemeSelectionDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ThemeSelectionDialog extends ConsumerWidget {
  const ThemeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return AlertDialog(
      title: const Text('انتخاب تم'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: AppThemeMode.values.map((mode) {
          return RadioListTile<AppThemeMode>(
            title: Row(
              children: [
                Icon(mode.icon),
                const SizedBox(width: 8),
                Text(mode.displayName),
              ],
            ),
            value: mode,
            groupValue: currentMode,
            onChanged: (value) async {
              if (value != null) {
                switch (value) {
                  case AppThemeMode.light:
                    await ref.read(themeModeProvider.notifier).setLight();
                    break;
                  case AppThemeMode.dark:
                    await ref.read(themeModeProvider.notifier).setDark();
                    break;
                  case AppThemeMode.system:
                    await ref.read(themeModeProvider.notifier).setSystem();
                    break;
                }
                Navigator.of(context).pop();
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
```

## Testing Theme Switching

Create a theme test page:

```dart
// lib/features/theme_test/theme_switching_test_page.dart
class ThemeSwitchingTestPage extends ConsumerWidget {
  const ThemeSwitchingTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final appTheme = Theme.of(context).extension<AppThemeExtension>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Switching Test'),
        actions: const [ThemeSwitcher()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Current theme info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Theme: ${currentMode.displayName}'),
                  Text('Brightness: ${Theme.of(context).brightness}'),
                  Text('Primary Color: ${colorScheme.primary}'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Test components
          Text(
            'Typography Test',
            style: appTheme.typography.headlineMedium,
          ),

          const SizedBox(height: 10),

          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: appTheme.decorations.gradients.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('Gradient Test'),
            ),
          ),

          const SizedBox(height: 20),

          // Test buttons
          CustomButton(
            variant: ButtonVariant.primary,
            onPressed: () {},
            child: const Text('Primary Button'),
          ),

          const SizedBox(height: 10),

          CustomButton(
            variant: ButtonVariant.secondary,
            onPressed: () {},
            child: const Text('Secondary Button'),
          ),

          // Test form components
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Test Switch'),
            value: true,
            onChanged: (value) {},
          ),

          CheckboxListTile(
            title: const Text('Test Checkbox'),
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
```

## Next Step

Continue to [07_migration_execution.md](07_migration_execution.md) to execute the migration and replace your old theme system.
