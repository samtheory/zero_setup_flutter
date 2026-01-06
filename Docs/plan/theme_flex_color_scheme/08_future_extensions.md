# Step 8: Future Extensions & Customization

## Adding New Color Schemes

### 1. Create Additional FlexSchemes

```dart
// lib/core/theme/custom_flex_scheme.dart
class CustomFlexScheme {
  // Existing red scheme...

  /// Blue color scheme
  static const FlexSchemeData blueScheme = FlexSchemeData(
    name: 'Blue Scheme',
    description: 'Blue color scheme for alternative theme',
    light: FlexSchemeColor(
      primary: Color(0xFF1565C0),      // Blue primary
      primaryContainer: Color(0xFFE3F2FD), // Light blue background
      secondary: Color(0xFFDC2626),    // Your red as secondary
      secondaryContainer: Color(0xFFFEE2E2), // Light red background
      tertiary: Color(0xFFFFD700),     // Keep sunrise yellow
      tertiaryContainer: Color(0xFFFFF9C4), // Light yellow background
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFFEE2E2),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFF42A5F5),      // Lighter blue for dark mode
      primaryContainer: Color(0xFF0D47A1), // Dark blue background
      secondary: Color(0xFFF87171),    // Lighter red for dark mode
      secondaryContainer: Color(0xFF7F1D1D), // Dark red background
      tertiary: Color(0xFFFCD34D),     // Lighter yellow for dark mode
      tertiaryContainer: Color(0xFF92400E), // Dark yellow background
      error: Color(0xFFF87171),
      errorContainer: Color(0xFF7F1D1D),
    ),
  );

  /// Green color scheme
  static const FlexSchemeData greenScheme = FlexSchemeData(
    name: 'Green Scheme',
    description: 'Green color scheme for nature theme',
    light: FlexSchemeColor(
      primary: Color(0xFF2E7D32),      // Green primary
      primaryContainer: Color(0xFFE8F5E8), // Light green background
      secondary: Color(0xFFDC2626),    // Keep red as secondary
      secondaryContainer: Color(0xFFFEE2E2), // Light red background
      tertiary: Color(0xFFFFD700),     // Keep sunrise yellow
      tertiaryContainer: Color(0xFFFFF9C4), // Light yellow background
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFFEE2E2),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFF4CAF50),      // Lighter green for dark mode
      primaryContainer: Color(0xFF1B5E20), // Dark green background
      secondary: Color(0xFFF87171),    // Lighter red for dark mode
      secondaryContainer: Color(0xFF7F1D1D), // Dark red background
      tertiary: Color(0xFFFCD34D),     // Lighter yellow for dark mode
      tertiaryContainer: Color(0xFF92400E), // Dark yellow background
      error: Color(0xFFF87171),
      errorContainer: Color(0xFF7F1D1D),
    ),
  );
}
```

### 2. Add Theme Selection

```dart
// lib/core/theme/theme_provider.dart
enum AppThemeScheme {
  red,
  blue,
  green;

  String get displayName {
    switch (this) {
      case AppThemeScheme.red:
        return 'قرمز'; // Persian for Red
      case AppThemeScheme.blue:
        return 'آبی'; // Persian for Blue
      case AppThemeScheme.green:
        return 'سبز'; // Persian for Green
    }
  }

  FlexSchemeData get schemeData {
    switch (this) {
      case AppThemeScheme.red:
        return CustomFlexScheme.redScheme;
      case AppThemeScheme.blue:
        return CustomFlexScheme.blueScheme;
      case AppThemeScheme.green:
        return CustomFlexScheme.greenScheme;
    }
  }
}

class ThemeSchemeNotifier extends StateNotifier<AppThemeScheme> {
  ThemeSchemeNotifier() : super(AppThemeScheme.red) {
    _loadThemeScheme();
  }

  Future<void> _loadThemeScheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedScheme = prefs.getString('app_theme_scheme');
    if (savedScheme != null) {
      state = AppThemeScheme.values.firstWhere(
        (scheme) => scheme.name == savedScheme,
        orElse: () => AppThemeScheme.red,
      );
    }
  }

  Future<void> setScheme(AppThemeScheme scheme) async {
    state = scheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme_scheme', scheme.name);
  }
}

final themeSchemeProvider = StateNotifierProvider<ThemeSchemeNotifier, AppThemeScheme>((ref) {
  return ThemeSchemeNotifier();
});
```

### 3. Update Theme Providers

```dart
final lightThemeDataProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(themeSchemeProvider);
  final colorScheme = scheme.schemeData.light.toColorScheme(Brightness.light);
  final buttonTheme = createButtonTheme(colorScheme);

  return FlexThemeData.light(
    colors: scheme.schemeData.light,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      // ... existing sub themes
    ),
    extensions: [
      _createLightExtension(scheme),
      buttonTheme,
    ],
  );
});

AppThemeExtension _createLightExtension(AppThemeScheme scheme) {
  // Adjust extensions based on scheme
  return AppThemeExtension(
    colors: AppColorPalette(
      primary: _getPrimaryColorForScheme(scheme),
      // ... adjust other colors based on scheme
    ),
    // ... other extensions
  );
}

MaterialColor _getPrimaryColorForScheme(AppThemeScheme scheme) {
  switch (scheme) {
    case AppThemeScheme.red:
      return const MaterialColor(0xFFDC2626, {/* red shades */});
    case AppThemeScheme.blue:
      return const MaterialColor(0xFF1565C0, {/* blue shades */});
    case AppThemeScheme.green:
      return const MaterialColor(0xFF2E7D32, {/* green shades */});
  }
}
```

## Advanced Component Customization

### 1. Custom Component Themes

```dart
// lib/core/theme/advanced_components.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';

/// Advanced component configuration
class AdvancedComponentConfig {
  final FlexSubThemesData lightConfig;
  final FlexSubThemesData darkConfig;

  const AdvancedComponentConfig({
    required this.lightConfig,
    required this.darkConfig,
  });
}

AdvancedComponentConfig createAdvancedConfig() {
  return const AdvancedComponentConfig(
    lightConfig: FlexSubThemesData(
      // Light mode specific configurations
      appBarBackgroundSchemeColor: SchemeColor.primary,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surface,

      // Custom border radius for light mode
      elevatedButtonRadius: 12.0,
      outlinedButtonRadius: 12.0,
      textButtonRadius: 8.0,

      // Light mode specific elevations
      appBarElevation: 2.0,
      bottomNavigationBarElevation: 4.0,
    ),
    darkConfig: FlexSubThemesData(
      // Dark mode specific configurations
      appBarBackgroundSchemeColor: SchemeColor.surface,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surface,

      // Different border radius for dark mode
      elevatedButtonRadius: 8.0,
      outlinedButtonRadius: 8.0,
      textButtonRadius: 6.0,

      // Dark mode specific elevations
      appBarElevation: 1.0,
      bottomNavigationBarElevation: 2.0,
    ),
  );
}
```

### 2. Dynamic Theme Adjustments

```dart
// lib/core/theme/dynamic_theme.dart
import 'package:flutter/material.dart';

/// Dynamic theme adjustments based on user preferences
class DynamicTheme {
  final bool highContrast;
  final bool largeText;
  final double borderRadius;

  const DynamicTheme({
    this.highContrast = false,
    this.largeText = false,
    this.borderRadius = 8.0,
  });

  ThemeData applyTo(ThemeData theme) {
    return theme.copyWith(
      // Apply dynamic adjustments
      textTheme: largeText ? _largeTextTheme(theme.textTheme) : theme.textTheme,
      // Add high contrast adjustments
      colorScheme: highContrast ? _highContrastScheme(theme.colorScheme) : theme.colorScheme,
    );
  }

  TextTheme _largeTextTheme(TextTheme base) {
    return base.apply(
      fontSizeFactor: 1.2,
      fontSizeDelta: 2.0,
    );
  }

  ColorScheme _highContrastScheme(ColorScheme base) {
    return base.copyWith(
      primary: base.primary.withOpacity(1.0),
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      // Add more high contrast adjustments
    );
  }
}
```

## Custom Font Integration

### 1. Advanced Typography

```dart
// lib/core/theme/advanced_typography.dart
import 'package:flutter/material.dart';

class AdvancedTypography {
  static TextTheme createTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        fontFamily: 'IRANSansX',
        color: colorScheme.onSurface,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        fontFamily: 'IRANSansX',
        color: colorScheme.onSurface,
        height: 1.16,
        letterSpacing: 0,
      ),
      // ... continue with all text styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'IRANSansX',
        color: colorScheme.onSurface,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'IRANSansX',
        color: colorScheme.onSurfaceVariant,
        height: 1.43,
        letterSpacing: 0.25,
      ),
      // ... continue with all text styles
    );
  }

  static TextTheme createDisplayTextTheme(ColorScheme colorScheme) {
    // Special text theme for marketing/display text
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'IRANSansX',
        color: colorScheme.primary,
        height: 1.25,
        letterSpacing: -0.5,
      ),
      // ... custom display styles
    );
  }
}
```

## Accessibility Features

### 1. Accessible Theme Variants

```dart
// lib/core/theme/accessibility.dart
import 'package:flutter/material.dart';

class AccessibilityTheme {
  static ThemeData highContrastTheme(ThemeData base) {
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        background: Colors.white,
        onBackground: Colors.black,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }

  static ThemeData largeTextTheme(ThemeData base) {
    return base.copyWith(
      textTheme: base.textTheme.apply(
        fontSizeFactor: 1.3,
        fontSizeDelta: 4.0,
      ),
    );
  }

  static ThemeData colorBlindFriendlyTheme(ThemeData base) {
    // Adjust colors for better color blind accessibility
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF007ACC), // Better blue
        secondary: const Color(0xFFE91E63), // Better magenta
        tertiary: const Color(0xFF4CAF50), // Keep green
      ),
    );
  }
}
```

## Performance Optimization

### 1. Theme Caching

```dart
// lib/core/theme/theme_cache.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Cache for expensive theme computations
class ThemeCache {
  static final Map<String, ThemeData> _cache = {};

  static ThemeData getOrCreate(String key, ThemeData Function() creator) {
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }
    final theme = creator();
    _cache[key] = theme;
    return theme;
  }

  static void clearCache() {
    _cache.clear();
  }

  static void invalidateKey(String key) {
    _cache.remove(key);
  }
}

/// Cached theme provider
final cachedLightThemeProvider = Provider<ThemeData>((ref) {
  final scheme = ref.watch(themeSchemeProvider);
  final mode = ref.watch(themeModeProvider);

  final cacheKey = 'light_${scheme.name}_${mode.name}';

  return ThemeCache.getOrCreate(cacheKey, () {
    // Expensive theme creation logic here
    final colorScheme = scheme.schemeData.light.toColorScheme(Brightness.light);
    final buttonTheme = createButtonTheme(colorScheme);

    return FlexThemeData.light(
      colors: scheme.schemeData.light,
      useMaterial3: true,
      subThemesData: const FlexSubThemesData(
        // ... theme configuration
      ),
      extensions: [
        _createLightExtension(scheme),
        buttonTheme,
      ],
    );
  });
});
```

## Testing Your Themes

### 1. Theme Test Suite

```dart
// lib/features/theme_test/theme_test_suite.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void testThemeCompatibility() {
  testWidgets('All themes load without errors', (tester) async {
    for (final scheme in AppThemeScheme.values) {
      for (final mode in AppThemeMode.values) {
        // Test theme creation
        final theme = createThemeForSchemeAndMode(scheme, mode);
        expect(theme, isNotNull);
        expect(theme.colorScheme.primary, isNotNull);
      }
    }
  });

  testWidgets('Extensions are properly attached', (tester) async {
    final theme = createLightTheme();
    expect(theme.extension<AppThemeExtension>(), isNotNull);
    expect(theme.extension<AppButtonTheme>(), isNotNull);
  });

  testWidgets('Typography scales correctly', (tester) async {
    final normalTheme = createLightTheme();
    final largeTextTheme = AccessibilityTheme.largeTextTheme(normalTheme);

    expect(
      largeTextTheme.textTheme.bodyLarge!.fontSize!,
      greaterThan(normalTheme.textTheme.bodyLarge!.fontSize!),
    );
  });
}
```

## Documentation Maintenance

### 1. Theme Documentation Generator

```dart
// lib/core/theme/theme_documentation.dart
import 'dart:convert';
import 'package:flutter/material.dart';

class ThemeDocumentation {
  static String generateThemeReport(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appTheme = theme.extension<AppThemeExtension>();

    final report = {
      'brightness': theme.brightness.toString(),
      'colorScheme': {
        'primary': colorScheme.primary.toString(),
        'secondary': colorScheme.secondary.toString(),
        'surface': colorScheme.surface.toString(),
        // ... other colors
      },
      'extensions': {
        'hasAppThemeExtension': appTheme != null,
        'hasButtonTheme': theme.extension<AppButtonTheme>() != null,
        // ... other extensions
      },
      'typography': {
        'fontFamily': theme.textTheme.bodyLarge?.fontFamily,
        'bodyLargeSize': theme.textTheme.bodyLarge?.fontSize,
        // ... other typography info
      },
    };

    return JsonEncoder.withIndent('  ').convert(report);
  }
}
```

## Migration Complete! 🎉

You now have a powerful, flexible theme system built on FlexColorScheme that:

- ✅ Maintains all your custom color palettes and extensions
- ✅ Provides automatic dark mode generation
- ✅ Supports multiple color schemes
- ✅ Includes comprehensive component theming
- ✅ Has Riverpod integration for state management
- ✅ Is easily extensible for future customization
- ✅ Includes accessibility features
- ✅ Has performance optimizations
- ✅ Is well-documented and testable

Your theme system is now future-proof and can easily accommodate new design requirements while maintaining backward compatibility with your existing UI components.
