import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'notification_service.dart';

// ═══════════════════════════════════════════════════════════════════════════
// NOTIFICATION PROVIDER
//
// There are 2 ways to use this service:
//
// 1. IN WIDGETS (Recommended):
//    Use the extension method on BuildContext:
//    ```dart
//    context.notify.showSuccess('Done!');
//    context.notify.showError('Failed', onRetry: () => retry());
//    ```
//
// 2. IN USE CASES/REPOSITORIES (Advanced):
//    Override the provider with BuildContext in your screen:
//    ```dart
//    ProviderScope(
//      overrides: [notificationServiceProvider.overrideWithValue(NotificationService(context))],
//      child: ...,
//    )
//    ```
// ═══════════════════════════════════════════════════════════════════════════

/// Provider for NotificationService (requires override with BuildContext)
final notificationServiceProvider = Provider<NotificationService>((ref) {
  throw UnimplementedError(
    'notificationServiceProvider must be overridden with a BuildContext.\n'
    'Use context.notify extension instead for widget-based usage.',
  );
});

// ═══════════════════════════════════════════════════════════════════════════
// CONTEXT EXTENSION (Easiest way to use)
// ═══════════════════════════════════════════════════════════════════════════

/// Extension on BuildContext for easy notification access
extension NotificationContextExtension on BuildContext {
  /// Get NotificationService for this context
  ///
  /// Usage:
  /// ```dart
  /// context.notify.showSuccess('Profile updated!');
  /// context.notify.showError('Network error', onRetry: () => retry());
  /// context.notify.showWarning('Are you sure?');
  /// context.notify.showInfo('Tip: You can swipe to dismiss');
  ///
  /// // With confirmation dialog
  /// final confirmed = await context.notify.showConfirmation(
  ///   title: 'Delete item?',
  ///   message: 'This action cannot be undone.',
  /// );
  /// if (confirmed) deleteItem();
  ///
  /// // With loading indicator
  /// final dismiss = context.notify.showLoading(message: 'Saving...');
  /// await saveData();
  /// dismiss();
  /// ```
  NotificationService get notify => NotificationService(this);
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET FOR SCOPED PROVIDER (Alternative approach)
// ═══════════════════════════════════════════════════════════════════════════

/// Widget that provides NotificationService to its descendants via Riverpod
///
/// Use this if you need to access NotificationService in non-widget code
/// (repositories, use cases) via ref.read(notificationServiceProvider)
///
/// ```dart
/// NotificationScope(
///   child: MyScreen(),
/// )
/// ```
class NotificationScope extends ConsumerWidget {
  const NotificationScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [notificationServiceProvider.overrideWithValue(NotificationService(context))],
      child: child,
    );
  }
}
