import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:mocktail/mocktail.dart';

import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';
import 'package:zero_setup_flutter/features/test_feature/domain/repositories/item_repository.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_provider.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_state.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/screens/item_list_screen.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/widgets/item_card.dart';
import 'package:zero_setup_flutter/core/storage/preferences_service.dart';

// Mocks
class MockItemRepository extends Mock implements ItemRepository {}

class MockPreferencesService extends Mock implements PreferencesService {}

// Mock notifier for testing
class TestItemListNotifier extends StateNotifier<ItemListState>
    implements ItemListNotifier {
  TestItemListNotifier(super.state);

  @override
  Future<void> loadItems({bool refresh = false}) async {}

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> searchItems(String query) async {}

  @override
  Future<bool> deleteItem(int id) async => true;

  @override
  void addItem(ItemModel item) {}

  @override
  void updateItemInList(ItemModel updatedItem) {}

  @override
  void clearError() {}
}

void main() {
  late TestItemListNotifier testNotifier;

  setUp(() {
    testNotifier = TestItemListNotifier(const ItemListState());
  });

  Widget createTestWidget({ItemListState? initialState}) {
    if (initialState != null) {
      testNotifier = TestItemListNotifier(initialState);
    }

    return ProviderScope(
      overrides: [
        itemListProvider.overrideWith((ref) => testNotifier),
      ],
      child: MaterialApp(
        home: const ItemListScreen(),
      ),
    );
  }

  group('ItemListScreen', () {
    testWidgets('shows loading shimmer when loading with empty items',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          initialState: const ItemListState(isLoading: true, items: []),
        ),
      );

      expect(find.byType(ItemCardShimmer), findsWidgets);
    });

    testWidgets('shows items when loaded', (tester) async {
      final items = [
        const ItemModel(id: 1, title: 'Item 1', description: 'Description 1'),
        const ItemModel(id: 2, title: 'Item 2', description: 'Description 2'),
      ];

      await tester.pumpWidget(
        createTestWidget(
          initialState: ItemListState(items: items),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('shows error state with retry button', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          initialState: const ItemListState(
            error: 'خطا در اتصال',
            items: [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('خطا در اتصال'), findsOneWidget);
      expect(find.text('تلاش مجدد'), findsOneWidget);
    });

    testWidgets('shows empty state when no items', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          initialState: const ItemListState(items: []),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text('آیتمی یافت نشد'), findsOneWidget);
    });

    testWidgets('has search field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('has FAB for adding new item', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('آیتم جدید'), findsOneWidget);
    });

    testWidgets('has refresh button in app bar', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('has debug logs button in app bar', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.bug_report), findsOneWidget);
    });

    testWidgets('displays app bar title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('لیست آیتم‌ها'), findsOneWidget);
    });
  });
}
