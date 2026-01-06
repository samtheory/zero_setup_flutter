import 'package:flutter/material.dart';

/// NOVA Gradient System - ThemeExtension
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

  static const light = NovaGradients(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
    ),
    secondary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
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
      colors: [Color(0xFF06B6D4), Color(0xFF0284C7)],
    ),
    sunset: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF87171), Color(0xFFFACC15)],
    ),
    purple: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFA855F7), Color(0xFF9333EA)],
    ),
    dark: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF374151), Color(0xFF1F2937)],
    ),
  );

  static const dark = NovaGradients(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
    ),
    secondary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
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
      colors: [Color(0xFF22D3EE), Color(0xFF0EA5E9)],
    ),
    sunset: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFCA5A5), Color(0xFFFDE047)],
    ),
    purple: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFC084FC), Color(0xFFA855F7)],
    ),
    dark: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF4B5563), Color(0xFF374151)],
    ),
  );

  @override
  NovaGradients copyWith({
    LinearGradient? primary,
    LinearGradient? secondary,
    LinearGradient? success,
    LinearGradient? error,
    LinearGradient? warning,
    LinearGradient? ocean,
    LinearGradient? sunset,
    LinearGradient? purple,
    LinearGradient? dark,
  }) {
    return NovaGradients(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      ocean: ocean ?? this.ocean,
      sunset: sunset ?? this.sunset,
      purple: purple ?? this.purple,
      dark: dark ?? this.dark,
    );
  }

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
