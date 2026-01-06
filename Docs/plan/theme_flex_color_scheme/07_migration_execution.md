# Step 7: Migration Execution

## Step-by-Step Migration Process

Now we'll execute the migration by replacing your current `app_theme.dart` with the new FlexColorScheme system.

## Phase 1: Backup and Preparation

### 1. Backup Current Theme

```bash
# Create backup of current theme file
cp lib/core/theme/app_theme.dart lib/core/theme/app_theme.dart.backup
```

### 2. Create New Theme Structure

```bash
# Create the new theme files
mkdir -p lib/core/theme
touch lib/core/theme/theme_provider.dart
touch lib/core/theme/custom_flex_scheme.dart
touch lib/core/theme/theme_extensions.dart
touch lib/core/theme/button_themes.dart
touch lib/core/theme/component_extensions.dart
```

## Phase 2: Implement Core Files

### 1. Create Custom FlexScheme

```dart
// lib/core/theme/custom_flex_scheme.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Custom FlexScheme based on your PalletColor system
class CustomFlexScheme {
  static const FlexSchemeData redScheme = FlexSchemeData(
    name: 'Red Scheme',
    description: 'Custom red color scheme based on app theme',
    light: FlexSchemeColor(
      primary: Color(0xFFDC2626),      // From your primaryColor
      primaryContainer: Color(0xFFFEE2E2), // Light red background
      secondary: Color(0xFF2563EB),    // From your secondaryColor
      secondaryContainer: Color(0xFFDBEAFE), // Light blue background
      tertiary: Color(0xFFFFD700),     // sunriseYellow
      tertiaryContainer: Color(0xFFFFF9C4), // Light yellow background
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFFEE2E2),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFFF87171),      // Lighter red for dark mode
      primaryContainer: Color(0xFF7F1D1D), // Dark red background
      secondary: Color(0xFF60A5FA),    // Lighter blue for dark mode
      secondaryContainer: Color(0xFF1E3A8A), // Dark blue background
      tertiary: Color(0xFFFCD34D),     // Lighter yellow for dark mode
      tertiaryContainer: Color(0xFF92400E), // Dark yellow background
      error: Color(0xFFF87171),
      errorContainer: Color(0xFF7F1D1D),
    ),
  );
}
```

### 2. Create Theme Extensions

```dart
// lib/core/theme/theme_extensions.dart
import 'package:flutter/material.dart';

class AppColorPalette extends ThemeExtension<AppColorPalette> {
  const AppColorPalette({
    required this.primary,
    required this.secondary,
    required this.text,
    required this.sunriseYellow,
    required this.green,
    required this.base,
  });

  final MaterialColor primary;
  final MaterialColor secondary;
  final MaterialColor text;
  final MaterialColor sunriseYellow;
  final MaterialColor green;
  final MaterialColor base;

  @override
  ThemeExtension<AppColorPalette> copyWith({/* implement */}) {/* implement */}
  @override
  ThemeExtension<AppColorPalette> lerp(/* params */) {/* implement */}
}

class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayLarge,
    required this.displayMedium,
    // ... other text styles from your current theme
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  // ... other text styles

  @override
  ThemeExtension<AppTypography> copyWith({/* implement */}) {/* implement */}
  @override
  ThemeExtension<AppTypography> lerp(/* params */) {/* implement */}
}

class AppDecorations extends ThemeExtension<AppDecorations> {
  const AppDecorations({
    required this.shadows,
    required this.gradients,
  });

  final AppShadows shadows;
  final AppGradients gradients;

  @override
  ThemeExtension<AppDecorations> copyWith({/* implement */}) {/* implement */}
  @override
  ThemeExtension<AppDecorations> lerp(/* params */) {/* implement */}
}

class AppShadows {
  const AppShadows({
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
  });

  final List<BoxShadow> small;
  final List<BoxShadow> medium;
  final List<BoxShadow> large;
  final List<BoxShadow> extraLarge;

  AppShadows lerp(AppShadows other, double t) {/* implement */}
}

class AppGradients {
  const AppGradients({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.error,
    required this.warning,
  });

  final LinearGradient primary;
  final LinearGradient secondary;
  final LinearGradient success;
  final LinearGradient error;
  final LinearGradient warning;

  AppGradients lerp(AppGradients other, double t) {/* implement */}
}

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.colors,
    required this.typography,
    required this.decorations,
  });

  final AppColorPalette colors;
  final AppTypography typography;
  final AppDecorations decorations;

  @override
  ThemeExtension<AppThemeExtension> copyWith({/* implement */}) {/* implement */}
  @override
  ThemeExtension<AppThemeExtension> lerp(/* params */) {/* implement */}
}
```

### 3. Create Button Themes

```dart
// lib/core/theme/button_themes.dart
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, success, error, warning }

class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  const AppButtonTheme({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.error,
    required this.warning,
  });

  final ButtonStyle primary;
  final ButtonStyle secondary;
  final ButtonStyle success;
  final ButtonStyle error;
  final ButtonStyle warning;

  ButtonStyle getVariant(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary: return primary;
      case ButtonVariant.secondary: return secondary;
      case ButtonVariant.success: return success;
      case ButtonVariant.error: return error;
      case ButtonVariant.warning: return warning;
    }
  }

  @override
  ThemeExtension<AppButtonTheme> copyWith({/* implement */}) {/* implement */}
  @override
  ThemeExtension<AppButtonTheme> lerp(/* params */) {/* implement */}
}

AppButtonTheme createButtonTheme(ColorScheme colorScheme) {
  // Copy your button styles from current theme
  return AppButtonTheme(
    primary: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      // ... copy from your current theme
    ),
    // ... other button styles
  );
}
```

### 4. Create Theme Provider

```dart
// lib/core/theme/theme_provider.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_flex_scheme.dart';
import 'theme_extensions.dart';
import 'button_themes.dart';

enum AppThemeMode { light, dark, system }

class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  ThemeModeNotifier() : super(AppThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString('app_theme_mode');
    if (savedMode != null) {
      state = AppThemeMode.values.firstWhere(
        (mode) => mode.name == savedMode,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  Future<void> setLight() async {
    state = AppThemeMode.light;
    await _saveThemeMode();
  }

  Future<void> setDark() async {
    state = AppThemeMode.dark;
    await _saveThemeMode();
  }

  Future<void> setSystem() async {
    state = AppThemeMode.system;
    await _saveThemeMode();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme_mode', state.name);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  return ThemeModeNotifier();
});

final materialThemeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeModeProvider).themeMode;
});

AppThemeExtension _createLightExtension() {
  // Copy your extension data from current theme
  return const AppThemeExtension(
    colors: AppColorPalette(
      primary: Colors.red,
      secondary: Colors.blue,
      // ... copy from your current OnAppTheme
    ),
    typography: AppTypography(
      displayLarge: TextStyle(/* copy from your current theme */),
      // ... other text styles
    ),
    decorations: AppDecorations(
      shadows: AppShadows(/* copy from your current theme */),
      gradients: AppGradients(/* copy from your current theme */),
    ),
  );
}

final lightThemeDataProvider = Provider<ThemeData>((ref) {
  final colorScheme = CustomFlexScheme.redScheme.light.toColorScheme(Brightness.light);
  final buttonTheme = createButtonTheme(colorScheme);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      // Copy your component theming from current theme
      elevatedButtonSchemeColor: SchemeColor.primary,
      // ... other sub themes
    ),
    extensions: [
      _createLightExtension(),
      buttonTheme,
    ],
  );
});

final darkThemeDataProvider = Provider<ThemeData>((ref) {
  final colorScheme = CustomFlexScheme.redScheme.dark.toColorScheme(Brightness.dark);
  final buttonTheme = createButtonTheme(colorScheme);

  return FlexThemeData.dark(
    colors: CustomFlexScheme.redScheme.dark,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      // Copy your dark component theming
    ),
    extensions: [
      _createDarkExtension(),
      buttonTheme,
    ],
  );
});

AppThemeExtension _createDarkExtension() {
  // Create dark version of your extensions
  return const AppThemeExtension(/* dark theme data */);
}
```

## Phase 3: Update App Files

### 1. Update main.dart

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  // ... your existing bootstrap code

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

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

### 2. Update Any Files Using Old Theme

Search for files using your old theme system:

```bash
grep -r "ThemeType" lib/
grep -r "OnAppTheme" lib/
grep -r "PalletColor" lib/
```

Update these files to use the new system:

```dart
// Before
final theme = Theme.of(context).theme();

// After
final appTheme = Theme.of(context).extension<AppThemeExtension>()!;
final colors = appTheme.colors;
final typography = appTheme.typography;
```

## Phase 4: Testing and Validation

### 1. Run the App

```bash
flutter run
```

### 2. Test Theme Switching

Add theme switcher to your app and test all modes.

### 3. Test Components

Verify all components look correct:
- Buttons
- Switches
- Checkboxes
- AppBar
- BottomNavigationBar
- DatePicker

### 4. Test Extensions

Verify your custom extensions work:

```dart
// Test in any widget
@override
Widget build(BuildContext context) {
  final appTheme = Theme.of(context).extension<AppThemeExtension>()!;
  
  return Container(
    decoration: BoxDecoration(
      gradient: appTheme.decorations.gradients.primary,
      boxShadow: appTheme.decorations.shadows.medium,
    ),
    child: Text(
      'Test',
      style: appTheme.typography.headlineMedium,
    ),
  );
}
```

## Phase 5: Cleanup

### 1. Remove Old Theme File

After confirming everything works:

```bash
rm lib/core/theme/app_theme.dart
```

### 2. Update Imports

Remove old theme imports from files that no longer need them.

### 3. Update Documentation

Update any documentation that referenced the old theme system.

## Troubleshooting

### Common Issues

1. **Missing Extensions**: Make sure all extensions are added to the `extensions` list in theme providers.

2. **Color Issues**: Verify your `CustomFlexScheme` colors match your original `PalletColor` values.

3. **Typography Issues**: Ensure `IRANSansX` font is properly loaded and text styles are copied correctly.

4. **Component Styling**: Check that `FlexSubThemesData` matches your original component styling.

### Debug Tools

Add this to help debug theme issues:

```dart
// lib/shared/widgets/theme_debugger.dart
class ThemeDebugger extends StatelessWidget {
  const ThemeDebugger({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appTheme = theme.extension<AppThemeExtension>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brightness: ${theme.brightness}'),
            Text('Primary: ${colorScheme.primary}'),
            Text('AppTheme Extension: ${appTheme != null ? 'Present' : 'Missing'}'),
            // Add more debug info
          ],
        ),
      ),
    );
  }
}
```

## Next Step

Continue to [08_future_extensions.md](08_future_extensions.md) to learn how to add new themes and customize further.
