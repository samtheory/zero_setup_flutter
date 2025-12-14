import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../app/router/routes.dart';
import '../../data/models/item_model.dart';
import '../providers/item_provider.dart';
import '../providers/item_state.dart';
import '../widgets/item_card.dart';

/// Item List Screen
/// Demonstrates:
/// - Loading state with Riverpod
/// - Pull-to-refresh
/// - Pagination (infinite scroll)
/// - Navigation to detail/form screens
/// - Logging with Talker
/// - Error handling
class ItemListScreen extends HookConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemListProvider);
    final scrollController = useScrollController();
    final searchController = useTextEditingController();

    // Load items on first build
    useEffect(() {
      talker.info('🏠 ItemListScreen mounted');
      Future.microtask(() {
        ref.read(itemListProvider.notifier).loadItems();
      });
      return () => talker.info('🏠 ItemListScreen disposed');
    }, []);

    // Pagination scroll listener
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
          ref.read(itemListProvider.notifier).loadMore();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست آیتم‌ها'),
        actions: [
          // Navigate to Talker debug screen
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'مشاهده لاگ‌ها',
            onPressed: () {
              talker.info('🐛 Opening debug logs screen');
              Navigator.push(context, MaterialPageRoute(builder: (_) => TalkerScreen(talker: talker)));
            },
          ),
          // Refresh
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'بروزرسانی',
            onPressed: () {
              talker.info('🔄 Manual refresh triggered');
              ref.read(itemListProvider.notifier).loadItems(refresh: true);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'جستجو...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          ref.read(itemListProvider.notifier).searchItems('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: (value) {
                talker.info('🔍 Search submitted: "$value"');
                ref.read(itemListProvider.notifier).searchItems(value);
              },
            ),
          ),

          // Items list
          Expanded(child: _buildBody(context, ref, state, scrollController)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          talker.info('➕ Navigating to create item form');
          context.push(Routes.testFeatureForm);
        },
        icon: const Icon(Icons.add),
        label: const Text('آیتم جدید'),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, ItemListState state, ScrollController scrollController) {
    // Loading state (initial load)
    if (state.isLoading && state.items.isEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) => const ItemCardShimmer(),
      );
    }

    // Error state
    if (state.hasError && state.items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
              const SizedBox(height: 16),
              Text(
                state.error ?? 'خطا در بارگذاری',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  talker.info('🔄 Retry loading items');
                  ref.read(itemListProvider.notifier).loadItems();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      );
    }

    // Empty state
    if (state.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text('آیتمی یافت نشد', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                'برای شروع یک آیتم جدید ایجاد کنید',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  talker.info('➕ Navigating to create from empty state');
                  context.push(Routes.testFeatureForm);
                },
                icon: const Icon(Icons.add),
                label: const Text('ایجاد آیتم'),
              ),
            ],
          ),
        ),
      );
    }

    // Items list with pull-to-refresh
    return RefreshIndicator(
      onRefresh: () async {
        talker.info('🔄 Pull-to-refresh triggered');
        await ref.read(itemListProvider.notifier).loadItems(refresh: true);
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Loading more indicator
          if (index >= state.items.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final item = state.items[index];
          return ItemCard(
            item: item,
            onTap: () {
              talker.info('👆 Tapped item: ${item.id}');
              context.push('${Routes.testFeatureDetail}/${item.id}');
            },
            onEdit: () {
              talker.info('✏️ Edit item: ${item.id}');
              context.push('${Routes.testFeatureForm}?id=${item.id}');
            },
            onDelete: () => _showDeleteDialog(context, ref, item),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, ItemModel item) {
    talker.info('🗑️ Showing delete confirmation for item: ${item.id}');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف آیتم'),
        content: Text('آیا از حذف "${item.title}" مطمئن هستید؟'),
        actions: [
          TextButton(
            onPressed: () {
              talker.debug('❌ Delete cancelled');
              Navigator.pop(dialogContext);
            },
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              talker.info('🗑️ Confirmed delete for item: ${item.id}');

              final success = await ref.read(itemListProvider.notifier).deleteItem(item.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? 'آیتم حذف شد' : 'خطا در حذف آیتم'),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
