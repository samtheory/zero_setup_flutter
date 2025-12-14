import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';
import 'package:zero_setup_flutter/features/test_feature/presentation/widgets/item_card.dart';

void main() {
  group('ItemCard', () {
    late ItemModel testItem;

    setUp(() {
      testItem = ItemModel(
        id: 1,
        title: 'Test Item',
        description: 'This is a test description',
        isCompleted: false,
      );
    });

    testWidgets('renders item title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Item'), findsOneWidget);
    });

    testWidgets('renders item description', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('This is a test description'), findsOneWidget);
    });

    testWidgets('shows pending icon when item is not completed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem.copyWith(isCompleted: false),
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.pending_outlined), findsOneWidget);
    });

    testWidgets('shows check icon when item is completed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem.copyWith(isCompleted: true),
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('applies line-through decoration when completed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem.copyWith(isCompleted: true),
              onTap: () {},
            ),
          ),
        ),
      );

      final titleFinder = find.text('Test Item');
      final textWidget = tester.widget<Text>(titleFinder);
      
      expect(
        textWidget.style?.decoration,
        equals(TextDecoration.lineThrough),
      );
    });

    testWidgets('calls onTap when card is tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('calls onDelete when delete button is tapped', (tester) async {
      var deleted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () {},
              onDelete: () => deleted = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      expect(deleted, isTrue);
    });

    testWidgets('calls onEdit when edit button is tapped', (tester) async {
      var edited = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () {},
              onEdit: () => edited = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();

      expect(edited, isTrue);
    });

    testWidgets('does not show delete button when onDelete is null',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () {},
              onDelete: null,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.delete_outline), findsNothing);
    });

    testWidgets('does not show edit button when onEdit is null',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: testItem,
              onTap: () {},
              onEdit: null,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.edit_outlined), findsNothing);
    });

    testWidgets('displays formatted date when createdAt is not null',
        (tester) async {
      final itemWithDate = testItem.copyWith(
        createdAt: DateTime(2024, 1, 15),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: itemWithDate,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('2024/01/15'), findsOneWidget);
    });

    testWidgets('does not display date when createdAt is null',
        (tester) async {
      final itemWithoutDate = testItem.copyWith(createdAt: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ItemCard(
              item: itemWithoutDate,
              onTap: () {},
            ),
          ),
        ),
      );

      // Should not find any date text
      expect(find.textContaining('/'), findsNothing);
    });
  });

  group('ItemCardShimmer', () {
    testWidgets('renders shimmer placeholder', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ItemCardShimmer(),
          ),
        ),
      );

      expect(find.byType(ItemCardShimmer), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });
  });
}
