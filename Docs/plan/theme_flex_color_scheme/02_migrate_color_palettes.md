# Step 2: Migrate Color Palettes

## Understanding Your Current Color System

Your `PalletColor` class creates MaterialColor with custom shades:
- 99, 95, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0

FlexColorScheme uses a different approach with `ColorScheme` and predefined shade patterns.

## Convert PalletColor to FlexColorScheme Colors

### 1. Extract Your Colors

From your `app_theme.dart`, extract these color definitions:

```dart
// lib/core/theme/colors.dart
import 'package:flutter/material.dart';

/// Primary Color Palette (Red)
const Color primaryColor = Color(0xFFDC2626); // Your red color
const Color primaryVariant = Color(0xFFB91C1C); // Darker red

/// Secondary Color Palette (Blue)
const Color secondaryColor = Color(0xFF2563EB); // Your blue color
const Color secondaryVariant = Color(0xFF1D4ED8); // Darker blue

/// Tertiary Colors (Your custom colors)
const Color sunriseYellow = Color(0xFFFFD700);
const Color green = Color(0xFF10B981);
const Color base = Color(0xFF6B7280);

/// Text Colors
const Color textPrimary = Color(0xFF111827);
const Color textSecondary = Color(0xFF6B7280);
const Color textTertiary = Color(0xFF9CA3AF);
```

### 2. Create Custom FlexScheme

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
      primary: Color(0xFFDC2626),      // primaryColor
      primaryContainer: Color(0xFFFEE2E2), // Light red background
      secondary: Color(0xFF2563EB),    // secondaryColor
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

### 3. Update Theme Provider

```dart
// lib/core/theme/theme_provider.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'custom_flex_scheme.dart';

/// Theme data provider
final themeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themeMode = ref.watch(themeModeProvider);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    // We'll add more configuration in next steps
  );
});

/// Dark theme provider
final darkThemeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  return FlexThemeData.dark(
    colors: CustomFlexScheme.redScheme.dark,
    useMaterial3: true,
    // We'll add more configuration in next steps
  );
});
```

### 4. Update main.dart

```dart
// lib/main.dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(themeDataProvider(context));
    final darkTheme = ref.watch(darkThemeDataProvider(context));

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const App(),
    );
  }
}
```

## Color Mapping Strategy

### Your PalletColor Shades → FlexColorScheme

| Your Shade | FlexColorScheme Equivalent | Usage |
|------------|---------------------------|-------|
| 99 | primaryContainer (light) | Light backgrounds |
| 95 | primary (lighter) | Light primary |
| 50 | primary | Main primary color |
| 30 | primaryContainer (dark) | Dark backgrounds |
| 10 | onPrimary | Text on primary |

### Preserving Custom Shades

If you need exact shade control, create custom extensions:

```dart
// lib/core/theme/color_extensions.dart
extension CustomColorScheme on ColorScheme {
  /// Custom primary shades from your PalletColor
  Color get primary99 => const Color(0xFFFFEBEE);
  Color get primary95 => const Color(0xFFFCE4EC);
  Color get primary90 => const Color(0xFFF8BBD9);
  Color get primary80 => const Color(0xFFF48FB1);
  Color get primary70 => const Color(0xFFF06292);
  Color get primary60 => const Color(0xFFEC407A);
  Color get primary50 => primary; // Main primary
  Color get primary40 => const Color(0xFFE91E63);
  Color get primary30 => const Color(0xFFD81B60);
  Color get primary20 => const Color(0xFFC2185B);
  Color get primary10 => const Color(0xFFAD1457);
  Color get primary0 => const Color(0xFF880E4F);
}
```

## Testing Colors

Create a test page to verify your colors:

```dart
// lib/features/theme_test/theme_test_page.dart
class ThemeTestPage extends StatelessWidget {
  const ThemeTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Color Test')),
      body: ListView(
        children: [
          _ColorSwatch('Primary', colorScheme.primary),
          _ColorSwatch('Primary Container', colorScheme.primaryContainer),
          _ColorSwatch('Secondary', colorScheme.secondary),
          _ColorSwatch('Tertiary', colorScheme.tertiary),
          // Add more color tests
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
```

## Next Step

Continue to [03_theme_extensions.md](03_theme_extensions.md) to add your custom theme extensions for typography, shadows, and gradients.
