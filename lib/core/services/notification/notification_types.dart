import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// NOTIFICATION TYPES
// ═══════════════════════════════════════════════════════════════════════════

/// Types of notifications
enum NotificationType {
  /// Quick toast message (top/bottom)
  toast,

  /// Material snackbar (bottom)
  snackbar,

  /// Bottom sheet modal
  bottomSheet,

  /// Alert dialog
  dialog,

  /// Material banner (top, persistent)
  banner,
}

/// Severity level for styling
enum NotificationSeverity { success, error, warning, info }

// ═══════════════════════════════════════════════════════════════════════════
// NOTIFICATION CONFIG
// ═══════════════════════════════════════════════════════════════════════════

/// Configuration for showing a notification
class NotificationConfig {
  const NotificationConfig({
    required this.type,
    required this.title,
    this.message,
    this.severity = NotificationSeverity.info,
    this.icon,
    this.duration = const Duration(seconds: 3),
    this.primaryAction,
    this.primaryActionLabel,
    this.secondaryAction,
    this.secondaryActionLabel,
    this.dismissible = true,
    this.showAtTop = true,
  });

  /// Type of notification UI
  final NotificationType type;

  /// Title text
  final String title;

  /// Optional message/description
  final String? message;

  /// Severity level (affects styling)
  final NotificationSeverity severity;

  /// Custom icon (uses severity default if null)
  final IconData? icon;

  /// Duration for auto-dismissing notifications
  final Duration duration;

  /// Primary action callback (e.g., Retry, Confirm)
  final VoidCallback? primaryAction;

  /// Primary action button label
  final String? primaryActionLabel;

  /// Secondary action callback (e.g., Cancel)
  final VoidCallback? secondaryAction;

  /// Secondary action button label
  final String? secondaryActionLabel;

  /// Whether notification can be dismissed by user
  final bool dismissible;

  /// Show at top (true) or bottom (false)
  final bool showAtTop;

  // ═══════════════════════════════════════════════════════════════════════════
  // FACTORY CONSTRUCTORS (Quick configs)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success toast
  factory NotificationConfig.success({
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 3),
  }) => NotificationConfig(
    type: NotificationType.toast,
    title: title,
    message: message,
    severity: NotificationSeverity.success,
    duration: duration,
  );

  /// Error toast with optional retry
  factory NotificationConfig.error({
    required String title,
    String? message,
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) => NotificationConfig(
    type: NotificationType.toast,
    title: title,
    message: message,
    severity: NotificationSeverity.error,
    duration: duration,
    primaryAction: onRetry,
    primaryActionLabel: onRetry != null ? 'Retry' : null,
  );

  /// Warning dialog
  factory NotificationConfig.warning({
    required String title,
    String? message,
    VoidCallback? onConfirm,
    String confirmLabel = 'OK',
  }) => NotificationConfig(
    type: NotificationType.dialog,
    title: title,
    message: message,
    severity: NotificationSeverity.warning,
    primaryAction: onConfirm,
    primaryActionLabel: confirmLabel,
  );

  /// Info toast
  factory NotificationConfig.info({
    required String title,
    String? message,
    Duration duration = const Duration(seconds: 3),
  }) => NotificationConfig(
    type: NotificationType.toast,
    title: title,
    message: message,
    severity: NotificationSeverity.info,
    duration: duration,
  );

  /// Confirmation dialog with actions
  factory NotificationConfig.confirm({
    required String title,
    String? message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    NotificationSeverity severity = NotificationSeverity.warning,
  }) => NotificationConfig(
    type: NotificationType.dialog,
    title: title,
    message: message,
    severity: severity,
    primaryAction: onConfirm,
    primaryActionLabel: confirmLabel,
    secondaryAction: onCancel,
    secondaryActionLabel: cancelLabel,
    dismissible: false,
  );

  /// Bottom sheet notification
  factory NotificationConfig.bottomSheet({
    required String title,
    String? message,
    IconData? icon,
    VoidCallback? primaryAction,
    String? primaryActionLabel,
  }) => NotificationConfig(
    type: NotificationType.bottomSheet,
    title: title,
    message: message,
    icon: icon,
    primaryAction: primaryAction,
    primaryActionLabel: primaryActionLabel,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get default icon for severity
  IconData get effectiveIcon {
    if (icon != null) return icon!;

    return switch (severity) {
      NotificationSeverity.success => Icons.check_circle_outline,
      NotificationSeverity.error => Icons.error_outline,
      NotificationSeverity.warning => Icons.warning_amber_outlined,
      NotificationSeverity.info => Icons.info_outline,
    };
  }

  /// Get color for severity
  Color getColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (severity) {
      NotificationSeverity.success => Colors.green,
      NotificationSeverity.error => colorScheme.error,
      NotificationSeverity.warning => Colors.orange,
      NotificationSeverity.info => colorScheme.primary,
    };
  }

  /// Get background color for severity
  Color getBackgroundColor(BuildContext context) {
    return switch (severity) {
      NotificationSeverity.success => Colors.green.shade50,
      NotificationSeverity.error => Colors.red.shade50,
      NotificationSeverity.warning => Colors.orange.shade50,
      NotificationSeverity.info => Colors.blue.shade50,
    };
  }
}
