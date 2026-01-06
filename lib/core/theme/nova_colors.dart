import 'package:flutter/material.dart';

/// A single color with 12 shade levels (0-100)
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

  final Color shade0;   // Lightest
  final Color shade10;
  final Color shade20;
  final Color shade30;
  final Color shade40;
  final Color shade50;
  final Color shade60;  // Main color
  final Color shade70;
  final Color shade80;
  final Color shade90;
  final Color shade95;
  final Color shade100; // Darkest

  /// Get shade by index (0, 10, 20, ..., 100)
  Color operator [](int shade) {
    return switch (shade) {
      0 => shade0,
      10 => shade10,
      20 => shade20,
      30 => shade30,
      40 => shade40,
      50 => shade50,
      60 => shade60,
      70 => shade70,
      80 => shade80,
      90 => shade90,
      95 => shade95,
      100 => shade100,
      _ => shade60,
    };
  }

  /// Main color (shade60)
  Color get main => shade60;
}

/// NOVA Color System - ThemeExtension
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
    required this.onSurface,
    required this.background,
    required this.onBackground,
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
  final Color onSurface;
  final Color background;
  final Color onBackground;

  // ═══════════════════════════════════════════════════════════════════════════
  // LIGHT THEME COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const light = NovaColors(
    red: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFFEE2E2),
      shade20: Color(0xFFFECACA),
      shade30: Color(0xFFFCA5A5),
      shade40: Color(0xFFF87171),
      shade50: Color(0xFFEF4444),
      shade60: Color(0xFFDC2626),
      shade70: Color(0xFFB91C1C),
      shade80: Color(0xFF991B1B),
      shade90: Color(0xFF7F1D1D),
      shade95: Color(0xFF450A0A),
      shade100: Color(0xFF1C0404),
    ),
    blue: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFDBEAFE),
      shade20: Color(0xFFBFDBFE),
      shade30: Color(0xFF93C5FD),
      shade40: Color(0xFF60A5FA),
      shade50: Color(0xFF3B82F6),
      shade60: Color(0xFF2563EB),
      shade70: Color(0xFF1D4ED8),
      shade80: Color(0xFF1E40AF),
      shade90: Color(0xFF1E3A8A),
      shade95: Color(0xFF172554),
      shade100: Color(0xFF0C1326),
    ),
    ocean: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFE0F2FE),
      shade20: Color(0xFFBAE6FD),
      shade30: Color(0xFF7DD3FC),
      shade40: Color(0xFF38BDF8),
      shade50: Color(0xFF0EA5E9),
      shade60: Color(0xFF0284C7),
      shade70: Color(0xFF0369A1),
      shade80: Color(0xFF075985),
      shade90: Color(0xFF0C4A6E),
      shade95: Color(0xFF082F49),
      shade100: Color(0xFF041726),
    ),
    cyan: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFCFFAFE),
      shade20: Color(0xFFA5F3FC),
      shade30: Color(0xFF67E8F9),
      shade40: Color(0xFF22D3EE),
      shade50: Color(0xFF06B6D4),
      shade60: Color(0xFF0891B2),
      shade70: Color(0xFF0E7490),
      shade80: Color(0xFF155E75),
      shade90: Color(0xFF164E63),
      shade95: Color(0xFF083344),
      shade100: Color(0xFF041A22),
    ),
    green: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFDCFCE7),
      shade20: Color(0xFFBBF7D0),
      shade30: Color(0xFF86EFAC),
      shade40: Color(0xFF4ADE80),
      shade50: Color(0xFF22C55E),
      shade60: Color(0xFF16A34A),
      shade70: Color(0xFF15803D),
      shade80: Color(0xFF166534),
      shade90: Color(0xFF14532D),
      shade95: Color(0xFF052E16),
      shade100: Color(0xFF02150A),
    ),
    yellow: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFFEF9C3),
      shade20: Color(0xFFFEF08A),
      shade30: Color(0xFFFDE047),
      shade40: Color(0xFFFACC15),
      shade50: Color(0xFFEAB308),
      shade60: Color(0xFFCA8A04),
      shade70: Color(0xFFA16207),
      shade80: Color(0xFF854D0E),
      shade90: Color(0xFF713F12),
      shade95: Color(0xFF422006),
      shade100: Color(0xFF1A0E03),
    ),
    purple: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFF3E8FF),
      shade20: Color(0xFFE9D5FF),
      shade30: Color(0xFFD8B4FE),
      shade40: Color(0xFFC084FC),
      shade50: Color(0xFFA855F7),
      shade60: Color(0xFF9333EA),
      shade70: Color(0xFF7E22CE),
      shade80: Color(0xFF6B21A8),
      shade90: Color(0xFF581C87),
      shade95: Color(0xFF3B0764),
      shade100: Color(0xFF1A032B),
    ),
    gray: NovaColorShade(
      shade0: Color(0xFFFFFFFF),
      shade10: Color(0xFFF9FAFB),
      shade20: Color(0xFFF3F4F6),
      shade30: Color(0xFFE5E7EB),
      shade40: Color(0xFFD1D5DB),
      shade50: Color(0xFF9CA3AF),
      shade60: Color(0xFF6B7280),
      shade70: Color(0xFF4B5563),
      shade80: Color(0xFF374151),
      shade90: Color(0xFF1F2937),
      shade95: Color(0xFF111827),
      shade100: Color(0xFF030712),
    ),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1F2937),
    background: Color(0xFFF9FAFB),
    onBackground: Color(0xFF111827),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // DARK THEME COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const dark = NovaColors(
    red: NovaColorShade(
      shade0: Color(0xFF1C0404),
      shade10: Color(0xFF450A0A),
      shade20: Color(0xFF7F1D1D),
      shade30: Color(0xFF991B1B),
      shade40: Color(0xFFB91C1C),
      shade50: Color(0xFFDC2626),
      shade60: Color(0xFFEF4444),
      shade70: Color(0xFFF87171),
      shade80: Color(0xFFFCA5A5),
      shade90: Color(0xFFFECACA),
      shade95: Color(0xFFFEE2E2),
      shade100: Color(0xFFFFFFFF),
    ),
    blue: NovaColorShade(
      shade0: Color(0xFF0C1326),
      shade10: Color(0xFF172554),
      shade20: Color(0xFF1E3A8A),
      shade30: Color(0xFF1E40AF),
      shade40: Color(0xFF1D4ED8),
      shade50: Color(0xFF2563EB),
      shade60: Color(0xFF3B82F6),
      shade70: Color(0xFF60A5FA),
      shade80: Color(0xFF93C5FD),
      shade90: Color(0xFFBFDBFE),
      shade95: Color(0xFFDBEAFE),
      shade100: Color(0xFFFFFFFF),
    ),
    ocean: NovaColorShade(
      shade0: Color(0xFF041726),
      shade10: Color(0xFF082F49),
      shade20: Color(0xFF0C4A6E),
      shade30: Color(0xFF075985),
      shade40: Color(0xFF0369A1),
      shade50: Color(0xFF0284C7),
      shade60: Color(0xFF0EA5E9),
      shade70: Color(0xFF38BDF8),
      shade80: Color(0xFF7DD3FC),
      shade90: Color(0xFFBAE6FD),
      shade95: Color(0xFFE0F2FE),
      shade100: Color(0xFFFFFFFF),
    ),
    cyan: NovaColorShade(
      shade0: Color(0xFF041A22),
      shade10: Color(0xFF083344),
      shade20: Color(0xFF164E63),
      shade30: Color(0xFF155E75),
      shade40: Color(0xFF0E7490),
      shade50: Color(0xFF0891B2),
      shade60: Color(0xFF06B6D4),
      shade70: Color(0xFF22D3EE),
      shade80: Color(0xFF67E8F9),
      shade90: Color(0xFFA5F3FC),
      shade95: Color(0xFFCFFAFE),
      shade100: Color(0xFFFFFFFF),
    ),
    green: NovaColorShade(
      shade0: Color(0xFF02150A),
      shade10: Color(0xFF052E16),
      shade20: Color(0xFF14532D),
      shade30: Color(0xFF166534),
      shade40: Color(0xFF15803D),
      shade50: Color(0xFF16A34A),
      shade60: Color(0xFF22C55E),
      shade70: Color(0xFF4ADE80),
      shade80: Color(0xFF86EFAC),
      shade90: Color(0xFFBBF7D0),
      shade95: Color(0xFFDCFCE7),
      shade100: Color(0xFFFFFFFF),
    ),
    yellow: NovaColorShade(
      shade0: Color(0xFF1A0E03),
      shade10: Color(0xFF422006),
      shade20: Color(0xFF713F12),
      shade30: Color(0xFF854D0E),
      shade40: Color(0xFFA16207),
      shade50: Color(0xFFCA8A04),
      shade60: Color(0xFFEAB308),
      shade70: Color(0xFFFACC15),
      shade80: Color(0xFFFDE047),
      shade90: Color(0xFFFEF08A),
      shade95: Color(0xFFFEF9C3),
      shade100: Color(0xFFFFFFFF),
    ),
    purple: NovaColorShade(
      shade0: Color(0xFF1A032B),
      shade10: Color(0xFF3B0764),
      shade20: Color(0xFF581C87),
      shade30: Color(0xFF6B21A8),
      shade40: Color(0xFF7E22CE),
      shade50: Color(0xFF9333EA),
      shade60: Color(0xFFA855F7),
      shade70: Color(0xFFC084FC),
      shade80: Color(0xFFD8B4FE),
      shade90: Color(0xFFE9D5FF),
      shade95: Color(0xFFF3E8FF),
      shade100: Color(0xFFFFFFFF),
    ),
    gray: NovaColorShade(
      shade0: Color(0xFF030712),
      shade10: Color(0xFF111827),
      shade20: Color(0xFF1F2937),
      shade30: Color(0xFF374151),
      shade40: Color(0xFF4B5563),
      shade50: Color(0xFF6B7280),
      shade60: Color(0xFF9CA3AF),
      shade70: Color(0xFFD1D5DB),
      shade80: Color(0xFFE5E7EB),
      shade90: Color(0xFFF3F4F6),
      shade95: Color(0xFFF9FAFB),
      shade100: Color(0xFFFFFFFF),
    ),
    surface: Color(0xFF1F2937),
    onSurface: Color(0xFFF9FAFB),
    background: Color(0xFF111827),
    onBackground: Color(0xFFFFFFFF),
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
    Color? onSurface,
    Color? background,
    Color? onBackground,
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
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  NovaColors lerp(ThemeExtension<NovaColors>? other, double t) {
    if (other is! NovaColors) return this;
    return NovaColors(
      red: red,
      blue: blue,
      ocean: ocean,
      cyan: cyan,
      green: green,
      yellow: yellow,
      purple: purple,
      gray: gray,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
    );
  }
}
