import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../core/storage/preferences_service.dart';
import '../../data/models/item_model.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../data/services/item_api_service.dart';
import '../../domain/repositories/item_repository.dart';
import 'item_state.dart';

// ═══════════════════════════════════════════════════════════════════════════
// API Service Provider
// Uses shared Dio instance with all interceptors (auth, logging, error handling)
// ═══════════════════════════════════════════════════════════════════════════

final itemApiServiceProvider = Provider<ItemApiService>((ref) {
  // Gets Dio with auth interceptor, logging, and error handling
  final dio = ref.watch(dioProvider);
  
  talker.debug('Creating ItemApiService with shared Dio instance');
  return ItemApiService(dio);
});

// ═══════════════════════════════════════════════════════════════════════════
// Repository Provider
// ═══════════════════════════════════════════════════════════════════════════

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final apiService = ref.watch(itemApiServiceProvider);
  return ItemRepositoryImpl(apiService);
});

// ═══════════════════════════════════════════════════════════════════════════
// Item List State Notifier
// Manages the list of items with CRUD operations
// ═══════════════════════════════════════════════════════════════════════════

class ItemListNotifier extends StateNotifier<ItemListState> {
  final ItemRepository _repository;
  final PreferencesService _preferences;

  ItemListNotifier(this._repository, this._preferences) : super(const ItemListState()) {
    talker.debug('ItemListNotifier created');
  }

  /// Load items (initial load or refresh)
  Future<void> loadItems({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;

    talker.info('🔄 Loading items (refresh: $refresh)');

    state = state.copyWith(isLoading: true, error: null, currentPage: refresh ? 1 : state.currentPage);

    try {
      final items = await _repository.getItems(page: state.currentPage, limit: 20, search: state.searchQuery);

      state = state.copyWith(items: items, isLoading: false, hasMore: items.length >= 20);

      // Example: Save last fetch time to preferences
      await _preferences.setLastFetchTime(DateTime.now());

      talker.good('✅ Items loaded: ${items.length}');
    } catch (e) {
      final errorMessage = _getErrorMessage(e);
      state = state.copyWith(isLoading: false, error: errorMessage);
      talker.error('❌ Failed to load items: $errorMessage', e);
    }
  }

  /// Load more items (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    talker.info('📥 Loading more items (page: ${state.currentPage + 1})');

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final items = await _repository.getItems(page: nextPage, limit: 20, search: state.searchQuery);

      state = state.copyWith(
        items: [...state.items, ...items],
        isLoadingMore: false,
        currentPage: nextPage,
        hasMore: items.length >= 20,
      );

      talker.good('✅ Loaded ${items.length} more items');
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: _getErrorMessage(e));
      talker.error('❌ Failed to load more items', e);
    }
  }

  /// Search items
  Future<void> searchItems(String query) async {
    talker.info('🔍 Searching items: "$query"');

    state = state.copyWith(searchQuery: query.isEmpty ? null : query, currentPage: 1);

    await loadItems(refresh: true);
  }

  /// Delete item from list
  Future<bool> deleteItem(int id) async {
    talker.info('🗑️ Deleting item: $id');

    try {
      await _repository.deleteItem(id);
      state = state.copyWith(items: state.items.where((item) => item.id != id).toList());
      talker.good('✅ Item deleted from list: $id');
      return true;
    } catch (e) {
      talker.error('❌ Failed to delete item', e);
      return false;
    }
  }

  /// Add item to list (after create)
  void addItem(ItemModel item) {
    talker.debug('➕ Adding item to list: ${item.id}');
    state = state.copyWith(items: [item, ...state.items]);
  }

  /// Update item in list
  void updateItemInList(ItemModel updatedItem) {
    talker.debug('🔄 Updating item in list: ${updatedItem.id}');
    state = state.copyWith(
      items: state.items.map((item) {
        return item.id == updatedItem.id ? updatedItem : item;
      }).toList(),
    );
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Get error message from exception
  String _getErrorMessage(dynamic error) {
    if (error is DioException && error.error is ApiException) {
      return (error.error as ApiException).message;
    }
    return 'خطای نامشخص رخ داد';
  }
}

final itemListProvider = StateNotifierProvider<ItemListNotifier, ItemListState>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  final preferences = ref.watch(preferencesServiceProvider);
  return ItemListNotifier(repository, preferences);
});

// ═══════════════════════════════════════════════════════════════════════════
// Item Detail State Notifier
// Manages single item operations (view, create, update, delete)
// ═══════════════════════════════════════════════════════════════════════════

class ItemDetailNotifier extends StateNotifier<ItemDetailState> {
  final ItemRepository _repository;
  final Ref _ref;

  ItemDetailNotifier(this._repository, this._ref) : super(const ItemDetailState()) {
    talker.debug('ItemDetailNotifier created');
  }

  /// Load single item
  Future<void> loadItem(int id) async {
    talker.info('📥 Loading item: $id');

    state = state.copyWith(isLoading: true, error: null);

    try {
      final item = await _repository.getItem(id);
      state = state.copyWith(item: item, isLoading: false);
      talker.good('✅ Item loaded: ${item.title}');
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _getErrorMessage(e));
      talker.error('❌ Failed to load item', e);
    }
  }

  /// Create new item
  Future<ItemModel?> createItem(ItemRequest request) async {
    talker.info('📤 Creating item: ${request.title}');

    state = state.copyWith(isSaving: true, error: null);

    try {
      final item = await _repository.createItem(request);
      state = state.copyWith(item: item, isSaving: false, successMessage: 'آیتم با موفقیت ایجاد شد');

      // Update list provider
      _ref.read(itemListProvider.notifier).addItem(item);

      talker.good('✅ Item created: ${item.id}');
      return item;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: _getErrorMessage(e));
      talker.error('❌ Failed to create item', e);
      return null;
    }
  }

  /// Update existing item
  Future<ItemModel?> updateItem(int id, ItemRequest request) async {
    talker.info('📤 Updating item: $id');

    state = state.copyWith(isSaving: true, error: null);

    try {
      final item = await _repository.updateItem(id, request);
      state = state.copyWith(item: item, isSaving: false, successMessage: 'آیتم با موفقیت به‌روزرسانی شد');

      // Update list provider
      _ref.read(itemListProvider.notifier).updateItemInList(item);

      talker.good('✅ Item updated: ${item.id}');
      return item;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: _getErrorMessage(e));
      talker.error('❌ Failed to update item', e);
      return null;
    }
  }

  /// Delete item
  Future<bool> deleteItem(int id) async {
    talker.info('🗑️ Deleting item: $id');

    state = state.copyWith(isDeleting: true, error: null);

    try {
      await _repository.deleteItem(id);
      state = state.copyWith(isDeleting: false, successMessage: 'آیتم با موفقیت حذف شد');

      // Update list provider
      _ref.read(itemListProvider.notifier).deleteItem(id);

      talker.good('✅ Item deleted: $id');
      return true;
    } catch (e) {
      state = state.copyWith(isDeleting: false, error: _getErrorMessage(e));
      talker.error('❌ Failed to delete item', e);
      return false;
    }
  }

  /// Set item directly (for local updates)
  void setItem(ItemModel item) {
    state = state.copyWith(item: item);
  }

  /// Clear state
  void clear() {
    talker.debug('Clearing ItemDetailNotifier state');
    state = const ItemDetailState();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Clear success message
  void clearSuccessMessage() {
    state = state.copyWith(successMessage: null);
  }

  String _getErrorMessage(dynamic error) {
    if (error is DioException && error.error is ApiException) {
      return (error.error as ApiException).message;
    }
    return 'خطای نامشخص رخ داد';
  }
}

final itemDetailProvider = StateNotifierProvider<ItemDetailNotifier, ItemDetailState>((ref) {
  final repository = ref.watch(itemRepositoryProvider);
  return ItemDetailNotifier(repository, ref);
});

// ═══════════════════════════════════════════════════════════════════════════
// Convenience Providers
// ═══════════════════════════════════════════════════════════════════════════

/// Watch single item by ID from the list
final itemByIdProvider = Provider.family<ItemModel?, int>((ref, id) {
  final items = ref.watch(itemListProvider).items;
  try {
    return items.firstWhere((item) => item.id == id);
  } catch (_) {
    return null;
  }
});

/// Watch loading state for items list
final isItemsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(itemListProvider).isLoading;
});

/// Watch error state for items list
final itemsErrorProvider = Provider<String?>((ref) {
  return ref.watch(itemListProvider).error;
});

/// Watch items count
final itemsCountProvider = Provider<int>((ref) {
  return ref.watch(itemListProvider).items.length;
});

// ═══════════════════════════════════════════════════════════════════════════
// Extended PreferencesService for feature-specific data
// ═══════════════════════════════════════════════════════════════════════════

extension ItemPreferencesExtension on PreferencesService {
  static const _lastFetchTimeKey = 'items_last_fetch_time';
  static const _lastViewedItemKey = 'items_last_viewed_id';

  Future<void> setLastFetchTime(DateTime time) async {
    await setString(_lastFetchTimeKey, time.toIso8601String());
    talker.debug('📦 Saved last fetch time: $time');
  }

  DateTime? getLastFetchTime() {
    final value = getString(_lastFetchTimeKey);
    if (value != null) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  Future<void> setLastViewedItemId(int id) async {
    await setInt(_lastViewedItemKey, id);
    talker.debug('📦 Saved last viewed item: $id');
  }

  int? getLastViewedItemId() {
    return getInt(_lastViewedItemKey);
  }
}
