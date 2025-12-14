import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/item_model.dart';

part 'item_state.freezed.dart';

/// State for the item list screen
@freezed
sealed class ItemListState with _$ItemListState {
  
  const factory ItemListState({
    @Default([]) List<ItemModel> items,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    String? searchQuery,
  }) = _ItemListState;

  const ItemListState._();

  /// Check if list is empty (not loading and no items)
  bool get isEmpty => items.isEmpty && !isLoading;

  /// Check if there's an error
  bool get hasError => error != null;

  /// Get item count
  int get itemCount => items.length;
}

/// State for item detail/form screen
@freezed
sealed class ItemDetailState with _$ItemDetailState {
  const factory ItemDetailState({
    ItemModel? item,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isDeleting,
    String? error,
    String? successMessage,
  }) = _ItemDetailState;

  const ItemDetailState._();

  /// Check if currently busy (any operation in progress)
  bool get isBusy => isLoading || isSaving || isDeleting;

  /// Check if there's an error
  bool get hasError => error != null;
}
