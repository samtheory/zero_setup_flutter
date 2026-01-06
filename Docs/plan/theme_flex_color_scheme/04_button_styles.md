# Step 4: Button Styles Migration

## Understanding Your Current Button System

Your current theme has extensive button customization with different variants:
- Primary buttons
- Secondary buttons  
- Error buttons
- Success buttons
- Outlined buttons
- Text buttons

FlexColorScheme provides excellent button theming with `FlexSubThemesData`.

## Migrate Button Styles

### 1. Create Button Theme Extension

```dart
// lib/core/theme/button_themes.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Custom button variants
enum ButtonVariant {
  primary,
  secondary,
  success,
  error,
  warning,
}

/// Custom button theme extension
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
      case ButtonVariant.primary:
        return primary;
      case ButtonVariant.secondary:
        return secondary;
      case ButtonVariant.success:
        return success;
      case ButtonVariant.error:
        return error;
      case ButtonVariant.warning:
        return warning;
    }
  }

  @override
  ThemeExtension<AppButtonTheme> copyWith({
    ButtonStyle? primary,
    ButtonStyle? secondary,
    ButtonStyle? success,
    ButtonStyle? error,
    ButtonStyle? warning,
  }) {
    return AppButtonTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
    );
  }

  @override
  ThemeExtension<AppButtonTheme> lerp(
    covariant ThemeExtension<AppButtonTheme>? other,
    double t,
  ) {
    if (other is! AppButtonTheme) {
      return this;
    }
    return AppButtonTheme(
      primary: ButtonStyle.lerp(primary, other.primary, t)!,
      secondary: ButtonStyle.lerp(secondary, other.secondary, t)!,
      success: ButtonStyle.lerp(success, other.success, t)!,
      error: ButtonStyle.lerp(error, other.error, t)!,
      warning: ButtonStyle.lerp(warning, other.warning, t)!,
    );
  }
}
```

### 2. Create Button Styles

```dart
/// Create button styles based on your current theme
AppButtonTheme createButtonTheme(ColorScheme colorScheme) {
  return AppButtonTheme(
    primary: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: 2,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'IRANSansX',
      ),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onPrimary.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.onPrimary.withOpacity(0.08);
        }
        return null;
      }),
    ),

    secondary: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.secondaryContainer,
      foregroundColor: colorScheme.onSecondaryContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.outline),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'IRANSansX',
      ),
    ),

    success: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF10B981), // Your green color
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'IRANSansX',
      ),
    ),

    error: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.error,
      foregroundColor: colorScheme.onError,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'IRANSansX',
      ),
    ),

    warning: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFD700), // Your sunrise yellow
      foregroundColor: Colors.black87,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'IRANSansX',
      ),
    ),
  );
}
```

### 3. Update Theme Provider with FlexSubThemes

```dart
// lib/core/theme/theme_provider.dart
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'button_themes.dart';

/// Theme data provider
final themeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themeMode = ref.watch(themeModeProvider);

  // Create button theme
  final colorScheme = CustomFlexScheme.redScheme.light.toColorScheme(Brightness.light);
  final buttonTheme = createButtonTheme(colorScheme);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    // Use FlexSubThemes for enhanced component theming
    subThemesData: const FlexSubThemesData(
      // Enhanced button theming
      elevatedButtonSchemeColor: SchemeColor.primary,
      elevatedButtonSecondarySchemeColor: SchemeColor.secondary,

      // Outlined buttons
      outlinedButtonSchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.outline,

      // Text buttons
      textButtonSchemeColor: SchemeColor.primary,

      // Input decoration
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorRadius: 8.0,

      // Switches
      switchSchemeColor: SchemeColor.primary,

      // Checkboxes
      checkboxSchemeColor: SchemeColor.primary,

      // Chips
      chipSchemeColor: SchemeColor.primary,

      // Cards
      cardRadius: 12.0,

      // Dialogs
      dialogRadius: 12.0,

      // Bottom sheets
      bottomSheetRadius: 12.0,
    ),
    extensions: [
      _createLightExtension(),
      buttonTheme,
    ],
  );
});
```

### 4. Create Custom Button Widget

```dart
// lib/shared/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:zero_setup_flutter/core/theme/button_themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.buttonType = ButtonType.elevated,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final style = buttonTheme.getVariant(variant);

    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: _outlinedStyle(style, Theme.of(context).colorScheme),
          child: child,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          style: _textStyle(style, Theme.of(context).colorScheme),
          child: child,
        );
    }
  }

  ButtonStyle _outlinedStyle(ButtonStyle baseStyle, ColorScheme colorScheme) {
    return baseStyle.copyWith(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(colorScheme.primary),
      side: WidgetStateProperty.all(
        BorderSide(color: colorScheme.outline),
      ),
    );
  }

  ButtonStyle _textStyle(ButtonStyle baseStyle, ColorScheme colorScheme) {
    return baseStyle.copyWith(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(colorScheme.primary),
      shadowColor: WidgetStateProperty.all(Colors.transparent),
      elevation: WidgetStateProperty.all(0),
    );
  }
}

enum ButtonType {
  elevated,
  outlined,
  text,
}
```

## Usage Examples

```dart
// Usage in widgets
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primary button
        CustomButton(
          variant: ButtonVariant.primary,
          onPressed: () {},
          child: const Text('Primary Action'),
        ),

        // Success button
        CustomButton(
          variant: ButtonVariant.success,
          onPressed: () {},
          child: const Text('Success Action'),
        ),

        // Error outlined button
        CustomButton(
          variant: ButtonVariant.error,
          buttonType: ButtonType.outlined,
          onPressed: () {},
          child: const Text('Delete'),
        ),

        // Secondary text button
        CustomButton(
          variant: ButtonVariant.secondary,
          buttonType: ButtonType.text,
          onPressed: () {},
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
```

## Next Step

Continue to [05_component_theming.md](05_component_theming.md) to migrate switches, checkboxes, appbar, and other component styles.
