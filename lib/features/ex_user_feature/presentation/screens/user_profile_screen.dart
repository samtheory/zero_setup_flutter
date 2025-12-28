import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/models/user_model.dart';
import '../providers/user_provider.dart';
import '../providers/user_state.dart';

/// User Profile Screen
///
/// Demonstrates AsyncNotifier pattern:
/// - Auto-loads user data when watched (no useEffect needed!)
/// - Uses AsyncValue.when() for clean loading/error/data handling
/// - Actions still available via notifier
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<UserState> - auto-loads on first watch!
    final asyncState = ref.watch(userProvider);
    final notifier = ref.read(userProvider.notifier);

    talker.debug('UserProfileScreen: rebuild - ${asyncState.runtimeType}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          // Logout button - only show when we have data
          asyncState.maybeWhen(
            data: (state) => IconButton(
              onPressed: state.isLoggingOut ? null : () => _showLogoutDialog(context, notifier),
              icon: state.isLoggingOut
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.logout),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: _buildBody(context, ref, asyncState, notifier),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, AsyncValue<UserState> asyncState, UserNotifier notifier) {
    // AsyncValue.when() handles all 3 states cleanly
    return asyncState.when(
      // ═══════════════════════════════════════════════════════════════════════
      // LOADING STATE (auto-triggered on first watch)
      // ═══════════════════════════════════════════════════════════════════════
      loading: () => const Center(child: CircularProgressIndicator()),

      // ═══════════════════════════════════════════════════════════════════════
      // ERROR STATE (failed to load)
      // ═══════════════════════════════════════════════════════════════════════
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(error.toString()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(userProvider), // Re-trigger build()
              child: const Text('Retry'),
            ),
          ],
        ),
      ),

      // ═══════════════════════════════════════════════════════════════════════
      // DATA STATE (user loaded successfully)
      // ═══════════════════════════════════════════════════════════════════════
      data: (state) {
        final user = state.user;

        return RefreshIndicator(
          onRefresh: notifier.refresh,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Avatar
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                  child: user.avatarUrl == null
                      ? Text(user.name.substring(0, 1).toUpperCase(), style: const TextStyle(fontSize: 36))
                      : null,
                ),
              ),
              const SizedBox(height: 24),

              // User info cards
              _InfoTile(icon: Icons.person, label: 'Name', value: user.name),
              _InfoTile(icon: Icons.email, label: 'Email', value: user.email),
              if (user.phone != null) _InfoTile(icon: Icons.phone, label: 'Phone', value: user.phone!),

              const SizedBox(height: 24),

              // Edit button
              ElevatedButton.icon(
                onPressed: state.isUpdating ? null : () => _showEditDialog(context, ref, user),
                icon: const Icon(Icons.edit),
                label: state.isUpdating
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Edit Profile'),
              ),

              // Action error message (update/logout failures)
              if (state.hasActionError) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(state.actionError!, style: TextStyle(color: Colors.redAccent)),
                      ),
                      IconButton(icon: const Icon(Icons.close, size: 18), onPressed: notifier.clearActionError),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, UserNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.logout();
              if (success && context.mounted) {
                context.go('/login'); // Navigate to login after logout
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final phoneController = TextEditingController(text: user.phone ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final request = UpdateUserRequest(
                name: nameController.text.trim(),
                phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
              );

              Navigator.pop(context);
              final success = await ref.read(userProvider.notifier).updateProfile(request);

              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

/// Simple info tile widget
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(leading: Icon(icon), title: Text(label), subtitle: Text(value)),
    );
  }
}
