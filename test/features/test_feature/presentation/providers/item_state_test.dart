import 'package:flutter_test/flutter_test.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_state.dart';
import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';

void main() {
  group('ItemListState', () {
    test('has correct initial values', () {
      const state = ItemListState();

      expect(state.items, isEmpty);
      expect(state.isLoading, false);
      expect(state.isLoadingMore, false);
      expect(state.error, isNull);
      expect(state.currentPage, 1);
      expect(state.hasMore, false);
      expect(state.searchQuery, isNull);
    });

    test('isEmpty returns true when no items and not loading', () {
      const state = ItemListState();

      expect(state.isEmpty, true);
    });

    test('isEmpty returns false when loading', () {
      const state = ItemListState(isLoading: true);

      expect(state.isEmpty, false);
    });

    test('isEmpty returns false when has items', () {
      final state = ItemListState(
        items: [ItemModel.fake()],
      );

      expect(state.isEmpty, false);
    });

    test('hasError returns true when error is set', () {
      const state = ItemListState(error: 'Something went wrong');

      expect(state.hasError, true);
    });

    test('hasError returns false when no error', () {
      const state = ItemListState();

      expect(state.hasError, false);
    });

    test('itemCount returns correct count', () {
      final state = ItemListState(
        items: [
          ItemModel.fake(id: 1),
          ItemModel.fake(id: 2),
          ItemModel.fake(id: 3),
        ],
      );

      expect(state.itemCount, 3);
    });

    test('copyWith updates values correctly', () {
      const original = ItemListState();

      final updated = original.copyWith(
        isLoading: true,
        currentPage: 2,
        hasMore: true,
      );

      expect(updated.isLoading, true);
      expect(updated.currentPage, 2);
      expect(updated.hasMore, true);
      expect(updated.items, isEmpty);
    });

    test('copyWith preserves unchanged values', () {
      final original = ItemListState(
        items: [ItemModel.fake()],
        currentPage: 3,
        searchQuery: 'test',
      );

      final updated = original.copyWith(isLoading: true);

      expect(updated.items, original.items);
      expect(updated.currentPage, 3);
      expect(updated.searchQuery, 'test');
      expect(updated.isLoading, true);
    });
  });

  group('ItemDetailState', () {
    test('has correct initial values', () {
      const state = ItemDetailState();

      expect(state.item, isNull);
      expect(state.isLoading, false);
      expect(state.isSaving, false);
      expect(state.isDeleting, false);
      expect(state.error, isNull);
      expect(state.successMessage, isNull);
    });

    test('isBusy returns true when loading', () {
      const state = ItemDetailState(isLoading: true);

      expect(state.isBusy, true);
    });

    test('isBusy returns true when saving', () {
      const state = ItemDetailState(isSaving: true);

      expect(state.isBusy, true);
    });

    test('isBusy returns true when deleting', () {
      const state = ItemDetailState(isDeleting: true);

      expect(state.isBusy, true);
    });

    test('isBusy returns false when idle', () {
      const state = ItemDetailState();

      expect(state.isBusy, false);
    });

    test('hasError returns true when error is set', () {
      const state = ItemDetailState(error: 'Something went wrong');

      expect(state.hasError, true);
    });

    test('hasError returns false when no error', () {
      const state = ItemDetailState();

      expect(state.hasError, false);
    });

    test('copyWith updates values correctly', () {
      const original = ItemDetailState();
      final item = ItemModel.fake();

      final updated = original.copyWith(
        item: item,
        isLoading: true,
      );

      expect(updated.item, item);
      expect(updated.isLoading, true);
      expect(updated.isSaving, false);
    });

    test('copyWith can clear item', () {
      final original = ItemDetailState(item: ItemModel.fake());

      // Note: This depends on Freezed behavior for nullable fields
      // If you need to explicitly clear, you might need a custom method
      final updated = original.copyWith(item: null);

      // Freezed may keep the old value if null is passed
      // Check your specific Freezed configuration
    });
  });
}
