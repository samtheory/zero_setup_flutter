# 🚀 NOVA Design System

> **NOVA** = **N**eat **O**rganized **V**isual **A**rchitecture

A clean, extensible design system built on FlexColorScheme 8.4.0 for Flutter.

---

## 📁 Project Structure

```
lib/
├── core/
│   └── theme/
│       ├── nova.dart                 # Main barrel export
│       ├── nova_theme.dart           # FlexColorScheme configuration
│       ├── nova_colors.dart          # Color palettes with shades
│       ├── nova_typography.dart      # Text styles
│       ├── nova_shadows.dart         # Shadow definitions
│       ├── nova_gradients.dart       # Gradient definitions
│       └── nova_extensions.dart      # ThemeData extensions
│
└── shared/
    └── nova_components/
        ├── nova_components.dart      # Barrel export
        ├── nova_text.dart            # Text.nova() with auto_size
        ├── nova_button.dart          # NovaButton variants
        ├── nova_input.dart           # NovaInput variants
        └── nova_card.dart            # NovaCard variants
```

---

## 🎨 Color System

### Shade Scale (0-100)

```
100 ━━━━ Lightest (backgrounds)
 95 ━━━━ Very light
 90 ━━━━ Light
 80 ━━━━ Light accent
 70 ━━━━ Medium light
 60 ━━━━ Medium (default)
 50 ━━━━ Medium dark
 40 ━━━━ Dark accent
 30 ━━━━ Dark
 20 ━━━━ Very dark
 10 ━━━━ Darkest (text on light)
  0 ━━━━ Pure (black/white)
```

### Color Palettes

| Name | Base Color | Usage |
|------|-----------|-------|
| **Red** | `#DC2626` | Error, destructive |
| **Blue** | `#2563EB` | Primary, info |
| **Ocean** | `#0891B2` | Secondary, links |
| **Cyan** | `#06B6D4` | Accent |
| **Green** | `#16A34A` | Success |
| **Yellow** | `#EAB308` | Warning |
| **Purple** | `#9333EA` | Special |
| **Gray** | `#6B7280` | Neutral, text |

---

## 🔘 Component Variants

### Buttons

```dart
// Filled variants
NovaButton.filled(...)           // Primary blue
NovaButton.filledError(...)      // Red destructive
NovaButton.filledSuccess(...)    // Green success
NovaButton.filledWarning(...)    // Yellow warning

// Outlined variants
NovaButton.outlined(...)         // Primary outline
NovaButton.outlinedError(...)    // Red outline
NovaButton.outlinedSuccess(...)  // Green outline

// Text/Ghost variants
NovaButton.text(...)             // Text only
NovaButton.textError(...)        // Red text
```

### Inputs

```dart
NovaInput.standard(...)          // Default input
NovaInput.filled(...)            // Filled background
NovaInput.outlined(...)          // Outlined border
NovaInput.error(...)             // Error state
NovaInput.success(...)           // Success state
```

### Text with Auto-Size

```dart
// Using flutter_auto_size_text
Text.nova('Hello')               // Standard text
Text.novaHeading('Title')        // Heading style
Text.novaBody('Content')         // Body style
Text.novaLabel('Label')          // Label style
```

---

## 🧩 Usage Examples

### Quick Access via Extensions

```dart
// Colors
context.nova.colors.blue.shade60
context.nova.colors.red.shade40
context.nova.colors.ocean.shade80

// Typography
context.nova.text.heading
context.nova.text.body
context.nova.text.label

// Shadows
context.nova.shadows.sm
context.nova.shadows.md
context.nova.shadows.lg

// Gradients
context.nova.gradients.primary
context.nova.gradients.success
context.nova.gradients.sunset
```

### Component Usage

```dart
// Buttons
NovaButton.filled(
  onPressed: () {},
  child: Text('Submit'),
)

NovaButton.filledError(
  onPressed: () {},
  child: Text('Delete'),
)

// Text with auto-size
Text.nova('Hello World')
Text.novaHeading('Welcome')

// Inputs
NovaInput.outlined(
  label: 'Email',
  hint: 'Enter your email',
)
```

---

## 📦 Dependencies

```yaml
dependencies:
  flex_color_scheme: ^8.4.0
  flutter_riverpod: ^2.4.9
  auto_size_text: ^3.0.0
```

---

## 🚀 Implementation Steps

### Step 1: Core Theme Setup

1. Create `nova_colors.dart` - All color palettes
2. Create `nova_theme.dart` - FlexColorScheme config
3. Create `nova_extensions.dart` - Easy access extensions

### Step 2: Design Tokens

1. Create `nova_typography.dart` - Text styles
2. Create `nova_shadows.dart` - Shadow presets
3. Create `nova_gradients.dart` - Gradient presets

### Step 3: Components

1. Create `nova_button.dart` - Button variants
2. Create `nova_text.dart` - Auto-size text
3. Create `nova_input.dart` - Input variants

### Step 4: Integration

1. Export everything via `nova.dart`
2. Set up in `main.dart`
3. Use throughout app

---

## Next: Implementation Files

1. [nova_implementation_1_colors.md](nova_implementation_1_colors.md) - Color System
2. [nova_implementation_2_theme.md](nova_implementation_2_theme.md) - Theme Config
3. [nova_implementation_3_components.md](nova_implementation_3_components.md) - UI Components
