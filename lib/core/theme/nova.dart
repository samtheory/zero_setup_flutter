/// NOVA Design System
///
/// Neat Organized Visual Architecture
///
/// Usage:
/// ```dart
/// import 'package:zero_setup_flutter/core/theme/nova.dart';
///
/// // Access via context
/// context.nova.colors.blue.shade60
/// context.nova.text.headingLg
/// context.nova.shadows.md
/// context.nova.gradients.primary
///
/// // Theme with provider
/// final themeMode = ref.watch(themeModeProvider);
/// ref.read(themeModeProvider.notifier).toggle();
/// ```
library;

export 'nova_colors.dart';
export 'nova_extensions.dart';
export 'nova_gradients.dart';
export 'nova_provider.dart';
export 'nova_shadows.dart';
export 'nova_theme.dart';
export 'nova_typography.dart';
