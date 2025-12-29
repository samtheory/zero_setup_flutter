import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../logger/app_logger.dart';
import 'notification_types.dart';
import 'widgets/notification_bottom_sheet.dart';
import 'widgets/notification_dialog.dart';

// ═══════════════════════════════════════════════════════════════════════════
// NOTIFICATION SERVICE
//
// A centralized service for showing all types of notifications:
// - Toasts (quick messages)
// - Snackbars (material design)
// - Dialogs (alerts, confirmations)
// - Bottom sheets (modals)
// - Banners (persistent top messages)
//
// ═══════════════════════════════════════════════════════════════════════════
// USAGE EXAMPLES
// ═══════════════════════════════════════════════════════════════════════════
//
// 1. IN WIDGETS (Recommended - via context.notify extension):
//    ─────────────────────────────────────────────────────────
//    import 'package:zero_setup_flutter/core/core.dart';
//
//    // Quick methods
//    context.notify.showSuccess('Profile updated!');
//    context.notify.showError('Network error', onRetry: () => retry());
//    context.notify.showWarning('This action is risky');
//    context.notify.showInfo('Tip: Swipe to dismiss');
//
//    // Confirmation dialog (returns bool)
//    final confirmed = await context.notify.showConfirmation(
//      title: 'Delete item?',
//      message: 'This cannot be undone.',
//    );
//    if (confirmed) deleteItem();
//
//    // Loading indicator (returns dismiss function)
//    final dismiss = context.notify.showLoading(message: 'Saving...');
//    await saveData();
//    dismiss();
//
// 2. CUSTOM NOTIFICATIONS:
//    ─────────────────────────────────────────────────────────
//    // Bottom sheet
//    context.notify.show(NotificationConfig.bottomSheet(
//      title: 'New Message',
//      message: 'You have received a message from John',
//      icon: Icons.message,
//      primaryAction: () => openMessage(),
//      primaryActionLabel: 'View',
//    ));
//
//    // Snackbar
//    context.notify.show(NotificationConfig(
//      type: NotificationType.snackbar,
//      title: 'Saved',
//      severity: NotificationSeverity.success,
//    ));
//
//    // Banner (persistent top message)
//    context.notify.show(NotificationConfig(
//      type: NotificationType.banner,
//      title: 'No internet connection',
//      severity: NotificationSeverity.warning,
//      primaryAction: () => checkConnection(),
//      primaryActionLabel: 'Retry',
//    ));
//
// 3. IN USE CASES/REPOSITORIES (via Riverpod provider):
//    ─────────────────────────────────────────────────────────
//    // First, wrap your screen with NotificationScope:
//    NotificationScope(child: MyScreen())
//
//    // Then in use case or repository:
//    class DeleteItemUseCase {
//      final Ref ref;
//      DeleteItemUseCase(this.ref);
//
//      Future<void> call(String id) async {
//        try {
//          await _repo.delete(id);
//          ref.read(notificationServiceProvider).showSuccess('Deleted!');
//        } catch (e) {
//          ref.read(notificationServiceProvider).showError('Failed');
//        }
//      }
//    }
//
// 4. DISMISS NOTIFICATIONS:
//    ─────────────────────────────────────────────────────────
//    context.notify.dismissAllToasts();
//    context.notify.dismissSnackbar();
//    context.notify.dismissBanner();
//
// ═══════════════════════════════════════════════════════════════════════════

class NotificationService {
  NotificationService(this._context);

  final BuildContext _context;

  // ═══════════════════════════════════════════════════════════════════════════
  // QUICK METHODS (Most common use cases)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Show success notification
  void showSuccess(String message, {String? title}) {
    show(NotificationConfig.success(title: title ?? 'Success', message: message));
  }

  /// Show error notification with optional retry
  void showError(String message, {String? title, VoidCallback? onRetry}) {
    show(NotificationConfig.error(title: title ?? 'Error', message: message, onRetry: onRetry));
  }

  /// Show warning notification
  void showWarning(String message, {String? title, VoidCallback? onConfirm}) {
    show(NotificationConfig.warning(title: title ?? 'Warning', message: message, onConfirm: onConfirm));
  }

  /// Show info notification
  void showInfo(String message, {String? title}) {
    show(NotificationConfig.info(title: title ?? 'Info', message: message));
  }

  /// Show confirmation dialog
  Future<bool> showConfirmation({
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    NotificationSeverity severity = NotificationSeverity.warning,
  }) async {
    final result = await showDialog<bool>(
      context: _context,
      barrierDismissible: false,
      builder: (context) => NotificationDialog(
        config: NotificationConfig(
          type: NotificationType.dialog,
          title: title,
          message: message,
          severity: severity,
          primaryActionLabel: confirmLabel,
          secondaryActionLabel: cancelLabel,
          dismissible: false,
        ),
        onPrimaryAction: () => Navigator.of(context).pop(true),
        onSecondaryAction: () => Navigator.of(context).pop(false),
      ),
    );
    return result ?? false;
  }

  /// Show loading indicator (returns dismiss function)
  VoidCallback showLoading({String message = 'Loading...'}) {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 24),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
    );

    return () {
      if (_context.mounted) {
        Navigator.of(_context).pop();
      }
    };
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MAIN SHOW METHOD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Show notification based on config
  void show(NotificationConfig config) {
    talker.debug('NotificationService: Showing ${config.type.name} - ${config.title}');

    switch (config.type) {
      case NotificationType.toast:
        _showToast(config);
      case NotificationType.snackbar:
        _showSnackbar(config);
      case NotificationType.bottomSheet:
        _showBottomSheet(config);
      case NotificationType.dialog:
        _showDialog(config);
      case NotificationType.banner:
        _showBanner(config);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DISMISS METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Dismiss all toasts
  void dismissAllToasts() {
    toastification.dismissAll();
  }

  /// Dismiss current snackbar
  void dismissSnackbar() {
    ScaffoldMessenger.of(_context).hideCurrentSnackBar();
  }

  /// Dismiss current banner
  void dismissBanner() {
    ScaffoldMessenger.of(_context).hideCurrentMaterialBanner();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PRIVATE IMPLEMENTATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  void _showToast(NotificationConfig config) {
    final toastType = switch (config.severity) {
      NotificationSeverity.success => ToastificationType.success,
      NotificationSeverity.error => ToastificationType.error,
      NotificationSeverity.warning => ToastificationType.warning,
      NotificationSeverity.info => ToastificationType.info,
    };

    toastification.show(
      context: _context,
      title: Text(config.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      description: config.message != null ? Text(config.message!) : null,
      type: toastType,
      style: ToastificationStyle.flat,
      autoCloseDuration: config.duration,
      alignment: config.showAtTop ? Alignment.topCenter : Alignment.bottomCenter,
      showProgressBar: false,
      closeButtonShowType: config.dismissible ? CloseButtonShowType.onHover : CloseButtonShowType.none,
      closeOnClick: config.dismissible,
      pauseOnHover: true,
      dragToClose: config.dismissible,
      callbacks: ToastificationCallbacks(
        onTap: config.primaryAction != null
            ? (item) {
                config.primaryAction!();
                toastification.dismiss(item);
              }
            : null,
      ),
    );
  }

  void _showSnackbar(NotificationConfig config) {
    final color = config.getColor(_context);

    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(config.effectiveIcon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    config.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (config.message != null) Text(config.message!, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: color,
        duration: config.duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: config.primaryAction != null && config.primaryActionLabel != null
            ? SnackBarAction(
                label: config.primaryActionLabel!,
                textColor: Colors.white,
                onPressed: config.primaryAction!,
              )
            : null,
        dismissDirection: config.dismissible ? DismissDirection.horizontal : DismissDirection.none,
      ),
    );
  }

  void _showBottomSheet(NotificationConfig config) {
    showModalBottomSheet(
      context: _context,
      isDismissible: config.dismissible,
      enableDrag: config.dismissible,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => NotificationBottomSheet(
        config: config,
        onPrimaryAction: config.primaryAction != null
            ? () {
                Navigator.of(context).pop();
                config.primaryAction!();
              }
            : null,
        onSecondaryAction: config.secondaryAction != null
            ? () {
                Navigator.of(context).pop();
                config.secondaryAction!();
              }
            : null,
      ),
    );
  }

  void _showDialog(NotificationConfig config) {
    showDialog(
      context: _context,
      barrierDismissible: config.dismissible,
      builder: (context) => NotificationDialog(
        config: config,
        onPrimaryAction: config.primaryAction != null
            ? () {
                Navigator.of(context).pop();
                config.primaryAction!();
              }
            : () => Navigator.of(context).pop(),
        onSecondaryAction: config.secondaryAction != null
            ? () {
                Navigator.of(context).pop();
                config.secondaryAction!();
              }
            : null,
      ),
    );
  }

  void _showBanner(NotificationConfig config) {
    final color = config.getColor(_context);

    ScaffoldMessenger.of(_context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: config.getBackgroundColor(_context),
        leading: Icon(config.effectiveIcon, color: color),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              config.title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            if (config.message != null) Text(config.message!, style: TextStyle(color: color.withValues(alpha: 0.8))),
          ],
        ),
        actions: [
          if (config.primaryAction != null && config.primaryActionLabel != null)
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(_context).hideCurrentMaterialBanner();
                config.primaryAction!();
              },
              child: Text(config.primaryActionLabel!),
            ),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(_context).hideCurrentMaterialBanner(),
            child: Text(config.dismissible ? 'Dismiss' : 'OK'),
          ),
        ],
      ),
    );
  }
}
