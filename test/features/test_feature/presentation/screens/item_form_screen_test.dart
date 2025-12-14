import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:mocktail/mocktail.dart';

import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_provider.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/providers/item_state.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/screens/item_form_screen.dart';

// Mocks
// Test notifier for mocking state
class TestItemDetailNotifier extends StateNotifier<ItemDetailState>
    implements ItemDetailNotifier {
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

  setUp(() {
    testNotifier = TestItemDetailNotifier(const ItemDetailState());
  });

  Widget createTestWidget({
    ItemDetailState? initialState,
    int? itemId,
  }) {
    if (initialState != null) {
      testNotifier = TestItemDetailNotifier(initialState);
    }

    return ProviderScope(
      overrides: [
        itemDetailProvider.overrideWith((ref) => testNotifier),
      ],
      child: MaterialApp(
        home: ItemFormScreen(itemId: itemId),
      ),
    );
  }

  group('ItemFormScreen', () {
    group('Create Mode', () {
      testWidgets('shows create title when itemId is null', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('ایجاد آیتم جدید'), findsOneWidget);
      });

      testWidgets('shows title input field', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('عنوان *'), findsOneWidget);
        expect(find.byIcon(Icons.title), findsOneWidget);
      });

      testWidgets('shows description input field', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('توضیحات *'), findsOneWidget);
        expect(find.byIcon(Icons.description), findsOneWidget);
      });

      testWidgets('shows submit button', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('ایجاد آیتم'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
      });

      testWidgets('has form fields that accept input', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Find text fields
        final textFields = find.byType(TextFormField);
        expect(textFields, findsAtLeastNWidgets(2));

        // Enter text in title field
        await tester.enterText(textFields.first, 'Test Title');
        expect(find.text('Test Title'), findsOneWidget);
      });
    });

    group('Edit Mode', () {
      testWidgets('shows edit title when itemId is provided', (tester) async {
        await tester.pumpWidget(createTestWidget(itemId: 1));
        await tester.pumpAndSettle();

        expect(find.text('ویرایش آیتم'), findsOneWidget);
      });

      testWidgets('shows loading indicator while loading item', (tester) async {
        await tester.pumpWidget(
          createTestWidget(
            itemId: 1,
            initialState: const ItemDetailState(isLoading: true),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('populates form with existing item data', (tester) async {
        final item = const ItemModel(
          id: 1,
          title: 'Existing Title',
          description: 'Existing Description',
          isCompleted: true,
        );

        await tester.pumpWidget(
          createTestWidget(
            itemId: 1,
            initialState: ItemDetailState(item: item),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Existing Title'), findsOneWidget);
        expect(find.text('Existing Description'), findsOneWidget);
      });

      testWidgets('shows update button in edit mode', (tester) async {
        final item = const ItemModel(
          id: 1,
          title: 'Test',
          description: 'Test Description',
        );

        await tester.pumpWidget(
          createTestWidget(
            itemId: 1,
            initialState: ItemDetailState(item: item),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('ذخیره تغییرات'), findsOneWidget);
      });
    });

    group('Validation', () {
      testWidgets('validates empty title', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Find and tap submit button
        await tester.tap(find.text('ایجاد آیتم'));
        await tester.pumpAndSettle();

        // Should show validation error
        expect(find.text('عنوان الزامی است'), findsOneWidget);
      });

      testWidgets('validates title minimum length', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Enter short title
        final textFields = find.byType(TextFormField);
        await tester.enterText(textFields.first, 'ab');

        // Tap submit
        await tester.tap(find.text('ایجاد آیتم'));
        await tester.pumpAndSettle();

        // Should show validation error
        expect(
          find.text('عنوان باید حداقل ۳ کاراکتر باشد'),
          findsOneWidget,
        );
      });

      testWidgets('validates empty description', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Enter valid title
        final textFields = find.byType(TextFormField);
        await tester.enterText(textFields.first, 'Valid Title');

        // Tap submit without description
        await tester.tap(find.text('ایجاد آیتم'));
        await tester.pumpAndSettle();

        // Should show validation error
        expect(find.text('توضیحات الزامی است'), findsOneWidget);
      });

      testWidgets('validates description minimum length', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final textFields = find.byType(TextFormField);

        // Enter valid title
        await tester.enterText(textFields.first, 'Valid Title');

        // Enter short description
        await tester.enterText(textFields.at(1), 'short');

        // Tap submit
        await tester.tap(find.text('ایجاد آیتم'));
        await tester.pumpAndSettle();

        // Should show validation error
        expect(
          find.text('توضیحات باید حداقل ۱۰ کاراکتر باشد'),
          findsOneWidget,
        );
      });
    });

    group('UI Elements', () {
      testWidgets('has completion checkbox', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        expect(find.byType(CheckboxListTile), findsOneWidget);
        expect(find.text('تکمیل شده'), findsOneWidget);
      });

      testWidgets('completion checkbox is toggleable', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final checkbox = find.byType(CheckboxListTile);

        // Initially unchecked
        CheckboxListTile checkboxWidget =
            tester.widget<CheckboxListTile>(checkbox);
        expect(checkboxWidget.value, isFalse);

        // Toggle
        await tester.tap(checkbox);
        await tester.pumpAndSettle();

        // Should be checked
        checkboxWidget = tester.widget<CheckboxListTile>(checkbox);
        expect(checkboxWidget.value, isTrue);
      });
    });
  });

  group('ItemFormSchema', () {
    test('validates valid title', () {
      final result = ItemFormSchema.validateTitle('Valid Title');
      expect(result, isNull);
    });

    test('returns error for empty title', () {
      final result = ItemFormSchema.validateTitle('');
      expect(result, equals('عنوان الزامی است'));
    });

    test('returns error for null title', () {
      final result = ItemFormSchema.validateTitle(null);
      expect(result, equals('عنوان الزامی است'));
    });

    test('returns error for short title', () {
      final result = ItemFormSchema.validateTitle('ab');
      expect(result, equals('عنوان باید حداقل ۳ کاراکتر باشد'));
    });

    test('validates valid description', () {
      final result = ItemFormSchema.validateDescription(
        'This is a valid description with enough characters',
      );
      expect(result, isNull);
    });

    test('returns error for empty description', () {
      final result = ItemFormSchema.validateDescription('');
      expect(result, equals('توضیحات الزامی است'));
    });

    test('returns error for short description', () {
      final result = ItemFormSchema.validateDescription('short');
      expect(result, equals('توضیحات باید حداقل ۱۰ کاراکتر باشد'));
    });
  });
}
