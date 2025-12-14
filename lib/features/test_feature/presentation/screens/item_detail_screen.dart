import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/models/item_model.dart';
import '../providers/item_provider.dart';
import '../providers/item_state.dart';

/// Item Detail Screen
/// Demonstrates:
/// - Loading single item by ID
/// - Using family providers
/// - Navigation with parameters
/// - Storage read/write
/// - Logging
class ItemDetailScreen extends HookConsumerWidget {
  const ItemDetailScreen({super.key, required this.itemId});

  final int itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailProvider);
    final theme = Theme.of(context);

    // Load item on mount
    useEffect(() {
      talker.info('📄 ItemDetailScreen mounted for item: $itemId');

      // Load the item
      Future.microtask(() {
        ref.read(itemDetailProvider.notifier).loadItem(itemId);
      });

      // Save last viewed item to preferences
      final prefs = ref.read(preferencesServiceProvider);
      prefs.setLastViewedItemId(itemId);

      return () {
        talker.info('📄 ItemDetailScreen disposed');
        // Clear state when leaving
        ref.read(itemDetailProvider.notifier).clear();
      };
    }, [itemId]);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.item?.title ?? 'جزئیات آیتم'),
        actions: [
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'ویرایش',
            onPressed: state.item != null
                ? () {
                    talker.info('✏️ Navigate to edit item: $itemId');
                    context.push('${Routes.testFeatureForm}?id=$itemId');
                  }
                : null,
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'حذف',
            onPressed: state.item != null ? () => _showDeleteDialog(context, ref) : null,
          ),
        ],
      ),
      body: _buildBody(context, ref, state, theme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    ItemDetailState state,
    ThemeData theme,
  ) {
    // Loading state
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state
    if (state.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
              const SizedBox(height: 16),
              Text(state.error!, style: theme.textTheme.titleMedium),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  talker.info('🔄 Retry loading item: $itemId');
                  ref.read(itemDetailProvider.notifier).loadItem(itemId);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      );
    }

    // No item found
    if (state.item == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text('آیتم یافت نشد'),
          ],
        ),
      );
    }

    final item = state.item!;

    // Item details
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status card
          Card(
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.isCompleted ? Colors.green.shade100 : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.isCompleted ? Icons.check_circle : Icons.pending,
                  color: item.isCompleted ? Colors.green : Colors.orange,
                ),
              ),
              title: Text(
                item.isCompleted ? 'تکمیل شده' : 'در انتظار',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: const Text('وضعیت'),
              trailing: Switch(
                value: item.isCompleted,
                onChanged: (value) async {
                  talker.info('🔄 Toggling completion status: $value');
                  // Update item with new status
                  final request = ItemRequest(
                    title: item.title,
                    description: item.description,
                    isCompleted: value,
                  );
                  await ref.read(itemDetailProvider.notifier).updateItem(itemId, request);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text('عنوان', style: theme.textTheme.labelLarge?.copyWith(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(item.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 24),

          // Description
          Text('توضیحات', style: theme.textTheme.labelLarge?.copyWith(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(item.description, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 24),

          // Metadata
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildMetadataRow(
                    context,
                    icon: Icons.tag,
                    label: 'شناسه',
                    value: '#${item.id}',
                  ),
                  const Divider(),
                  if (item.createdAt != null)
                    _buildMetadataRow(
                      context,
                      icon: Icons.calendar_today,
                      label: 'تاریخ ایجاد',
                      value: _formatDateTime(item.createdAt!),
                    ),
                  if (item.updatedAt != null) ...[
                    const Divider(),
                    _buildMetadataRow(
                      context,
                      icon: Icons.update,
                      label: 'آخرین بروزرسانی',
                      value: _formatDateTime(item.updatedAt!),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    talker.info('✏️ Navigate to edit from detail');
                    context.push('${Routes.testFeatureForm}?id=$itemId');
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('ویرایش'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showDeleteDialog(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.delete),
                  label: const Text('حذف'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        Text(value, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    final item = ref.read(itemDetailProvider).item;
    if (item == null) return;

    talker.info('🗑️ Showing delete confirmation from detail');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف آیتم'),
        content: Text('آیا از حذف "${item.title}" مطمئن هستید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              final success = await ref.read(itemDetailProvider.notifier).deleteItem(itemId);

              if (context.mounted) {
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('آیتم حذف شد'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.pop(); // Go back to list
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('خطا در حذف آیتم'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
