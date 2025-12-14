# 🚀 Feature Implementation Guide - Quick Start

## Overview

This guide shows you how to implement a **complete feature** in your Flutter project with:
- ✅ Retrofit API service (using shared Dio instance)
- ✅ Riverpod state management (CRUD operations)
- ✅ Storage (read/write data)
- ✅ Navigation between screens
- ✅ Logging with Talker
- ✅ Form validation with Acanthis
- ✅ Error handling

---

## 📁 Feature Folder Structure

Every feature follows this standardized structure:

```
lib/features/your_feature/
├── data/
│   ├── models/              # Freezed data models
│   │   └── item_model.dart
│   ├── repositories/        # Repository implementations
│   │   └── item_repository_impl.dart
│   └── services/            # Retrofit API services
│       └── item_api_service.dart
├── domain/
│   ├── entities/            # Domain entities (optional)
│   │   └── item.dart
│   ├── repositories/        # Abstract repository interfaces
│   │   └── item_repository.dart
│   └── usecases/            # Business logic (optional)
│       └── get_items_usecase.dart
└── presentation/
    ├── providers/           # Riverpod providers
    │   ├── item_provider.dart
    │   └── item_state.dart
    ├── screens/             # UI screens
    │   ├── item_list_screen.dart
    │   ├── item_detail_screen.dart
    │   └── item_form_screen.dart
    └── widgets/             # Feature-specific widgets
        └── item_card.dart
```

---

## 📝 Step-by-Step Implementation

### Step 1: Create the Data Model (Freezed)

**File:** `data/models/item_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}

/// Request model for creating/updating items
@freezed
class ItemRequest with _$ItemRequest {
  const factory ItemRequest({
    required String title,
    required String description,
    @Default(false) bool isCompleted,
  }) = _ItemRequest;

  factory ItemRequest.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestFromJson(json);
}

/// Response wrapper for paginated data
@freezed
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required List<T> data,
    required int total,
    required int page,
    required int perPage,
  }) = _PaginatedResponse;
}
```

### Step 2: Create API Service (Retrofit)

**File:** `data/services/item_api_service.dart`

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/item_model.dart';

part 'item_api_service.g.dart';

/// Retrofit API service for items
/// Uses Dio instance from Riverpod provider
@RestApi()
abstract class ItemApiService {
  factory ItemApiService(Dio dio, {String baseUrl}) = _ItemApiService;

  /// Get all items with optional pagination
  @GET('/items')
  Future<List<ItemModel>> getItems({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('search') String? search,
  });

  /// Get single item by ID
  @GET('/items/{id}')
  Future<ItemModel> getItem(@Path('id') int id);

  /// Create new item
  @POST('/items')
  Future<ItemModel> createItem(@Body() ItemRequest request);

  /// Update existing item
  @PUT('/items/{id}')
  Future<ItemModel> updateItem(
    @Path('id') int id,
    @Body() ItemRequest request,
  );

  /// Partial update
  @PATCH('/items/{id}')
  Future<ItemModel> patchItem(
    @Path('id') int id,
    @Body() Map<String, dynamic> data,
  );

  /// Delete item
  @DELETE('/items/{id}')
  Future<void> deleteItem(@Path('id') int id);
}
```

### Step 3: Create Repository Interface

**File:** `domain/repositories/item_repository.dart`

```dart
import '../../data/models/item_model.dart';

/// Abstract repository interface for items
/// This allows easy mocking for tests
abstract class ItemRepository {
  Future<List<ItemModel>> getItems({int? page, int? limit, String? search});
  Future<ItemModel> getItem(int id);
  Future<ItemModel> createItem(ItemRequest request);
  Future<ItemModel> updateItem(int id, ItemRequest request);
  Future<void> deleteItem(int id);
}
```

### Step 4: Implement Repository

**File:** `data/repositories/item_repository_impl.dart`

```dart
import '../../../../core/logger/app_logger.dart';
import '../../../../core/network/api_exception.dart';
import '../../domain/repositories/item_repository.dart';
import '../models/item_model.dart';
import '../services/item_api_service.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemApiService _apiService;

  ItemRepositoryImpl(this._apiService);

  @override
  Future<List<ItemModel>> getItems({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      talker.info('Fetching items: page=$page, limit=$limit');
      final items = await _apiService.getItems(
        page: page,
        limit: limit,
        search: search,
      );
      talker.good('Fetched ${items.length} items');
      return items;
    } catch (e) {
      talker.error('Failed to fetch items', e);
      rethrow;
    }
  }

  @override
  Future<ItemModel> getItem(int id) async {
    try {
      talker.info('Fetching item: $id');
      final item = await _apiService.getItem(id);
      talker.good('Fetched item: ${item.title}');
      return item;
    } catch (e) {
      talker.error('Failed to fetch item $id', e);
      rethrow;
    }
  }

  @override
  Future<ItemModel> createItem(ItemRequest request) async {
    try {
      talker.info('Creating item: ${request.title}');
      final item = await _apiService.createItem(request);
      talker.good('Created item: ${item.id}');
      return item;
    } catch (e) {
      talker.error('Failed to create item', e);
      rethrow;
    }
  }

  @override
  Future<ItemModel> updateItem(int id, ItemRequest request) async {
    try {
      talker.info('Updating item: $id');
      final item = await _apiService.updateItem(id, request);
      talker.good('Updated item: ${item.title}');
      return item;
    } catch (e) {
      talker.error('Failed to update item $id', e);
      rethrow;
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      talker.info('Deleting item: $id');
      await _apiService.deleteItem(id);
      talker.good('Deleted item: $id');
    } catch (e) {
      talker.error('Failed to delete item $id', e);
      rethrow;
    }
  }
}
```

### Step 5: Create State Class

**File:** `presentation/providers/item_state.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/item_model.dart';

part 'item_state.freezed.dart';

@freezed
class ItemListState with _$ItemListState {
  const factory ItemListState({
    @Default([]) List<ItemModel> items,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
  }) = _ItemListState;

  const ItemListState._();

  bool get isEmpty => items.isEmpty && !isLoading;
  bool get hasError => error != null;
}

@freezed
class ItemDetailState with _$ItemDetailState {
  const factory ItemDetailState({
    ItemModel? item,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isDeleting,
    String? error,
  }) = _ItemDetailState;
}
```

### Step 6: Create Riverpod Providers

**File:** `presentation/providers/item_provider.dart`

```dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
// API Service Provider (uses shared Dio with all interceptors)
// ═══════════════════════════════════════════════════════════════════════════

final itemApiServiceProvider = Provider<ItemApiService>((ref) {
  final dio = ref.watch(dioProvider);  // Gets Dio with auth, logging, error handling
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
// ═══════════════════════════════════════════════════════════════════════════

class ItemListNotifier extends StateNotifier<ItemListState> {
  final ItemRepository _repository;
  final PreferencesService _preferences;

  ItemListNotifier(this._repository, this._preferences) : super(const ItemListState());

  /// Load items (initial load or refresh)
  Future<void> loadItems({bool refresh = false}) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: refresh ? 1 : state.currentPage,
    );

    try {
      final items = await _repository.getItems(
        page: state.currentPage,
        limit: 20,
      );

      state = state.copyWith(
        items: items,
        isLoading: false,
        hasMore: items.length >= 20,
      );

      // Save to preferences for offline cache
      talker.info('Items loaded: ${items.length}');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _getErrorMessage(e),
      );
      talker.error('Failed to load items', e);
    }
  }

  /// Load more items (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final items = await _repository.getItems(page: nextPage, limit: 20);

      state = state.copyWith(
        items: [...state.items, ...items],
        isLoadingMore: false,
        currentPage: nextPage,
        hasMore: items.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: _getErrorMessage(e),
      );
    }
  }

  /// Delete item from list
  Future<bool> deleteItem(int id) async {
    try {
      await _repository.deleteItem(id);
      state = state.copyWith(
        items: state.items.where((item) => item.id != id).toList(),
      );
      talker.good('Item deleted from list: $id');
      return true;
    } catch (e) {
      talker.error('Failed to delete item', e);
      return false;
    }
  }

  /// Add item to list (after create)
  void addItem(ItemModel item) {
    state = state.copyWith(items: [item, ...state.items]);
  }

  /// Update item in list
  void updateItemInList(ItemModel updatedItem) {
    state = state.copyWith(
      items: state.items.map((item) {
        return item.id == updatedItem.id ? updatedItem : item;
      }).toList(),
    );
  }

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
// ═══════════════════════════════════════════════════════════════════════════

class ItemDetailNotifier extends StateNotifier<ItemDetailState> {
  final ItemRepository _repository;
  final Ref _ref;

  ItemDetailNotifier(this._repository, this._ref) : super(const ItemDetailState());

  /// Load single item
  Future<void> loadItem(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final item = await _repository.getItem(id);
      state = state.copyWith(item: item, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _getErrorMessage(e),
      );
    }
  }

  /// Create new item
  Future<ItemModel?> createItem(ItemRequest request) async {
    state = state.copyWith(isSaving: true, error: null);

    try {
      final item = await _repository.createItem(request);
      state = state.copyWith(item: item, isSaving: false);

      // Update list provider
      _ref.read(itemListProvider.notifier).addItem(item);

      talker.good('Item created: ${item.id}');
      return item;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: _getErrorMessage(e),
      );
      talker.error('Failed to create item', e);
      return null;
    }
  }

  /// Update existing item
  Future<ItemModel?> updateItem(int id, ItemRequest request) async {
    state = state.copyWith(isSaving: true, error: null);

    try {
      final item = await _repository.updateItem(id, request);
      state = state.copyWith(item: item, isSaving: false);

      // Update list provider
      _ref.read(itemListProvider.notifier).updateItemInList(item);

      talker.good('Item updated: ${item.id}');
      return item;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: _getErrorMessage(e),
      );
      talker.error('Failed to update item', e);
      return null;
    }
  }

  /// Delete item
  Future<bool> deleteItem(int id) async {
    state = state.copyWith(isDeleting: true, error: null);

    try {
      await _repository.deleteItem(id);
      state = state.copyWith(isDeleting: false);

      // Update list provider
      _ref.read(itemListProvider.notifier).deleteItem(id);

      talker.good('Item deleted: $id');
      return true;
    } catch (e) {
      state = state.copyWith(
        isDeleting: false,
        error: _getErrorMessage(e),
      );
      talker.error('Failed to delete item', e);
      return false;
    }
  }

  /// Clear state
  void clear() {
    state = const ItemDetailState();
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

/// Watch single item by ID from list
final itemByIdProvider = Provider.family<ItemModel?, int>((ref, id) {
  final items = ref.watch(itemListProvider).items;
  try {
    return items.firstWhere((item) => item.id == id);
  } catch (_) {
    return null;
  }
});

/// Watch loading state
final isItemsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(itemListProvider).isLoading;
});
```

### Step 7: Create List Screen with Navigation

**File:** `presentation/screens/item_list_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../app/router/routes.dart';
import '../../data/models/item_model.dart';
import '../providers/item_provider.dart';
import '../widgets/item_card.dart';

class ItemListScreen extends HookConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemListProvider);
    final scrollController = useScrollController();

    // Load items on first build
    useEffect(() {
      talker.info('ItemListScreen mounted');
      ref.read(itemListProvider.notifier).loadItems();
      return () => talker.info('ItemListScreen disposed');
    }, []);

    // Pagination scroll listener
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
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
          // Navigate to Talker logs screen
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              talker.info('Opening debug logs');
              // Navigate to debug screen
            },
          ),
        ],
      ),
      body: _buildBody(context, ref, state, scrollController),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          talker.info('Navigating to create item');
          context.push(Routes.testFeatureForm);  // Navigate to form
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    ItemListState state,
    ScrollController scrollController,
  ) {
    // Loading state
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state
    if (state.hasError && state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.error ?? 'خطا در بارگذاری'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(itemListProvider.notifier).loadItems(),
              child: const Text('تلاش مجدد'),
            ),
          ],
        ),
      );
    }

    // Empty state
    if (state.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('آیتمی یافت نشد'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push(Routes.testFeatureForm),
              child: const Text('ایجاد آیتم جدید'),
            ),
          ],
        ),
      );
    }

    // List with pull-to-refresh
    return RefreshIndicator(
      onRefresh: () async {
        talker.info('Refreshing items');
        await ref.read(itemListProvider.notifier).loadItems(refresh: true);
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Loading more indicator
          if (index >= state.items.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final item = state.items[index];
          return ItemCard(
            item: item,
            onTap: () {
              talker.info('Navigating to item detail: ${item.id}');
              context.push('${Routes.testFeatureDetail}/${item.id}');
            },
            onDelete: () => _showDeleteDialog(context, ref, item),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, ItemModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف آیتم'),
        content: Text('آیا از حذف "${item.title}" مطمئن هستید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              talker.info('Deleting item: ${item.id}');
              final success = await ref.read(itemListProvider.notifier).deleteItem(item.id);
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('آیتم حذف شد')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
```

### Step 8: Create Form Screen with Acanthis Validation

**File:** `presentation/screens/item_form_screen.dart`

```dart
import 'package:acanthis/acanthis.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/models/item_model.dart';
import '../providers/item_provider.dart';

/// Item validation schema using Acanthis
class ItemFormSchema {
  static final title = string()
      .min(3, 'عنوان باید حداقل ۳ کاراکتر باشد')
      .max(100, 'عنوان نباید بیش از ۱۰۰ کاراکتر باشد');

  static final description = string()
      .min(10, 'توضیحات باید حداقل ۱۰ کاراکتر باشد')
      .max(500, 'توضیحات نباید بیش از ۵۰۰ کاراکتر باشد');

  static AcanthisParseResult<Map<String, dynamic>> validate({
    required String title,
    required String description,
  }) {
    final schema = object({
      'title': ItemFormSchema.title,
      'description': ItemFormSchema.description,
    });

    return schema.tryParse({
      'title': title,
      'description': description,
    });
  }
}

class ItemFormScreen extends HookConsumerWidget {
  const ItemFormScreen({super.key, this.itemId});

  final int? itemId;

  bool get isEditing => itemId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailProvider);

    // Form controllers
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final isCompletedState = useState(false);

    // Form key for validation
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Error states
    final titleError = useState<String?>(null);
    final descriptionError = useState<String?>(null);

    // Load item for editing
    useEffect(() {
      if (isEditing) {
        talker.info('Loading item for edit: $itemId');
        ref.read(itemDetailProvider.notifier).loadItem(itemId!);
      }
      return null;
    }, [itemId]);

    // Populate form when item loads
    useEffect(() {
      if (state.item != null) {
        titleController.text = state.item!.title;
        descriptionController.text = state.item!.description;
        isCompletedState.value = state.item!.isCompleted;
      }
      return null;
    }, [state.item]);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'ویرایش آیتم' : 'ایجاد آیتم جدید'),
      ),
      body: state.isLoading && isEditing
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title field
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'عنوان *',
                        hintText: 'عنوان آیتم را وارد کنید',
                        errorText: titleError.value,
                        border: const OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => titleError.value = null,
                    ),
                    const SizedBox(height: 16),

                    // Description field
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'توضیحات *',
                        hintText: 'توضیحات آیتم را وارد کنید',
                        errorText: descriptionError.value,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      onChanged: (_) => descriptionError.value = null,
                    ),
                    const SizedBox(height: 16),

                    // Is completed checkbox
                    CheckboxListTile(
                      title: const Text('تکمیل شده'),
                      value: isCompletedState.value,
                      onChanged: (value) => isCompletedState.value = value ?? false,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 24),

                    // Error message
                    if (state.error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.error!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),

                    // Submit button
                    ElevatedButton(
                      onPressed: state.isSaving
                          ? null
                          : () => _handleSubmit(
                                context,
                                ref,
                                titleController.text,
                                descriptionController.text,
                                isCompletedState.value,
                                titleError,
                                descriptionError,
                              ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state.isSaving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(isEditing ? 'ذخیره تغییرات' : 'ایجاد آیتم'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    String title,
    String description,
    bool isCompleted,
    ValueNotifier<String?> titleError,
    ValueNotifier<String?> descriptionError,
  ) async {
    // Validate with Acanthis
    final validation = ItemFormSchema.validate(
      title: title.trim(),
      description: description.trim(),
    );

    if (!validation.success) {
      // Extract field errors
      final errors = validation.errors;
      for (final error in errors) {
        if (error.key == 'title') {
          titleError.value = error.message;
        } else if (error.key == 'description') {
          descriptionError.value = error.message;
        }
      }
      talker.warning('Form validation failed', validation.errors);
      return;
    }

    talker.info('Form validation passed');

    final request = ItemRequest(
      title: title.trim(),
      description: description.trim(),
      isCompleted: isCompleted,
    );

    final notifier = ref.read(itemDetailProvider.notifier);
    ItemModel? result;

    if (isEditing) {
      result = await notifier.updateItem(itemId!, request);
    } else {
      result = await notifier.createItem(request);
    }

    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEditing ? 'آیتم به‌روزرسانی شد' : 'آیتم ایجاد شد'),
        ),
      );
      context.pop();  // Navigate back
    }
  }
}
```

### Step 9: Create Item Card Widget

**File:** `presentation/widgets/item_card.dart`

```dart
import 'package:flutter/material.dart';

import '../../data/models/item_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    this.onTap,
    this.onDelete,
  });

  final ItemModel item;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Status indicator
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item.isCompleted
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item.isCompleted ? Icons.check : Icons.pending,
                  color: item.isCompleted ? Colors.green : Colors.orange,
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        decoration: item.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Delete button
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Step 10: Add Routes

**File:** `lib/app/router/routes.dart` (update)

```dart
abstract class Routes {
  // Existing routes...
  static const login = '/login';
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';

  // Test Feature routes
  static const testFeature = '/test-feature';
  static const testFeatureDetail = '/test-feature/detail';
  static const testFeatureForm = '/test-feature/form';
}
```

---

## 📦 Storage Usage Examples

### Save Data to Preferences
```dart
final prefs = ref.read(preferencesServiceProvider);
await prefs.setString('last_viewed_item', '123');
```

### Read Data from Preferences
```dart
final prefs = ref.read(preferencesServiceProvider);
final lastItem = prefs.getString('last_viewed_item');
```

### Save Secure Data
```dart
final secure = ref.read(secureStorageProvider);
await secure.saveAccessToken('jwt_token_here');
```

### Read Secure Data
```dart
final secure = ref.read(secureStorageProvider);
final token = await secure.getAccessToken();
```

---

## 📝 Logging Examples

```dart
import '../../core/logger/app_logger.dart';

// Info log
talker.info('User opened item list');

// Success log
talker.good('Item created successfully');

// Warning log
talker.warning('Network is slow');

// Error log
talker.error('Failed to load items', exception);

// Debug log (only in debug mode)
talker.debug('Current state: $state');

// Verbose log
talker.verbose('API response: $data');
```

---

## 🧭 Navigation Examples

```dart
import 'package:go_router/go_router.dart';
import '../../app/router/routes.dart';

// Navigate to new screen
context.go(Routes.testFeature);

// Push to stack (can go back)
context.push(Routes.testFeatureForm);

// Navigate with parameters
context.push('${Routes.testFeatureDetail}/123');

// Go back
context.pop();

// Replace current screen
context.replace(Routes.home);
```

---

## ⚠️ Error Handling

All errors are handled automatically by:
1. **ErrorInterceptor** - Converts Dio errors to `ApiException`
2. **TalkerDioLogger** - Logs all requests/responses
3. **Repository** - Logs and rethrows errors
4. **StateNotifier** - Catches errors and updates state

```dart
try {
  await repository.createItem(request);
} catch (e) {
  if (e is DioException && e.error is ApiException) {
    final apiError = e.error as ApiException;
    // Handle specific error types
    switch (apiError.type) {
      case ApiExceptionType.unauthorized:
        // Redirect to login
        break;
      case ApiExceptionType.validation:
        // Show validation errors
        break;
      default:
        // Show generic error
    }
  }
}
```

---

## ✅ Checklist for New Features

- [ ] Create folder structure (`data/`, `domain/`, `presentation/`)
- [ ] Define Freezed models
- [ ] Create Retrofit API service
- [ ] Define repository interface
- [ ] Implement repository
- [ ] Create state class (Freezed)
- [ ] Create Riverpod providers
- [ ] Build screens with navigation
- [ ] Add form validation (Acanthis)
- [ ] Add routes to router
- [ ] Add logging throughout
- [ ] Write unit tests
- [ ] Write widget tests

---

## 🏃 Generate Code

After creating files, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `.freezed.dart` files
- `.g.dart` files (JSON serialization)
- Retrofit client implementation
