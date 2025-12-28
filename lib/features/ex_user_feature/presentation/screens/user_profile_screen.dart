import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_setup_flutter/features/ex_user_feature/presentation/providers/user_state.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/models/user_model.dart';
import '../providers/user_provider.dart';

/// User Profile Screen
///
/// Demonstrates:
/// - Loading user data on mount
/// - Displaying user info
/// - Update profile action
/// - Logout action
/// - Error handling
class UserProfileScreen extends HookConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch state (rebuilds when state changes)
    final state = ref.watch(userProvider);

    // Get notifier for actions (doesn't cause rebuilds)
    final notifier = ref.read(userProvider.notifier);

    // Load user on first build
    useEffect(() {
      talker.info('UserProfileScreen: mounted');
      notifier.loadUser();
      return () => talker.info('UserProfileScreen: disposed');
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          // Logout button
          IconButton(
            onPressed: state.isLoggingOut ? null : () => _showLogoutDialog(context, notifier),
            icon: state.isLoggingOut
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(context, ref, state, notifier),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, UserState state, UserNotifier notifier) {
    // Loading state
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state (no user)
    if (state.hasError && !state.hasUser) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.error ?? 'Error loading profile'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: notifier.loadUser, child: const Text('Retry')),
          ],
        ),
      );
    }

    // No user (shouldn't happen if logged in)
    if (!state.hasUser) {
      return const Center(child: Text('No user data'));
    }

    // User profile
    final user = state.user!;
    return RefreshIndicator(
      onRefresh: notifier.loadUser,
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

          // Error message
          if (state.hasError && state.hasUser) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(state.error!)),
                  IconButton(icon: const Icon(Icons.close, size: 18), onPressed: notifier.clearError),
                ],
              ),
            ),
          ],
        ],
      ),
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
              await notifier.logout();
              if (context.mounted) {
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
