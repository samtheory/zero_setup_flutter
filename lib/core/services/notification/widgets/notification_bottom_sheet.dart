import 'package:flutter/material.dart';

import '../notification_types.dart';

/// Bottom sheet widget for notifications
class NotificationBottomSheet extends StatelessWidget {
  const NotificationBottomSheet({super.key, required this.config, this.onPrimaryAction, this.onSecondaryAction});

  final NotificationConfig config;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    final color = config.getColor(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: config.getBackgroundColor(context), shape: BoxShape.circle),
              child: Icon(config.effectiveIcon, color: color, size: 40),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              config.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // Message
            if (config.message != null) ...[
              const SizedBox(height: 8),
              Text(
                config.message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],

            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                // Secondary action
                if (config.secondaryActionLabel != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onSecondaryAction ?? () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: Text(config.secondaryActionLabel!),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],

                // Primary action
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryAction ?? () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(config.primaryActionLabel ?? 'OK'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
