import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';
import 'package:zero_setup_flutter/core/services/notification/notification_provider.dart';
import 'package:zero_setup_flutter/core/services/notification/notification_types.dart';

class FavScreen extends HookConsumerWidget {
  const FavScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            // Snackbar
            context.notify.show(
              NotificationConfig.bottomSheet(
                title: 'New Message',
                message: 'You have received a message from John',
                icon: Icons.message,
                primaryAction: () => talker.good('Favorites tapped'),
                primaryActionLabel: 'View',
              ),
            );
            // context.notify.showSuccess('Profile updated!');
          },
          child: const Text('Favorite Items'),
        ),
      ),
    );
  }
}
