import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/domain/providers/auth_provider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🎨 Logo/Icon
              Icon(Icons.rocket_launch_rounded, size: 80, color: theme.colorScheme.primary),
              const SizedBox(height: 24),

              // 📝 Title
              Text('خوش آمدید! 👋', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),

              Text(
                'برای ورود فقط دکمه رو بزن، ما هم تظاهر می‌کنیم همه‌چی امنه 😉',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: authState.isLoading ? null : () => ref.read(authProvider.notifier).login(),
                icon: authState.isLoading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.login_rounded),
                label: Text(authState.isLoading ? 'در حال ورود...' : 'ورود (Fake Login)'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
