import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'nova_colors.dart';
import 'nova_gradients.dart';
import 'nova_shadows.dart';
import 'nova_typography.dart';

/// NOVA Light Theme
final ThemeData novaLightTheme = FlexThemeData.light(
  scheme: FlexScheme.blue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    // Button styles
    elevatedButtonRadius: 12,
    outlinedButtonRadius: 12,
    textButtonRadius: 12,
    filledButtonRadius: 12,
    // Input styles
    inputDecoratorRadius: 12,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    // Card styles
    cardRadius: 16,
    // Dialog styles
    dialogRadius: 20,
    // Bottom sheet styles
    bottomSheetRadius: 20,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: 'IRANSansX',
).copyWith(
  extensions: <ThemeExtension<dynamic>>[
    NovaColors.light,
    NovaTypography.standard,
    NovaShadows.light,
    NovaGradients.light,
  ],
);

/// NOVA Dark Theme
final ThemeData novaDarkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
    // Button styles
    elevatedButtonRadius: 12,
    outlinedButtonRadius: 12,
    textButtonRadius: 12,
    filledButtonRadius: 12,
    // Input styles
    inputDecoratorRadius: 12,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    // Card styles
    cardRadius: 16,
    // Dialog styles
    dialogRadius: 20,
    // Bottom sheet styles
    bottomSheetRadius: 20,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: 'IRANSansX',
).copyWith(
  extensions: <ThemeExtension<dynamic>>[
    NovaColors.dark,
    NovaTypography.standard,
    NovaShadows.dark,
    NovaGradients.dark,
  ],
);
