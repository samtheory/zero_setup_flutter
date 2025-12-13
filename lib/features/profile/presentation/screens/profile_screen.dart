
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/domain/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧑 User Info
            CircleAvatar(
              radius: 32,
              child: Text(
                user?.name.substring(0, 1) ?? '?',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              user?.name ?? '-',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),

            Text(
              user?.email ?? '-',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const Spacer(),

            // 🚪 Logout
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: authState.isLoading
                  ? null
                  : () => ref.read(authProvider.notifier).logout(),
              icon: authState.isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout_rounded),
              label: const Text('خروج از حساب'),
            ),
          ],
        ),
      ),
    );
  }
}
