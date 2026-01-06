# Step 5: Component Theming

## Understanding Your Current Component Styles

Your current theme has extensive component customization:
- Switches with custom colors and animations
- Checkboxes with custom styling
- AppBar with custom colors and elevation
- BottomNavigationBar with custom styling
- DatePicker with custom themes
- And more...

FlexColorScheme's `FlexSubThemesData` handles most of this automatically, but we'll customize it to match your current styles.

## Enhanced Component Theming

### 1. Update Theme Provider with Full Component Theming

```dart
// lib/core/theme/theme_provider.dart
final themeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final themeMode = ref.watch(themeModeProvider);

  // Create button theme
  final colorScheme = CustomFlexScheme.redScheme.light.toColorScheme(Brightness.light);
  final buttonTheme = createButtonTheme(colorScheme);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    // Enhanced component theming
    subThemesData: FlexSubThemesData(
      // Button theming
      elevatedButtonSchemeColor: SchemeColor.primary,
      elevatedButtonSecondarySchemeColor: SchemeColor.secondary,
      outlinedButtonSchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.outline,
      textButtonSchemeColor: SchemeColor.primary,

      // Input decoration (TextField)
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorRadius: 8.0,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorBorderWidth: 1.5,

      // Switches - matching your current switch theme
      switchSchemeColor: SchemeColor.primary,
      switchThumbSchemeColor: SchemeColor.primary,
      switchThumbFixedSize: const Size(24, 24),
      switchTrackOutlineWidth: 2.0,

      // Checkboxes - matching your current checkbox theme
      checkboxSchemeColor: SchemeColor.primary,
      checkboxBorderRadius: 4.0,

      // Radio buttons
      radioSchemeColor: SchemeColor.primary,

      // Chips
      chipSchemeColor: SchemeColor.primary,
      chipSelectedSchemeColor: SchemeColor.secondary,
      chipBorderRadius: 8.0,

      // Cards
      cardRadius: 12.0,
      cardElevation: 2.0,

      // AppBar - matching your current appbar theme
      appBarBackgroundSchemeColor: SchemeColor.primary,
      appBarForegroundSchemeColor: SchemeColor.onPrimary,
      appBarElevation: 2.0,
      appBarCenterTitle: true,

      // BottomNavigationBar - matching your current bottom nav
      bottomNavigationBarSchemeColor: SchemeColor.primary,
      bottomNavigationBarBackgroundSchemeColor: SchemeColor.surface,
      bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
      bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      bottomNavigationBarElevation: 4.0,

      // Dialogs
      dialogRadius: 12.0,
      dialogBackgroundSchemeColor: SchemeColor.surface,

      // Bottom sheets
      bottomSheetRadius: 12.0,
      bottomSheetBackgroundSchemeColor: SchemeColor.surface,

      // SnackBar
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      snackBarActionSchemeColor: SchemeColor.inversePrimary,

      // TabBar
      tabBarItemSchemeColor: SchemeColor.primary,
      tabBarIndicatorSchemeColor: SchemeColor.primary,

      // NavigationBar (Material 3)
      navigationBarSchemeColor: SchemeColor.primary,
      navigationBarBackgroundSchemeColor: SchemeColor.surface,
      navigationBarSelectedIconSchemeColor: SchemeColor.primary,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,

      // NavigationRail
      navigationRailSchemeColor: SchemeColor.primary,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,

      // DatePicker - matching your current date picker theme
      datePickerHeaderBackgroundSchemeColor: SchemeColor.primary,
      datePickerHeaderForegroundSchemeColor: SchemeColor.onPrimary,
      datePickerDialogRadius: 12.0,

      // TimePicker
      timePickerDialogRadius: 12.0,

      // PopupMenu
      popupMenuRadius: 8.0,
      popupMenuElevation: 4.0,

      // Tooltip
      tooltipRadius: 8.0,
      tooltipSchemeColor: SchemeColor.inverseSurface,

      // FAB
      fabSchemeColor: SchemeColor.secondary,
      fabUseShape: true,

      // ToggleButtons
      toggleButtonsSchemeColor: SchemeColor.primary,
      toggleButtonsBorderRadius: 8.0,

      // Sliders
      sliderSchemeColor: SchemeColor.primary,
      sliderThumbSchemeColor: SchemeColor.primary,

      // Progress indicators
      circularProgressSchemeColor: SchemeColor.primary,
      linearProgressSchemeColor: SchemeColor.primary,
    ),
    extensions: [
      _createLightExtension(),
      buttonTheme,
    ],
  );
});
```

### 2. Custom Component Extensions

For components that need more customization than FlexSubThemes provides:

```dart
// lib/core/theme/component_extensions.dart
import 'package:flutter/material.dart';

/// Custom switch theme extension
class AppSwitchTheme extends ThemeExtension<AppSwitchTheme> {
  const AppSwitchTheme({
    required this.primary,
    required this.secondary,
  });

  final SwitchThemeData primary;
  final SwitchThemeData secondary;

  @override
  ThemeExtension<AppSwitchTheme> copyWith({
    SwitchThemeData? primary,
    SwitchThemeData? secondary,
  }) {
    return AppSwitchTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  ThemeExtension<AppSwitchTheme> lerp(
    covariant ThemeExtension<AppSwitchTheme>? other,
    double t,
  ) {
    if (other is! AppSwitchTheme) {
      return this;
    }
    return AppSwitchTheme(
      primary: SwitchThemeData.lerp(primary, other.primary, t),
      secondary: SwitchThemeData.lerp(secondary, other.secondary, t),
    );
  }
}

/// Custom checkbox theme extension
class AppCheckboxTheme extends ThemeExtension<AppCheckboxTheme> {
  const AppCheckboxTheme({
    required this.primary,
    required this.secondary,
  });

  final CheckboxThemeData primary;
  final CheckboxThemeData secondary;

  @override
  ThemeExtension<AppCheckboxTheme> copyWith({
    CheckboxThemeData? primary,
    CheckboxThemeData? secondary,
  }) {
    return AppCheckboxTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  ThemeExtension<AppCheckboxTheme> lerp(
    covariant ThemeExtension<AppCheckboxTheme>? other,
    double t,
  ) {
    if (other is! AppCheckboxTheme) {
      return this;
    }
    return AppCheckboxTheme(
      primary: CheckboxThemeData.lerp(primary, other.primary, t),
      secondary: CheckboxThemeData.lerp(secondary, other.secondary, t),
    );
  }
}

/// Create custom component themes
AppSwitchTheme createSwitchTheme(ColorScheme colorScheme) {
  return AppSwitchTheme(
    primary: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withOpacity(0.3);
        }
        return colorScheme.surfaceVariant;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
    ),
    secondary: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.secondary;
        }
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.secondary.withOpacity(0.3);
        }
        return colorScheme.surfaceVariant;
      }),
    ),
  );
}

AppCheckboxTheme createCheckboxTheme(ColorScheme colorScheme) {
  return AppCheckboxTheme(
    primary: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      side: BorderSide(color: colorScheme.outline, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    secondary: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.secondary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(colorScheme.onSecondary),
      side: BorderSide(color: colorScheme.outline, width: 2),
    ),
  );
}
```

### 3. Update Theme Provider with Custom Components

```dart
// lib/core/theme/theme_provider.dart
import 'component_extensions.dart';

final themeDataProvider = Provider.family<ThemeData, BuildContext>((ref, context) {
  final colorScheme = CustomFlexScheme.redScheme.light.toColorScheme(Brightness.light);
  final buttonTheme = createButtonTheme(colorScheme);
  final switchTheme = createSwitchTheme(colorScheme);
  final checkboxTheme = createCheckboxTheme(colorScheme);

  return FlexThemeData.light(
    colors: CustomFlexScheme.redScheme.light,
    useMaterial3: true,
    subThemesData: const FlexSubThemesData(
      // ... existing sub themes
    ),
    extensions: [
      _createLightExtension(),
      buttonTheme,
      switchTheme,
      checkboxTheme,
    ],
  ).copyWith(
    // Override specific components if needed
    switchTheme: switchTheme.primary,
    checkboxTheme: checkboxTheme.primary,
  );
});
```

## Testing Components

Create a component test page:

```dart
// lib/features/theme_test/component_test_page.dart
class ComponentTestPage extends StatefulWidget {
  const ComponentTestPage({super.key});

  @override
  State<ComponentTestPage> createState() => _ComponentTestPageState();
}

class _ComponentTestPageState extends State<ComponentTestPage> {
  bool switchValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('Component Test')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Switches
          SwitchListTile(
            title: const Text('Primary Switch'),
            value: switchValue,
            onChanged: (value) => setState(() => switchValue = value),
          ),

          // Checkboxes
          CheckboxListTile(
            title: const Text('Primary Checkbox'),
            value: checkboxValue,
            onChanged: (value) => setState(() => checkboxValue = value),
          ),

          const SizedBox(height: 20),

          // Buttons
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

          // Date Picker
          ElevatedButton(
            onPressed: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
            },
            child: const Text('Show Date Picker'),
          ),

          // Bottom Navigation (mock)
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: 0,
            onTap: (index) {},
          ),
        ],
      ),
    );
  }
}
```

## Next Step

Continue to [06_riverpod_integration.md](06_riverpod_integration.md) to set up theme switching with Riverpod state management.
