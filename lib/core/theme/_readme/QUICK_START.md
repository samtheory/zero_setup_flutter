# NOVA Design System - Quick Start Guide

## 📦 Installation

Add to `pubspec.yaml`:
```yaml
dependencies:
  flex_color_scheme: ^8.4.0
  auto_size_text: ^3.0.0
```

## 📁 File Structure

```
lib/
├── core/theme/
│   ├── nova.dart                 # Barrel export
│   ├── nova_colors.dart          # Color system
│   ├── nova_typography.dart      # Text styles
│   ├── nova_shadows.dart         # Shadow presets
│   ├── nova_gradients.dart       # Gradient presets
│   ├── nova_extensions.dart      # Context extensions
│   └── nova_theme.dart           # FlexColorScheme config
│
└── shared/nova_components/
    ├── nova_components.dart      # Barrel export
    ├── nova_text.dart            # Auto-size text
    ├── nova_button.dart          # Button variants
    └── nova_input.dart           # Input variants
```

## 🎨 Quick Usage

### Access Design System
```dart
// Colors with shades (0-100)
context.nova.colors.blue.shade60    // Primary blue
context.nova.colors.red.shade60     // Error red
context.nova.colors.green.shade60   // Success green
context.nova.colors.ocean.shade60   // Secondary ocean

// Typography
context.nova.text.headingLg
context.nova.text.bodyMd
context.nova.text.labelSm

// Shadows
context.nova.shadows.md
context.nova.shadows.lg

// Gradients
context.nova.gradients.primary
context.nova.gradients.ocean
```

### Components
```dart
// Text (auto-sizing)
NovaText.heading('My Title')
NovaText.body('Some body text')
NovaText.auto('Auto-sizing text')
NovaText.heading('My Title')
NovaText.body('Some body text')
NovaText.auto('Auto-sizing text')

// Text extention --need to be implement if needed it's on the docs
Text.novaHeading('Title')
Text.novaBody('Content')

// Buttons
NovaButton.filled(child: Text('Submit'), onPressed: () {})
NovaButton.filledError(child: Text('Delete'), onPressed: () {})
NovaButton.filledSuccess(child: Text('Approve'), onPressed: () {})
NovaButton.outlined(child: Text('Cancel'), onPressed: () {})
NovaButton.outlinedSuccess(child: Text('Confirm'), onPressed: () {})

// Inputs
NovaInput.outlined(label: 'Email', hint: 'Enter email')
NovaInput.filled(label: 'Password', obscureText: true)
NovaInput.search(hint: 'Search...')
```

## 🎯 Available Colors

| Color   | Usage              |
|---------|-------------------|
| blue    | Primary actions   |
| red     | Error, danger     |
| green   | Success, confirm  |
| yellow  | Warning           |
| ocean   | Secondary         |
| cyan    | Info              |
| purple  | Accent            |
| gray    | Neutral           |

## 📐 Shade Scale

```
0   → Lightest (white tint)
10  → Very light
20  → Light
30  → Light medium
40  → Medium light
50  → Medium
60  → Main color ← DEFAULT
70  → Medium dark
80  → Dark
90  → Very dark
95  → Near black
100 → Darkest
```

## 🔗 Documentation Files

1. [NOVA_design_system.md](NOVA_design_system.md) - Overview
2. [nova_implementation_1_colors.md](nova_implementation_1_colors.md) - Colors
3. [nova_implementation_2_theme.md](nova_implementation_2_theme.md) - Typography, Shadows, Gradients
4. [nova_implementation_3_components.md](nova_implementation_3_components.md) - UI Components

## ⚡ Setup in main.dart

```dart
import 'package:flutter/material.dart';
import 'core/theme/nova.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: novaLightTheme,
      darkTheme: novaDarkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
```

---

**NOVA** = **N**eat **O**rganized **V**isual **A**rchitecture
