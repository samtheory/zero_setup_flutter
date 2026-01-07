# NOVA Implementation: Part 1 - Color System

## File: `lib/core/theme/nova_colors.dart`

```dart
import 'package:flutter/material.dart';

/// NOVA Color Shade - A single color with 12 shades (0-100)
class NovaColorShade {
  const NovaColorShade({
    required this.shade0,
    required this.shade10,
    required this.shade20,
    required this.shade30,
    required this.shade40,
    required this.shade50,
    required this.shade60,
    required this.shade70,
    required this.shade80,
    required this.shade90,
    required this.shade95,
    required this.shade100,
  });

  final Color shade0;
  final Color shade10;
  final Color shade20;
  final Color shade30;
  final Color shade40;
  final Color shade50;
  final Color shade60;  // Default/Main color
  final Color shade70;
  final Color shade80;
  final Color shade90;
  final Color shade95;
  final Color shade100;

  /// Get the main color (shade60)
  Color get main => shade60;

  /// Get shade by number
  Color operator [](int shade) {
    switch (shade) {
      case 0: return shade0;
      case 10: return shade10;
      case 20: return shade20;
      case 30: return shade30;
      case 40: return shade40;
      case 50: return shade50;
      case 60: return shade60;
      case 70: return shade70;
      case 80: return shade80;
      case 90: return shade90;
      case 95: return shade95;
      case 100: return shade100;
      default: return shade60;
    }
  }

  /// Interpolate between light and dark mode
  NovaColorShade lerp(NovaColorShade other, double t) {
    return NovaColorShade(
      shade0: Color.lerp(shade0, other.shade0, t)!,
      shade10: Color.lerp(shade10, other.shade10, t)!,
      shade20: Color.lerp(shade20, other.shade20, t)!,
      shade30: Color.lerp(shade30, other.shade30, t)!,
      shade40: Color.lerp(shade40, other.shade40, t)!,
      shade50: Color.lerp(shade50, other.shade50, t)!,
      shade60: Color.lerp(shade60, other.shade60, t)!,
      shade70: Color.lerp(shade70, other.shade70, t)!,
      shade80: Color.lerp(shade80, other.shade80, t)!,
      shade90: Color.lerp(shade90, other.shade90, t)!,
      shade95: Color.lerp(shade95, other.shade95, t)!,
      shade100: Color.lerp(shade100, other.shade100, t)!,
    );
  }
}

/// NOVA Color Palette - All color definitions
class NovaColors extends ThemeExtension<NovaColors> {
  const NovaColors({
    required this.red,
    required this.blue,
    required this.ocean,
    required this.cyan,
    required this.green,
    required this.yellow,
    required this.purple,
    required this.gray,
    required this.surface,
    required this.background,
    required this.onSurface,
  });

  final NovaColorShade red;
  final NovaColorShade blue;
  final NovaColorShade ocean;
  final NovaColorShade cyan;
  final NovaColorShade green;
  final NovaColorShade yellow;
  final NovaColorShade purple;
  final NovaColorShade gray;
  final Color surface;
  final Color background;
  final Color onSurface;

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT MODE COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const light = NovaColors(
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF8FAFC),
    onSurface: Color(0xFF1E293B),
    
    red: NovaColorShade(
      shade100: Color(0xFFFEF2F2),
      shade95: Color(0xFFFEE2E2),
      shade90: Color(0xFFFECACA),
      shade80: Color(0xFFFCA5A5),
      shade70: Color(0xFFF87171),
      shade60: Color(0xFFEF4444),  // Main
      shade50: Color(0xFFDC2626),
      shade40: Color(0xFFB91C1C),
      shade30: Color(0xFF991B1B),
      shade20: Color(0xFF7F1D1D),
      shade10: Color(0xFF450A0A),
      shade0: Color(0xFF000000),
    ),
    
    blue: NovaColorShade(
      shade100: Color(0xFFEFF6FF),
      shade95: Color(0xFFDBEAFE),
      shade90: Color(0xFFBFDBFE),
      shade80: Color(0xFF93C5FD),
      shade70: Color(0xFF60A5FA),
      shade60: Color(0xFF3B82F6),  // Main
      shade50: Color(0xFF2563EB),
      shade40: Color(0xFF1D4ED8),
      shade30: Color(0xFF1E40AF),
      shade20: Color(0xFF1E3A8A),
      shade10: Color(0xFF172554),
      shade0: Color(0xFF000000),
    ),
    
    ocean: NovaColorShade(
      shade100: Color(0xFFECFEFF),
      shade95: Color(0xFFCFFAFE),
      shade90: Color(0xFFA5F3FC),
      shade80: Color(0xFF67E8F9),
      shade70: Color(0xFF22D3EE),
      shade60: Color(0xFF06B6D4),  // Main
      shade50: Color(0xFF0891B2),
      shade40: Color(0xFF0E7490),
      shade30: Color(0xFF155E75),
      shade20: Color(0xFF164E63),
      shade10: Color(0xFF083344),
      shade0: Color(0xFF000000),
    ),
    
    cyan: NovaColorShade(
      shade100: Color(0xFFECFEFF),
      shade95: Color(0xFFCFFAFE),
      shade90: Color(0xFFA5F3FC),
      shade80: Color(0xFF67E8F9),
      shade70: Color(0xFF22D3EE),
      shade60: Color(0xFF06B6D4),  // Main
      shade50: Color(0xFF0891B2),
      shade40: Color(0xFF0E7490),
      shade30: Color(0xFF155E75),
      shade20: Color(0xFF164E63),
      shade10: Color(0xFF083344),
      shade0: Color(0xFF000000),
    ),
    
    green: NovaColorShade(
      shade100: Color(0xFFF0FDF4),
      shade95: Color(0xFFDCFCE7),
      shade90: Color(0xFFBBF7D0),
      shade80: Color(0xFF86EFAC),
      shade70: Color(0xFF4ADE80),
      shade60: Color(0xFF22C55E),  // Main
      shade50: Color(0xFF16A34A),
      shade40: Color(0xFF15803D),
      shade30: Color(0xFF166534),
      shade20: Color(0xFF14532D),
      shade10: Color(0xFF052E16),
      shade0: Color(0xFF000000),
    ),
    
    yellow: NovaColorShade(
      shade100: Color(0xFFFEFCE8),
      shade95: Color(0xFFFEF9C3),
      shade90: Color(0xFFFEF08A),
      shade80: Color(0xFFFDE047),
      shade70: Color(0xFFFACC15),
      shade60: Color(0xFFEAB308),  // Main
      shade50: Color(0xFFCA8A04),
      shade40: Color(0xFFA16207),
      shade30: Color(0xFF854D0E),
      shade20: Color(0xFF713F12),
      shade10: Color(0xFF422006),
      shade0: Color(0xFF000000),
    ),
    
    purple: NovaColorShade(
      shade100: Color(0xFFFAF5FF),
      shade95: Color(0xFFF3E8FF),
      shade90: Color(0xFFE9D5FF),
      shade80: Color(0xFFD8B4FE),
      shade70: Color(0xFFC084FC),
      shade60: Color(0xFFA855F7),  // Main
      shade50: Color(0xFF9333EA),
      shade40: Color(0xFF7E22CE),
      shade30: Color(0xFF6B21A8),
      shade20: Color(0xFF581C87),
      shade10: Color(0xFF3B0764),
      shade0: Color(0xFF000000),
    ),
    
    gray: NovaColorShade(
      shade100: Color(0xFFF9FAFB),
      shade95: Color(0xFFF3F4F6),
      shade90: Color(0xFFE5E7EB),
      shade80: Color(0xFFD1D5DB),
      shade70: Color(0xFF9CA3AF),
      shade60: Color(0xFF6B7280),  // Main
      shade50: Color(0xFF4B5563),
      shade40: Color(0xFF374151),
      shade30: Color(0xFF1F2937),
      shade20: Color(0xFF111827),
      shade10: Color(0xFF030712),
      shade0: Color(0xFF000000),
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK MODE COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const dark = NovaColors(
    surface: Color(0xFF1E293B),
    background: Color(0xFF0F172A),
    onSurface: Color(0xFFF1F5F9),
    
    // Dark mode: shades are inverted for proper contrast
    red: NovaColorShade(
      shade100: Color(0xFF450A0A),
      shade95: Color(0xFF7F1D1D),
      shade90: Color(0xFF991B1B),
      shade80: Color(0xFFB91C1C),
      shade70: Color(0xFFDC2626),
      shade60: Color(0xFFEF4444),  // Main
      shade50: Color(0xFFF87171),
      shade40: Color(0xFFFCA5A5),
      shade30: Color(0xFFFECACA),
      shade20: Color(0xFFFEE2E2),
      shade10: Color(0xFFFEF2F2),
      shade0: Color(0xFFFFFFFF),
    ),
    
    blue: NovaColorShade(
      shade100: Color(0xFF172554),
      shade95: Color(0xFF1E3A8A),
      shade90: Color(0xFF1E40AF),
      shade80: Color(0xFF1D4ED8),
      shade70: Color(0xFF2563EB),
      shade60: Color(0xFF3B82F6),  // Main
      shade50: Color(0xFF60A5FA),
      shade40: Color(0xFF93C5FD),
      shade30: Color(0xFFBFDBFE),
      shade20: Color(0xFFDBEAFE),
      shade10: Color(0xFFEFF6FF),
      shade0: Color(0xFFFFFFFF),
    ),
    
    ocean: NovaColorShade(
      shade100: Color(0xFF083344),
      shade95: Color(0xFF164E63),
      shade90: Color(0xFF155E75),
      shade80: Color(0xFF0E7490),
      shade70: Color(0xFF0891B2),
      shade60: Color(0xFF06B6D4),  // Main
      shade50: Color(0xFF22D3EE),
      shade40: Color(0xFF67E8F9),
      shade30: Color(0xFFA5F3FC),
      shade20: Color(0xFFCFFAFE),
      shade10: Color(0xFFECFEFF),
      shade0: Color(0xFFFFFFFF),
    ),
    
    cyan: NovaColorShade(
      shade100: Color(0xFF083344),
      shade95: Color(0xFF164E63),
      shade90: Color(0xFF155E75),
      shade80: Color(0xFF0E7490),
      shade70: Color(0xFF0891B2),
      shade60: Color(0xFF06B6D4),  // Main
      shade50: Color(0xFF22D3EE),
      shade40: Color(0xFF67E8F9),
      shade30: Color(0xFFA5F3FC),
      shade20: Color(0xFFCFFAFE),
      shade10: Color(0xFFECFEFF),
      shade0: Color(0xFFFFFFFF),
    ),
    
    green: NovaColorShade(
      shade100: Color(0xFF052E16),
      shade95: Color(0xFF14532D),
      shade90: Color(0xFF166534),
      shade80: Color(0xFF15803D),
      shade70: Color(0xFF16A34A),
      shade60: Color(0xFF22C55E),  // Main
      shade50: Color(0xFF4ADE80),
      shade40: Color(0xFF86EFAC),
      shade30: Color(0xFFBBF7D0),
      shade20: Color(0xFFDCFCE7),
      shade10: Color(0xFFF0FDF4),
      shade0: Color(0xFFFFFFFF),
    ),
    
    yellow: NovaColorShade(
      shade100: Color(0xFF422006),
      shade95: Color(0xFF713F12),
      shade90: Color(0xFF854D0E),
      shade80: Color(0xFFA16207),
      shade70: Color(0xFFCA8A04),
      shade60: Color(0xFFEAB308),  // Main
      shade50: Color(0xFFFACC15),
      shade40: Color(0xFFFDE047),
      shade30: Color(0xFFFEF08A),
      shade20: Color(0xFFFEF9C3),
      shade10: Color(0xFFFEFCE8),
      shade0: Color(0xFFFFFFFF),
    ),
    
    purple: NovaColorShade(
      shade100: Color(0xFF3B0764),
      shade95: Color(0xFF581C87),
      shade90: Color(0xFF6B21A8),
      shade80: Color(0xFF7E22CE),
      shade70: Color(0xFF9333EA),
      shade60: Color(0xFFA855F7),  // Main
      shade50: Color(0xFFC084FC),
      shade40: Color(0xFFD8B4FE),
      shade30: Color(0xFFE9D5FF),
      shade20: Color(0xFFF3E8FF),
      shade10: Color(0xFFFAF5FF),
      shade0: Color(0xFFFFFFFF),
    ),
    
    gray: NovaColorShade(
      shade100: Color(0xFF030712),
      shade95: Color(0xFF111827),
      shade90: Color(0xFF1F2937),
      shade80: Color(0xFF374151),
      shade70: Color(0xFF4B5563),
      shade60: Color(0xFF6B7280),  // Main
      shade50: Color(0xFF9CA3AF),
      shade40: Color(0xFFD1D5DB),
      shade30: Color(0xFFE5E7EB),
      shade20: Color(0xFFF3F4F6),
      shade10: Color(0xFFF9FAFB),
      shade0: Color(0xFFFFFFFF),
    ),
  );

  @override
  NovaColors copyWith({
    NovaColorShade? red,
    NovaColorShade? blue,
    NovaColorShade? ocean,
    NovaColorShade? cyan,
    NovaColorShade? green,
    NovaColorShade? yellow,
    NovaColorShade? purple,
    NovaColorShade? gray,
    Color? surface,
    Color? background,
    Color? onSurface,
  }) {
    return NovaColors(
      red: red ?? this.red,
      blue: blue ?? this.blue,
      ocean: ocean ?? this.ocean,
      cyan: cyan ?? this.cyan,
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      purple: purple ?? this.purple,
      gray: gray ?? this.gray,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      onSurface: onSurface ?? this.onSurface,
    );
  }

  @override
  NovaColors lerp(ThemeExtension<NovaColors>? other, double t) {
    if (other is! NovaColors) return this;
    return NovaColors(
      red: red.lerp(other.red, t),
      blue: blue.lerp(other.blue, t),
      ocean: ocean.lerp(other.ocean, t),
      cyan: cyan.lerp(other.cyan, t),
      green: green.lerp(other.green, t),
      yellow: yellow.lerp(other.yellow, t),
      purple: purple.lerp(other.purple, t),
      gray: gray.lerp(other.gray, t),
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
    );
  }
}
```

## Usage Examples

```dart
// Access colors via context extension
final colors = context.nova.colors;

// Get specific shade
colors.blue.shade60      // Main blue
colors.blue.shade80      // Light blue
colors.blue.shade40      // Dark blue
colors.blue[60]          // Same as shade60

// Semantic usage
colors.red.main          // Error color
colors.green.main        // Success color
colors.yellow.main       // Warning color

// Surface colors
colors.surface           // Card/surface background
colors.background        // Page background
colors.onSurface         // Text on surface
```

## Add New Color

To add a new color (e.g., `pink`):

```dart
// 1. Add property to NovaColors class
final NovaColorShade pink;

// 2. Add to light and dark constructors
pink: NovaColorShade(
  shade100: Color(0xFFFDF2F8),
  shade95: Color(0xFFFCE7F3),
  // ... all shades
),

// 3. Add to copyWith and lerp methods
```
