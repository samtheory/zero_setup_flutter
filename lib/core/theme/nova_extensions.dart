import 'package:flutter/material.dart';

import 'nova_colors.dart';
import 'nova_gradients.dart';
import 'nova_shadows.dart';
import 'nova_typography.dart';

/// NOVA Design System accessor
class Nova {
  Nova._(this._context);

  final BuildContext _context;

  /// Access color shades
  NovaColors get colors =>
      Theme.of(_context).extension<NovaColors>() ?? NovaColors.light;

  /// Access typography styles
  NovaTypography get text =>
      Theme.of(_context).extension<NovaTypography>() ?? NovaTypography.standard;

  /// Access shadow presets
  NovaShadows get shadows =>
      Theme.of(_context).extension<NovaShadows>() ?? NovaShadows.light;

  /// Access gradient presets
  NovaGradients get gradients =>
      Theme.of(_context).extension<NovaGradients>() ?? NovaGradients.light;

  /// Check if dark mode
  bool get isDark => Theme.of(_context).brightness == Brightness.dark;
}

/// Extension to access NOVA via context
extension NovaExtension on BuildContext {
  /// Access NOVA design system
  /// 
  /// Usage:
  /// ```dart
  /// context.nova.colors.blue.shade60
  /// context.nova.text.headingLg
  /// context.nova.shadows.md
  /// context.nova.gradients.primary
  /// ```
  Nova get nova => Nova._(this);
}
