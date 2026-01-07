# NOVA Implementation: Part 2 - Theme, Typography, Shadows, Gradients

## File: `lib/core/theme/nova_typography.dart`

```dart
import 'package:flutter/material.dart';

/// NOVA Typography - All text styles
class NovaTypography extends ThemeExtension<NovaTypography> {
  const NovaTypography({
    required this.displayLg,
    required this.displayMd,
    required this.displaySm,
    required this.headingLg,
    required this.headingMd,
    required this.headingSm,
    required this.titleLg,
    required this.titleMd,
    required this.titleSm,
    required this.bodyLg,
    required this.bodyMd,
    required this.bodySm,
    required this.labelLg,
    required this.labelMd,
    required this.labelSm,
    required this.caption,
  });

  final TextStyle displayLg;
  final TextStyle displayMd;
  final TextStyle displaySm;
  final TextStyle headingLg;
  final TextStyle headingMd;
  final TextStyle headingSm;
  final TextStyle titleLg;
  final TextStyle titleMd;
  final TextStyle titleSm;
  final TextStyle bodyLg;
  final TextStyle bodyMd;
  final TextStyle bodySm;
  final TextStyle labelLg;
  final TextStyle labelMd;
  final TextStyle labelSm;
  final TextStyle caption;

  // ═══════════════════════════════════════════════════════════════════════════
  // DEFAULT TYPOGRAPHY (IRANSansX for Persian support)
  // ═══════════════════════════════════════════════════════════════════════════

  static const String _fontFamily = 'IRANSansX';

  static NovaTypography get standard => NovaTypography(
    displayLg: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w700,
      height: 1.12,
      letterSpacing: -0.25,
    ),
    displayMd: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w600,
      height: 1.16,
      letterSpacing: 0,
    ),
    displaySm: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w500,
      height: 1.22,
      letterSpacing: 0,
    ),
    headingLg: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.25,
      letterSpacing: 0,
    ),
    headingMd: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.29,
      letterSpacing: 0,
    ),
    headingSm: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.33,
      letterSpacing: 0,
    ),
    titleLg: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 1.27,
      letterSpacing: 0,
    ),
    titleMd: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      letterSpacing: 0.15,
    ),
    titleSm: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
    ),
    bodyLg: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.5,
    ),
    bodyMd: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.25,
    ),
    bodySm: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: 0.4,
    ),
    labelLg: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.43,
      letterSpacing: 0.1,
    ),
    labelMd: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.33,
      letterSpacing: 0.5,
    ),
    labelSm: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.45,
      letterSpacing: 0.5,
    ),
    caption: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.4,
      letterSpacing: 0.4,
    ),
  );

  @override
  NovaTypography copyWith({/* all params */}) {
    return NovaTypography(
      displayLg: displayLg,
      displayMd: displayMd,
      displaySm: displaySm,
      headingLg: headingLg,
      headingMd: headingMd,
      headingSm: headingSm,
      titleLg: titleLg,
      titleMd: titleMd,
      titleSm: titleSm,
      bodyLg: bodyLg,
      bodyMd: bodyMd,
      bodySm: bodySm,
      labelLg: labelLg,
      labelMd: labelMd,
      labelSm: labelSm,
      caption: caption,
    );
  }

  @override
  NovaTypography lerp(ThemeExtension<NovaTypography>? other, double t) {
    if (other is! NovaTypography) return this;
    return NovaTypography(
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
      displaySm: TextStyle.lerp(displaySm, other.displaySm, t)!,
      headingLg: TextStyle.lerp(headingLg, other.headingLg, t)!,
      headingMd: TextStyle.lerp(headingMd, other.headingMd, t)!,
      headingSm: TextStyle.lerp(headingSm, other.headingSm, t)!,
      titleLg: TextStyle.lerp(titleLg, other.titleLg, t)!,
      titleMd: TextStyle.lerp(titleMd, other.titleMd, t)!,
      titleSm: TextStyle.lerp(titleSm, other.titleSm, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      labelLg: TextStyle.lerp(labelLg, other.labelLg, t)!,
      labelMd: TextStyle.lerp(labelMd, other.labelMd, t)!,
      labelSm: TextStyle.lerp(labelSm, other.labelSm, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }
}
```

---

## File: `lib/core/theme/nova_shadows.dart`

```dart
import 'package:flutter/material.dart';

/// NOVA Shadows - Elevation presets
class NovaShadows extends ThemeExtension<NovaShadows> {
  const NovaShadows({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  final List<BoxShadow> none;
  final List<BoxShadow> xs;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;
  final List<BoxShadow> xxl;

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT MODE SHADOWS
  // ═══════════════════════════════════════════════════════════════════════════

  static const light = NovaShadows(
    none: [],
    xs: [
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    sm: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 3,
        offset: Offset(0, 1),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    md: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    lg: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 15,
        offset: Offset(0, 10),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
    xl: [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 25,
        offset: Offset(0, 20),
      ),
      BoxShadow(
        color: Color(0x0D000000),
        blurRadius: 10,
        offset: Offset(0, 8),
      ),
    ],
    xxl: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 50,
        offset: Offset(0, 25),
      ),
    ],
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK MODE SHADOWS (subtle glow effect)
  // ═══════════════════════════════════════════════════════════════════════════

  static const dark = NovaShadows(
    none: [],
    xs: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    sm: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
    md: [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
    lg: [
      BoxShadow(
        color: Color(0x59000000),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
    xl: [
      BoxShadow(
        color: Color(0x66000000),
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
    xxl: [
      BoxShadow(
        color: Color(0x80000000),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  @override
  NovaShadows copyWith({/* params */}) => this;

  @override
  NovaShadows lerp(ThemeExtension<NovaShadows>? other, double t) {
    if (other is! NovaShadows) return this;
    return t < 0.5 ? this : other;
  }
}
```

---

## File: `lib/core/theme/nova_gradients.dart`

```dart
import 'package:flutter/material.dart';

/// NOVA Gradients - Gradient presets
class NovaGradients extends ThemeExtension<NovaGradients> {
  const NovaGradients({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.error,
    required this.warning,
    required this.ocean,
    required this.sunset,
    required this.purple,
    required this.dark,
  });

  final LinearGradient primary;
  final LinearGradient secondary;
  final LinearGradient success;
  final LinearGradient error;
  final LinearGradient warning;
  final LinearGradient ocean;
  final LinearGradient sunset;
  final LinearGradient purple;
  final LinearGradient dark;

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT MODE GRADIENTS
  // ═══════════════════════════════════════════════════════════════════════════

  static const light = NovaGradients(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    ),
    secondary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    ),
    success: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
    ),
    error: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    ),
    warning: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFACC15), Color(0xFFEAB308)],
    ),
    ocean: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    ),
    sunset: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF97316), Color(0xFFEF4444), Color(0xFFEC4899)],
    ),
    purple: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFA855F7), Color(0xFF6366F1)],
    ),
    dark: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF374151), Color(0xFF1F2937)],
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK MODE GRADIENTS (slightly adjusted)
  // ═══════════════════════════════════════════════════════════════════════════

  static const dark = NovaGradients(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
    ),
    secondary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
    ),
    success: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF4ADE80), Color(0xFF22C55E)],
    ),
    error: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF87171), Color(0xFFEF4444)],
    ),
    warning: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFDE047), Color(0xFFFACC15)],
    ),
    ocean: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF22D3EE), Color(0xFF60A5FA)],
    ),
    sunset: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFB923C), Color(0xFFF87171), Color(0xFFF472B6)],
    ),
    purple: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFC084FC), Color(0xFF818CF8)],
    ),
    dark: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1F2937), Color(0xFF111827)],
    ),
  );

  @override
  NovaGradients copyWith({/* params */}) => this;

  @override
  NovaGradients lerp(ThemeExtension<NovaGradients>? other, double t) {
    if (other is! NovaGradients) return this;
    return NovaGradients(
      primary: LinearGradient.lerp(primary, other.primary, t)!,
      secondary: LinearGradient.lerp(secondary, other.secondary, t)!,
      success: LinearGradient.lerp(success, other.success, t)!,
      error: LinearGradient.lerp(error, other.error, t)!,
      warning: LinearGradient.lerp(warning, other.warning, t)!,
      ocean: LinearGradient.lerp(ocean, other.ocean, t)!,
      sunset: LinearGradient.lerp(sunset, other.sunset, t)!,
      purple: LinearGradient.lerp(purple, other.purple, t)!,
      dark: LinearGradient.lerp(dark, other.dark, t)!,
    );
  }
}
```

---

## File: `lib/core/theme/nova_extensions.dart`

```dart
import 'package:flutter/material.dart';
import 'nova_colors.dart';
import 'nova_typography.dart';
import 'nova_shadows.dart';
import 'nova_gradients.dart';

/// NOVA Theme Extension - Easy access to all design tokens
class Nova {
  Nova._(this._context);

  final BuildContext _context;
  ThemeData get _theme => Theme.of(_context);

  /// Colors
  NovaColors get colors => _theme.extension<NovaColors>()!;

  /// Typography
  NovaTypography get text => _theme.extension<NovaTypography>()!;

  /// Shadows
  NovaShadows get shadows => _theme.extension<NovaShadows>()!;

  /// Gradients
  NovaGradients get gradients => _theme.extension<NovaGradients>()!;

  /// Is dark mode
  bool get isDark => _theme.brightness == Brightness.dark;

  /// Color scheme shortcut
  ColorScheme get colorScheme => _theme.colorScheme;
}

/// BuildContext extension for easy access
extension NovaExtension on BuildContext {
  /// Access NOVA design system
  Nova get nova => Nova._(this);
}
```

---

## File: `lib/core/theme/nova_theme.dart`

```dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nova_colors.dart';
import 'nova_typography.dart';
import 'nova_shadows.dart';
import 'nova_gradients.dart';

/// Theme mode state
enum NovaThemeMode { light, dark, system }

/// Theme mode notifier (Modern Riverpod Notifier)
class NovaThemeModeNotifier extends Notifier<NovaThemeMode> {
  @override
  NovaThemeMode build() => NovaThemeMode.system; // Initial state

  void setLight() => state = NovaThemeMode.light;
  void setDark() => state = NovaThemeMode.dark;
  void setSystem() => state = NovaThemeMode.system;
  void toggle() => state = state == NovaThemeMode.light
      ? NovaThemeMode.dark
      : NovaThemeMode.light;
}

/// Providers
final novaThemeModeProvider = NotifierProvider<NovaThemeModeNotifier, NovaThemeMode>(
  () => NovaThemeModeNotifier(),
);

final novaThemeModeValueProvider = Provider<ThemeMode>((ref) {
  final mode = ref.watch(novaThemeModeProvider);
  switch (mode) {
    case NovaThemeMode.light: return ThemeMode.light;
    case NovaThemeMode.dark: return ThemeMode.dark;
    case NovaThemeMode.system: return ThemeMode.system;
  }
});

/// Light theme
final novaLightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xFF3B82F6),      // Blue
    primaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFF06B6D4),    // Ocean
    secondaryContainer: Color(0xFFCFFAFE),
    tertiary: Color(0xFFA855F7),     // Purple
    tertiaryContainer: Color(0xFFF3E8FF),
    error: Color(0xFFEF4444),
    errorContainer: Color(0xFFFEE2E2),
  ),
  useMaterial3: true,
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    blendOnLevel: 10,
    elevatedButtonSchemeColor: SchemeColor.primary,
    outlinedButtonSchemeColor: SchemeColor.primary,
    textButtonSchemeColor: SchemeColor.primary,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorRadius: 12,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    chipSchemeColor: SchemeColor.primary,
    cardRadius: 16,
    dialogRadius: 20,
    bottomSheetRadius: 20,
    appBarCenterTitle: true,
  ),
  fontFamily: 'IRANSansX',
).copyWith(
  extensions: [
    NovaColors.light,
    NovaTypography.standard,
    NovaShadows.light,
    NovaGradients.light,
  ],
);

/// Dark theme
final novaDarkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xFF60A5FA),      // Blue (lighter)
    primaryContainer: Color(0xFF1E3A8A),
    secondary: Color(0xFF22D3EE),    // Ocean (lighter)
    secondaryContainer: Color(0xFF164E63),
    tertiary: Color(0xFFC084FC),     // Purple (lighter)
    tertiaryContainer: Color(0xFF581C87),
    error: Color(0xFFF87171),
    errorContainer: Color(0xFF7F1D1D),
  ),
  useMaterial3: true,
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    blendOnLevel: 15,
    elevatedButtonSchemeColor: SchemeColor.primary,
    outlinedButtonSchemeColor: SchemeColor.primary,
    textButtonSchemeColor: SchemeColor.primary,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorRadius: 12,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    chipSchemeColor: SchemeColor.primary,
    cardRadius: 16,
    dialogRadius: 20,
    bottomSheetRadius: 20,
    appBarCenterTitle: true,
  ),
  fontFamily: 'IRANSansX',
).copyWith(
  extensions: [
    NovaColors.dark,
    NovaTypography.standard,
    NovaShadows.dark,
    NovaGradients.dark,
  ],
);
```

---

## File: `lib/core/theme/nova.dart` (Barrel Export)

```dart
/// NOVA Design System
/// 
/// A clean, extensible design system for Flutter.
library nova;

export 'nova_colors.dart';
export 'nova_typography.dart';
export 'nova_shadows.dart';
export 'nova_gradients.dart';
export 'nova_extensions.dart';
export 'nova_theme.dart';
```

---

## Usage in `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/nova.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(novaThemeModeValueProvider);

    return MaterialApp(
      theme: novaLightTheme,
      darkTheme: novaDarkTheme,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
```
