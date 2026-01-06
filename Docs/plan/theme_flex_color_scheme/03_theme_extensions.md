# Step 3: Theme Extensions

## Why Theme Extensions?

Your current system uses `OnAppTheme` extension to add custom properties to `ThemeData`. FlexColorScheme supports this pattern perfectly - you can keep your extensions while using FlexColorScheme for the core theme building.

## Create Theme Extensions

### 1. Color Palette Extension

```dart
// lib/core/theme/theme_extensions.dart
import 'package:flutter/material.dart';

/// Custom color palette extension
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
  ThemeExtension<AppColorPalette> copyWith({
    MaterialColor? primary,
    MaterialColor? secondary,
    MaterialColor? text,
    MaterialColor? sunriseYellow,
    MaterialColor? green,
    MaterialColor? base,
  }) {
    return AppColorPalette(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      text: text ?? this.text,
      sunriseYellow: sunriseYellow ?? this.sunriseYellow,
      green: green ?? this.green,
      base: base ?? this.base,
    );
  }

  @override
  ThemeExtension<AppColorPalette> lerp(
    covariant ThemeExtension<AppColorPalette>? other,
    double t,
  ) {
    if (other is! AppColorPalette) {
      return this;
    }
    return AppColorPalette(
      primary: _lerpMaterialColor(primary, other.primary, t),
      secondary: _lerpMaterialColor(secondary, other.secondary, t),
      text: _lerpMaterialColor(text, other.text, t),
      sunriseYellow: _lerpMaterialColor(sunriseYellow, other.sunriseYellow, t),
      green: _lerpMaterialColor(green, other.green, t),
      base: _lerpMaterialColor(base, other.base, t),
    );
  }

  MaterialColor _lerpMaterialColor(MaterialColor a, MaterialColor b, double t) {
    return MaterialColor(
      Color.lerp(a, b, t)!.value,
      <int, Color>{
        50: Color.lerp(a[50], b[50], t)!,
        100: Color.lerp(a[100], b[100], t)!,
        200: Color.lerp(a[200], b[200], t)!,
        300: Color.lerp(a[300], b[300], t)!,
        400: Color.lerp(a[400], b[400], t)!,
        500: Color.lerp(a[500], b[500], t)!,
        600: Color.lerp(a[600], b[600], t)!,
        700: Color.lerp(a[700], b[700], t)!,
        800: Color.lerp(a[800], b[800], t)!,
        900: Color.lerp(a[900], b[900], t)!,
      },
    );
  }
}
```

### 2. Typography Extension

```dart
/// Custom typography extension
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return AppTypography(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}
```

### 3. Shadows and Gradients Extension

```dart
/// Custom shadows and gradients extension
class AppDecorations extends ThemeExtension<AppDecorations> {
  const AppDecorations({
    required this.shadows,
    required this.gradients,
  });

  final AppShadows shadows;
  final AppGradients gradients;

  @override
  ThemeExtension<AppDecorations> copyWith({
    AppShadows? shadows,
    AppGradients? gradients,
  }) {
    return AppDecorations(
      shadows: shadows ?? this.shadows,
      gradients: gradients ?? this.gradients,
    );
  }

  @override
  ThemeExtension<AppDecorations> lerp(
    covariant ThemeExtension<AppDecorations>? other,
    double t,
  ) {
    if (other is! AppDecorations) {
      return this;
    }
    return AppDecorations(
      shadows: shadows.lerp(other.shadows, t),
      gradients: gradients.lerp(other.gradients, t),
    );
  }
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

  AppShadows lerp(AppShadows other, double t) {
    return AppShadows(
      small: _lerpBoxShadows(small, other.small, t),
      medium: _lerpBoxShadows(medium, other.medium, t),
      large: _lerpBoxShadows(large, other.large, t),
      extraLarge: _lerpBoxShadows(extraLarge, other.extraLarge, t),
    );
  }

  List<BoxShadow> _lerpBoxShadows(List<BoxShadow> a, List<BoxShadow> b, double t) {
    if (a.length != b.length) return a;
    return List.generate(a.length, (i) => BoxShadow.lerp(a[i], b[i], t)!);
  }
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

  AppGradients lerp(AppGradients other, double t) {
    return AppGradients(
      primary: LinearGradient.lerp(primary, other.primary, t)!,
      secondary: LinearGradient.lerp(secondary, other.secondary, t)!,
      success: LinearGradient.lerp(success, other.success, t)!,
      error: LinearGradient.lerp(error, other.error, t)!,
      warning: LinearGradient.lerp(warning, other.warning, t)!,
    );
  }
}
```

### 4. Combined Extension

```dart
/// Combined theme extension
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
  ThemeExtension<AppThemeExtension> copyWith({
    AppColorPalette? colors,
    AppTypography? typography,
    AppDecorations? decorations,
  }) {
    return AppThemeExtension(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      decorations: decorations ?? this.decorations,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      colors: colors.lerp(other.colors, t) as AppColorPalette,
      typography: typography.lerp(other.typography, t) as AppTypography,
      decorations: decorations.lerp(other.decorations, t) as AppDecorations,
    );
  }
}
```

## Update Theme Provider

```dart
// lib/core/theme/theme_provider.dart
import 'theme_extensions.dart';

/// Create extension instances
AppThemeExtension _createLightExtension() {
  return const AppThemeExtension(
    colors: AppColorPalette(
      primary: Colors.red, // Your PalletColor.primary
      secondary: Colors.blue, // Your PalletColor.secondary
      text: Colors.grey, // Your PalletColor.text
      sunriseYellow: MaterialColor(0xFFFFD700, {/* your shades */}),
      green: MaterialColor(0xFF10B981, {/* your shades */}),
      base: MaterialColor(0xFF6B7280, {/* your shades */}),
    ),
    typography: AppTypography(
      displayLarge: TextStyle(/* your IRANSansX styles */),
      // ... other text styles
    ),
    decorations: AppDecorations(
      shadows: AppShadows(
        small: [BoxShadow(/* your shadows */)],
        // ... other shadows
      ),
      gradients: AppGradients(
        primary: LinearGradient(/* your gradients */),
        // ... other gradients
      ),
    ),
  );
}

/// Theme data provider
final themeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themeMode = ref.watch(themeModeProvider);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    extensions: [_createLightExtension()],
  );
});
```

## Usage in Widgets

```dart
// Usage in any widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        gradient: appTheme.decorations.gradients.primary,
        boxShadow: appTheme.decorations.shadows.medium,
      ),
      child: Text(
        'Hello',
        style: appTheme.typography.headlineMedium,
      ),
    );
  }
}
```

## Next Step

Continue to [04_button_styles.md](04_button_styles.md) to migrate your custom button styles (primary, secondary, error, success).
