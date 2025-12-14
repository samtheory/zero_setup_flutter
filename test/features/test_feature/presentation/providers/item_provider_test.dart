import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';
import 'package:zero_setup_flutter/features/test_feature/domain/repositories/item_repository.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_provider.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_state.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';

// Mocks
class MockItemRepository extends Mock implements ItemRepository {}

class MockPreferencesService extends Mock implements PreferencesService {}

void main() {
  late MockItemRepository mockRepository;
  late MockPreferencesService mockPreferences;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockItemRepository();
    mockPreferences = MockPreferencesService();

    // Setup default behavior for preferences
    when(() => mockPreferences.setString(any(), any())).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        itemRepositoryProvider.overrideWithValue(mockRepository),
        preferencesServiceProvider.overrideWithValue(mockPreferences),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ItemListNotifier', () {
    test('initial state is correct', () {
      final state = container.read(itemListProvider);

      expect(state.items, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('loadItems sets loading state', () async {
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      final notifier = container.read(itemListProvider.notifier);

      // Start loading
      final future = notifier.loadItems();

      // Check loading state is set
      expect(container.read(itemListProvider).isLoading, true);

      await future;

      // Check loading state is cleared
      expect(container.read(itemListProvider).isLoading, false);
    });

    test('loadItems populates items on success', () async {
      final items = [
        ItemModel.fake(id: 1, title: 'Item 1'),
        ItemModel.fake(id: 2, title: 'Item 2'),
      ];

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => items);

      final notifier = container.read(itemListProvider.notifier);
      await notifier.loadItems();

      final state = container.read(itemListProvider);
      expect(state.items.length, 2);
      expect(state.items[0].title, 'Item 1');
      expect(state.items[1].title, 'Item 2');
    });

    test('loadItems sets error on failure', () async {
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenThrow(Exception('Network error'));

      final notifier = container.read(itemListProvider.notifier);
      await notifier.loadItems();

      final state = container.read(itemListProvider);
      expect(state.error, isNotNull);
      expect(state.isLoading, false);
    });

    test('loadItems with refresh resets page', () async {
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      final notifier = container.read(itemListProvider.notifier);

      // First load to increment page
      await notifier.loadItems();

      // Refresh should reset page
      await notifier.loadItems(refresh: true);

      final state = container.read(itemListProvider);
      expect(state.currentPage, 1);
    });

    test('loadMore appends items', () async {
      final page1Items = [ItemModel.fake(id: 1)];
      final page2Items = [ItemModel.fake(id: 2)];

      var callCount = 0;
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async {
        callCount++;
        // Return enough items to enable "hasMore"
        return callCount == 1 
            ? List.generate(20, (i) => ItemModel.fake(id: i))
            : page2Items;
      });

      final notifier = container.read(itemListProvider.notifier);

      // First load
      await notifier.loadItems();
      expect(container.read(itemListProvider).hasMore, true);

      // Load more
      await notifier.loadMore();

      final state = container.read(itemListProvider);
      expect(state.currentPage, 2);
    });

    test('deleteItem removes item from list', () async {
      final items = [
        ItemModel.fake(id: 1),
        ItemModel.fake(id: 2),
      ];

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => items);

      when(() => mockRepository.deleteItem(1)).thenAnswer((_) async {});

      final notifier = container.read(itemListProvider.notifier);
      await notifier.loadItems();

      // Delete item
      final result = await notifier.deleteItem(1);

      expect(result, true);

      final state = container.read(itemListProvider);
      expect(state.items.length, 1);
      expect(state.items[0].id, 2);
    });

    test('addItem adds to beginning of list', () async {
      final items = [ItemModel.fake(id: 1)];
      final newItem = ItemModel.fake(id: 2, title: 'New Item');

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => items);

      final notifier = container.read(itemListProvider.notifier);
      await notifier.loadItems();

      // Add new item
      notifier.addItem(newItem);

      final state = container.read(itemListProvider);
      expect(state.items.length, 2);
      expect(state.items[0].id, 2); // New item at beginning
      expect(state.items[0].title, 'New Item');
    });

    test('updateItemInList updates existing item', () async {
      final items = [
        ItemModel.fake(id: 1, title: 'Original'),
        ItemModel.fake(id: 2),
      ];

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => items);

      final notifier = container.read(itemListProvider.notifier);
      await notifier.loadItems();

      // Update item
      final updatedItem = ItemModel.fake(id: 1, title: 'Updated');
      notifier.updateItemInList(updatedItem);

      final state = container.read(itemListProvider);
      expect(state.items[0].title, 'Updated');
    });

    test('searchItems sets query and reloads', () async {
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      final notifier = container.read(itemListProvider.notifier);
      await notifier.searchItems('test query');

      final state = container.read(itemListProvider);
      expect(state.searchQuery, 'test query');
      expect(state.currentPage, 1);
    });
  });

  group('ItemDetailNotifier', () {
    test('initial state is correct', () {
      final state = container.read(itemDetailProvider);

      expect(state.item, isNull);
      expect(state.isLoading, false);
      expect(state.isSaving, false);
      expect(state.error, isNull);
    });

    test('loadItem fetches and sets item', () async {
      final item = ItemModel.fake(id: 1);

      when(() => mockRepository.getItem(1)).thenAnswer((_) async => item);

      final notifier = container.read(itemDetailProvider.notifier);
      await notifier.loadItem(1);

      final state = container.read(itemDetailProvider);
      expect(state.item, item);
      expect(state.isLoading, false);
    });

    test('loadItem sets error on failure', () async {
      when(() => mockRepository.getItem(1))
          .thenThrow(Exception('Not found'));

      final notifier = container.read(itemDetailProvider.notifier);
      await notifier.loadItem(1);

      final state = container.read(itemDetailProvider);
      expect(state.error, isNotNull);
      expect(state.item, isNull);
    });

    test('createItem creates and returns item', () async {
      const request = ItemRequest(
        title: 'New Item',
        description: 'Description',
      );
      final createdItem = ItemModel.fake(id: 1, title: 'New Item');

      when(() => mockRepository.createItem(request))
          .thenAnswer((_) async => createdItem);

      // Also mock getItems for the list notifier
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      final notifier = container.read(itemDetailProvider.notifier);
      final result = await notifier.createItem(request);

      expect(result, isNotNull);
      expect(result!.title, 'New Item');

      final state = container.read(itemDetailProvider);
      expect(state.item, createdItem);
      expect(state.isSaving, false);
    });

    test('updateItem updates and returns item', () async {
      const request = ItemRequest(
        title: 'Updated',
        description: 'Updated Description',
      );
      final updatedItem = ItemModel.fake(id: 1, title: 'Updated');

      when(() => mockRepository.updateItem(1, request))
          .thenAnswer((_) async => updatedItem);

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      final notifier = container.read(itemDetailProvider.notifier);
      final result = await notifier.updateItem(1, request);

      expect(result, isNotNull);
      expect(result!.title, 'Updated');
    });

    test('deleteItem returns true on success', () async {
      when(() => mockRepository.deleteItem(1)).thenAnswer((_) async {});

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      final notifier = container.read(itemDetailProvider.notifier);
      final result = await notifier.deleteItem(1);

      expect(result, true);

      final state = container.read(itemDetailProvider);
      expect(state.isDeleting, false);
    });

    test('clear resets state', () async {
      final item = ItemModel.fake(id: 1);

      when(() => mockRepository.getItem(1)).thenAnswer((_) async => item);

      final notifier = container.read(itemDetailProvider.notifier);
      await notifier.loadItem(1);

      // Verify item is loaded
      expect(container.read(itemDetailProvider).item, isNotNull);

      // Clear
      notifier.clear();

      final state = container.read(itemDetailProvider);
      expect(state.item, isNull);
      expect(state.error, isNull);
      expect(state.isLoading, false);
    });
  });

  group('Convenience Providers', () {
    test('itemByIdProvider returns item from list', () async {
      final items = [
        ItemModel.fake(id: 1, title: 'Item 1'),
        ItemModel.fake(id: 2, title: 'Item 2'),
      ];

      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => items);

      await container.read(itemListProvider.notifier).loadItems();

      final item = container.read(itemByIdProvider(2));
      expect(item, isNotNull);
      expect(item!.title, 'Item 2');
    });

    test('itemByIdProvider returns null for non-existent id', () async {
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async => []);

      await container.read(itemListProvider.notifier).loadItems();

      final item = container.read(itemByIdProvider(999));
      expect(item, isNull);
    });

    test('isItemsLoadingProvider reflects loading state', () async {
      when(() => mockRepository.getItems(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            search: any(named: 'search'),
          )).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return [];
      });

      expect(container.read(isItemsLoadingProvider), false);

      final future = container.read(itemListProvider.notifier).loadItems();
      expect(container.read(isItemsLoadingProvider), true);

      await future;
      expect(container.read(isItemsLoadingProvider), false);
    });
  });
}
