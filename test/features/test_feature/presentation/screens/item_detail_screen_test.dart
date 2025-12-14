import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:mocktail/mocktail.dart';

import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_provider.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_state.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/screens/item_detail_screen.dart';
import 'package:zero_setup_flutter/core/providers/core_providers.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';

// Mocks
class MockPreferencesService extends Mock implements PreferencesService {}

// Test notifier for mocking state
class TestItemDetailNotifier extends StateNotifier<ItemDetailState> implements ItemDetailNotifier {
  TestItemDetailNotifier(super.state);

  @override
  Future<void> loadItem(int id) async {}

  @override
  void clear() {}

  @override
  void clearSuccessMessage() {}

  @override
  void clearError() {}

  @override
  Future<ItemModel?> createItem(ItemRequest request) async => null;

  @override
  Future<ItemModel?> updateItem(int id, ItemRequest request) async => null;

  @override
  Future<bool> deleteItem(int id) async => true;

  @override
  void setItem(ItemModel item) {}
}

void main() {
  late TestItemDetailNotifier testNotifier;
  late MockPreferencesService mockPrefs;

  setUp(() {
    testNotifier = TestItemDetailNotifier(const ItemDetailState());
    mockPrefs = MockPreferencesService();

    // Stub preferences methods
    when(() => mockPrefs.setLastViewedItemId(any())).thenAnswer((_) async {});
  });

  Widget createTestWidget({ItemDetailState? initialState, int itemId = 1}) {
    if (initialState != null) {
      testNotifier = TestItemDetailNotifier(initialState);
    }

    return ProviderScope(
      overrides: [
        itemDetailProvider.overrideWith((ref) => testNotifier),
        preferencesServiceProvider.overrideWithValue(mockPrefs),
      ],
      child: MaterialApp(home: ItemDetailScreen(itemId: itemId)),
    );
  }

  group('ItemDetailScreen', () {
    testWidgets('shows loading indicator when loading', (tester) async {
      await tester.pumpWidget(createTestWidget(initialState: const ItemDetailState(isLoading: true)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows item details when loaded', (tester) async {
      final item = const ItemModel(id: 1, title: 'Test Item', description: 'Test Description', isCompleted: false);

      await tester.pumpWidget(createTestWidget(initialState: ItemDetailState(item: item)));
      await tester.pumpAndSettle();

      expect(find.text('Test Item'), findsWidgets);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('shows error state with retry button', (tester) async {
      await tester.pumpWidget(createTestWidget(initialState: const ItemDetailState(error: 'خطا در بارگذاری')));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('خطا در بارگذاری'), findsOneWidget);
      expect(find.text('تلاش مجدد'), findsOneWidget);
    });

    testWidgets('shows not found state when item is null', (tester) async {
      await tester.pumpWidget(createTestWidget(initialState: const ItemDetailState(item: null)));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search_off), findsOneWidget);
      expect(find.text('آیتم یافت نشد'), findsOneWidget);
    });

    testWidgets('has edit button in app bar', (tester) async {
      final item = const ItemModel(id: 1, title: 'Test', description: 'Desc');

      await tester.pumpWidget(createTestWidget(initialState: ItemDetailState(item: item)));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('has delete button in app bar', (tester) async {
      final item = const ItemModel(id: 1, title: 'Test', description: 'Desc');

      await tester.pumpWidget(createTestWidget(initialState: ItemDetailState(item: item)));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('shows completion status', (tester) async {
      final completedItem = const ItemModel(id: 1, title: 'Completed Item', description: 'Desc', isCompleted: true);

      await tester.pumpWidget(createTestWidget(initialState: ItemDetailState(item: completedItem)));
      await tester.pumpAndSettle();

      expect(find.text('تکمیل شده'), findsOneWidget);
    });

    testWidgets('shows pending status for incomplete item', (tester) async {
      final incompleteItem = const ItemModel(id: 1, title: 'Incomplete Item', description: 'Desc', isCompleted: false);

      await tester.pumpWidget(createTestWidget(initialState: ItemDetailState(item: incompleteItem)));
      await tester.pumpAndSettle();

      expect(find.text('در انتظار'), findsOneWidget);
    });
  });
}
