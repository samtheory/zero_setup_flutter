import 'package:flutter/material.dart';

import '../notification_types.dart';

/// Dialog widget for notifications
class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key, required this.config, this.onPrimaryAction, this.onSecondaryAction});

  final NotificationConfig config;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    final color = config.getColor(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: config.getBackgroundColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(config.effectiveIcon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              config.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: config.message != null
          ? Text(
              config.message!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            )
          : null,
      actions: [
        // Secondary action (Cancel)
        if (config.secondaryActionLabel != null)
          TextButton(
            onPressed: onSecondaryAction ?? () => Navigator.of(context).pop(),
            child: Text(config.secondaryActionLabel!),
          ),
        // Primary action
        if (config.primaryActionLabel != null)
          ElevatedButton(
            onPressed: onPrimaryAction ?? () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: config.severity == NotificationSeverity.error ? Colors.red : color,
              foregroundColor: Colors.white,
            ),
            child: Text(config.primaryActionLabel!),
          )
        else
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
      ],
    );
  }
}
