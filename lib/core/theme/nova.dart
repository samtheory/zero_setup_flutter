/// NOVA Design System
///
/// Neat Organized Visual Architecture
///
/// Usage:
/// ```dart
/// import 'package:your_app/core/theme/nova.dart';
///
/// // Access via context
/// context.nova.colors.blue.shade60
/// context.nova.text.headingLg
/// context.nova.shadows.md
/// context.nova.gradients.primary
///
/// // Theme data
/// MaterialApp(
///   theme: novaLightTheme,
///   darkTheme: novaDarkTheme,
/// )
/// ```
library;

export 'nova_colors.dart';
export 'nova_extensions.dart';
export 'nova_gradients.dart';
export 'nova_shadows.dart';
export 'nova_theme.dart';
export 'nova_typography.dart';
