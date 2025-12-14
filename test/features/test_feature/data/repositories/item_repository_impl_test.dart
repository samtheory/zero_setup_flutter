import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';
import 'package:zero_setup_flutter/features/test_feature/data/repositories/item_repository_impl.dart';
import 'package:zero_setup_flutter/features/test_feature/data/services/item_api_service.dart';

// Mock
class MockItemApiService extends Mock implements ItemApiService {}

void main() {
  late MockItemApiService mockApiService;
  late ItemRepositoryImpl repository;

  setUp(() {
    mockApiService = MockItemApiService();
    repository = ItemRepositoryImpl(mockApiService);
  });

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(const ItemRequest(
      title: 'Fallback',
      description: 'Fallback Description',
    ));
  });

  group('ItemRepositoryImpl', () {
    group('getItems', () {
      test('returns items on success', () async {
        final items = [
          ItemModel.fake(id: 1),
          ItemModel.fake(id: 2),
        ];

        when(() => mockApiService.getItems(
              page: any(named: 'page'),
              limit: any(named: 'limit'),
              search: any(named: 'search'),
            )).thenAnswer((_) async => items);

        final result = await repository.getItems();

        expect(result, items);
        verify(() => mockApiService.getItems()).called(1);
      });

      test('passes pagination parameters', () async {
        when(() => mockApiService.getItems(
              page: any(named: 'page'),
              limit: any(named: 'limit'),
              search: any(named: 'search'),
            )).thenAnswer((_) async => []);

        await repository.getItems(page: 2, limit: 10, search: 'test');

        verify(() => mockApiService.getItems(
              page: 2,
              limit: 10,
              search: 'test',
            )).called(1);
      });

      test('rethrows exceptions', () async {
        when(() => mockApiService.getItems(
              page: any(named: 'page'),
              limit: any(named: 'limit'),
              search: any(named: 'search'),
            )).thenThrow(Exception('Network error'));

        expect(
          () => repository.getItems(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getItem', () {
      test('returns item on success', () async {
        final item = ItemModel.fake(id: 1);

        when(() => mockApiService.getItem(1))
            .thenAnswer((_) async => item);

        final result = await repository.getItem(1);

        expect(result, item);
        verify(() => mockApiService.getItem(1)).called(1);
      });

      test('rethrows exceptions', () async {
        when(() => mockApiService.getItem(1))
            .thenThrow(Exception('Not found'));

        expect(
          () => repository.getItem(1),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('createItem', () {
      test('creates and returns item', () async {
        const request = ItemRequest(
          title: 'New Item',
          description: 'Description',
        );
        final createdItem = ItemModel.fake(id: 1, title: 'New Item');

        when(() => mockApiService.createItem(request))
            .thenAnswer((_) async => createdItem);

        final result = await repository.createItem(request);

        expect(result, createdItem);
        verify(() => mockApiService.createItem(request)).called(1);
      });

      test('rethrows exceptions', () async {
        const request = ItemRequest(
          title: 'New',
          description: 'Desc',
        );

        when(() => mockApiService.createItem(any()))
            .thenThrow(Exception('Server error'));

        expect(
          () => repository.createItem(request),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('updateItem', () {
      test('updates and returns item', () async {
        const request = ItemRequest(
          title: 'Updated',
          description: 'Updated Description',
        );
        final updatedItem = ItemModel.fake(id: 1, title: 'Updated');

        when(() => mockApiService.updateItem(1, request))
            .thenAnswer((_) async => updatedItem);

        final result = await repository.updateItem(1, request);

        expect(result, updatedItem);
        verify(() => mockApiService.updateItem(1, request)).called(1);
      });

      test('rethrows exceptions', () async {
        const request = ItemRequest(
          title: 'Updated',
          description: 'Desc',
        );

        when(() => mockApiService.updateItem(any(), any()))
            .thenThrow(Exception('Not found'));

        expect(
          () => repository.updateItem(1, request),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('deleteItem', () {
      test('deletes item successfully', () async {
        when(() => mockApiService.deleteItem(1))
            .thenAnswer((_) async {});

        await repository.deleteItem(1);

        verify(() => mockApiService.deleteItem(1)).called(1);
      });

      test('rethrows exceptions', () async {
        when(() => mockApiService.deleteItem(1))
            .thenThrow(Exception('Not found'));

        expect(
          () => repository.deleteItem(1),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
