# 🎨 NOVA Design System - Core Theme Module

## What is This?

This is your **Design System Core Module** - the foundation layer that provides consistent design tokens, components, and theming across your entire Flutter application. It's infrastructure code that ensures visual consistency and developer experience.

**Not Middleware**: This isn't networking or API handling
**Not Feature**: This isn't business logic or user flows
**Core Infrastructure**: This is your app's visual foundation

---

## 🚀 NOVA Design System Overview

> **NOVA** = **N**eat **O**rganized **V**isual **A**rchitecture

A complete, production-ready design system built on **FlexColorScheme 8.4.0** with modern Riverpod state management.

### ✨ What You Get

- 🎨 **8 Color Palettes** × **12 Shades Each** (96 total colors)
- 📝 **16 Typography Styles** with IRANSansX font
- 🌑 **7 Shadow Levels** for depth
- 🌈 **9 Gradient Presets** for visual interest
- 🔘 **Component Library** (Buttons, Inputs, Text)
- 🔄 **Theme Switching** with persistence (System/Light/Dark)
- 📱 **Material 3** support with automatic dark mode
- 🔧 **Modern Riverpod** (Notifier, not legacy StateNotifier)

### 📁 Current Implementation

```
lib/core/theme/                    # ✅ IMPLEMENTED
├── nova.dart                      # Main barrel export
├── nova_colors.dart               # 8 palettes × 12 shades
├── nova_typography.dart           # 16 text styles
├── nova_shadows.dart              # 7 shadow levels
├── nova_gradients.dart            # 9 gradient presets
├── nova_extensions.dart           # context.nova access
├── nova_theme.dart                # FlexColorScheme config
└── nova_provider.dart             # Modern Notifier for theme switching

lib/shared/nova_components/        # ✅ IMPLEMENTED
├── nova_text.dart                 # Text.nova() with auto_size_text
├── nova_button.dart               # NovaButton variants
├── nova_input.dart                # NovaInput variants
└── nova_components.dart           # Barrel export
```

---

## 🎯 Quick Usage

### Access Design Tokens
```dart
// Colors with shades
context.nova.colors.blue.shade60    // Primary blue
context.nova.colors.red.shade40     // Error red
context.nova.colors.green.shade80   // Success green

// Typography
context.nova.text.headingLg         // Large heading
context.nova.text.bodyMd            // Medium body text
context.nova.text.labelSm           // Small label

// Shadows & Gradients
context.nova.shadows.md             // Medium shadow
context.nova.gradients.primary      // Primary gradient
```

### Use Components
```dart
// Buttons
NovaButton.filled(child: Text('Submit'), onPressed: () {})
NovaButton.filledError(child: Text('Delete'), onPressed: () {})
NovaButton.outlinedSuccess(child: Text('Confirm'), onPressed: () {})

// Text with auto-sizing
Text.novaHeading('Welcome')
Text.novaBody('This text auto-sizes')

// Inputs
NovaInput.outlined(label: 'Email', hint: 'Enter email')
NovaInput.filled(label: 'Password', obscureText: true)
```

### Theme Switching
```dart
// Toggle light/dark
ref.read(themeModeProvider.notifier).toggle();

// Set specific mode
ref.read(themeModeProvider.notifier).setLight();
ref.read(themeModeProvider.notifier).setDark();
ref.read(themeModeProvider.notifier).setSystem();

// Cycle: system → light → dark → system
ref.read(themeModeProvider.notifier).cycle();
```

---

## 📚 Documentation Structure

| Document | Purpose | Status |
|----------|---------|--------|
| **[NOVA_design_system.md](NOVA_design_system.md)** | System overview & architecture | ✅ Complete |
| **[nova_implementation_1_colors.md](nova_implementation_1_colors.md)** | Color system implementation | ✅ Complete |
| **[nova_implementation_2_theme.md](nova_implementation_2_theme.md)** | Typography, shadows, gradients | ✅ Complete |
| **[nova_implementation_3_components.md](nova_implementation_3_components.md)** | UI components | ✅ Complete |
| **[QUICK_START.md](QUICK_START.md)** | Quick reference guide | ✅ Complete |

---

## 🔧 Technical Details

### Dependencies
```yaml
dependencies:
  flex_color_scheme: ^8.4.0      # Theme management
  flutter_riverpod: ^2.4.9       # Modern state management
  auto_size_text: ^3.0.0         # Auto-sizing text
  shared_preferences: ^2.5.3     # Theme persistence
```

### Architecture
- **ThemeExtension Pattern**: Clean separation of design tokens
- **Notifier Pattern**: Modern Riverpod for theme state
- **Barrel Exports**: Easy importing with `core/theme/nova.dart`
- **Context Extensions**: `context.nova` for easy access
- **Component Library**: Pre-built, consistent UI components

### Performance
- **Lazy Loading**: Colors/gradients loaded on demand
- **Theme Persistence**: Saves user preference automatically
- **Efficient Rebuilds**: Only affected widgets rebuild on theme change
- **Material 3 Optimized**: Built-in performance optimizations

---

## 🎨 Color System

### Available Palettes
| Color | Usage | Main Shade |
|-------|-------|------------|
| **Blue** | Primary actions, links | `shade60` |
| **Red** | Errors, destructive actions | `shade60` |
| **Green** | Success, confirmation | `shade60` |
| **Yellow** | Warnings, alerts | `shade60` |
| **Ocean** | Secondary actions | `shade60` |
| **Cyan** | Info, accent | `shade60` |
| **Purple** | Special, premium | `shade60` |
| **Gray** | Neutral, text | `shade60` |

### Shade Scale (0-100)
```
100 → Pure white/black
 95 → Near white/black
 90 → Very light/dark
 80 → Light accent/dark accent
 70 → Medium light/dark
 60 → Main color (default)
 50 → Medium
 40 → Medium dark/light
 30 → Dark accent/light accent
 20 → Very dark/light
 10 → Near black/white
  0 → Pure black/white
```

---

## 📝 Typography System

### Text Styles (16 total)
- **Display**: `displayLg`, `displayMd`, `displaySm` (Headlines)
- **Heading**: `headingLg`, `headingMd`, `headingSm` (Section headers)
- **Title**: `titleLg`, `titleMd`, `titleSm` (Card/component titles)
- **Body**: `bodyLg`, `bodyMd`, `bodySm` (Content text)
- **Label**: `labelLg`, `labelMd`, `labelSm` (Buttons, form labels)
- **Caption**: `caption` (Small metadata)

### Font Family
- **IRANSansX**: Optimized for Persian/Farsi text
- **Material 3 Scale**: Consistent with modern design standards

---

## 🎭 Theme Management

### Provider Architecture
```dart
// Modern Notifier (not legacy StateNotifier)
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system; // Initial state

  // Methods: setLight(), setDark(), setSystem(), toggle(), cycle()
}
```

### Persistence
- **Automatic**: Theme preference saved to SharedPreferences
- **Key**: `'nova_theme_mode'`
- **Restored**: On app launch, user's last choice is restored

### Integration
```dart
// In app.dart
MaterialApp.router(
  theme: novaLightTheme,
  darkTheme: novaDarkTheme,
  themeMode: ref.watch(themeModeProvider), // Reactive theme switching
  // ...
)
```

---

## 🔧 Development Guidelines

### Adding New Colors
1. Add to `NovaColorShade` class in `nova_colors.dart`
2. Update both light and dark theme instances
3. Add to `NovaColors` extension
4. Update documentation

### Adding New Components
1. Create in `lib/shared/nova_components/`
2. Use `context.nova` for design tokens
3. Export in `nova_components.dart`
4. Update documentation

### Testing Theme Changes
1. Test all 3 modes: Light, Dark, System
2. Verify on different screen sizes
3. Check Persian text rendering
4. Test component variants

---

## 🚀 Future Enhancements

### Planned Features
- [ ] **Custom Color Schemes**: User-defined color palettes
- [ ] **Dynamic Theming**: Runtime color customization
- [ ] **Theme Presets**: Multiple complete theme sets
- [ ] **Advanced Components**: Cards, dialogs, bottom sheets
- [ ] **Animation System**: Smooth theme transitions
- [ ] **Accessibility**: High contrast mode, large text support

### Extensibility
- **Plugin Architecture**: Easy addition of new design tokens
- **Override System**: Customize any aspect per screen/component
- **Brand Guidelines**: Export design tokens for designers
- **Documentation**: Auto-generated component documentation

---

## 📞 Support & Maintenance

### This is Production Ready
- ✅ **Tested**: All components work across light/dark themes
- ✅ **Documented**: Complete implementation guides
- ✅ **Performant**: Optimized for production use
- ✅ **Maintainable**: Clean, modular architecture
- ✅ **Extensible**: Easy to add new features

### Maintenance Tasks
- **Weekly**: Review component usage analytics
- **Monthly**: Update dependencies, check for new FlexColorScheme features
- **Quarterly**: Audit color accessibility, update design tokens
- **Annually**: Major version updates, architecture reviews

---

**NOVA Design System** - Your app's visual foundation is solid and ready for production! 🎉
