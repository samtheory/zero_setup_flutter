import 'package:flutter_test/flutter_test.dart';
import 'package:zero_setup_flutter/features/test_feature/data/models/item_model.dart';

void main() {
  group('ItemModel', () {
    test('creates instance with required fields', () {
      const item = ItemModel(
        id: 1,
        title: 'Test Item',
        description: 'Test Description',
      );

      expect(item.id, 1);
      expect(item.title, 'Test Item');
      expect(item.description, 'Test Description');
      expect(item.isCompleted, false);
      expect(item.createdAt, isNull);
      expect(item.updatedAt, isNull);
    });

    test('creates instance with all fields', () {
      final now = DateTime.now();
      final item = ItemModel(
        id: 1,
        title: 'Test Item',
        description: 'Test Description',
        isCompleted: true,
        createdAt: now,
        updatedAt: now,
      );

      expect(item.id, 1);
      expect(item.title, 'Test Item');
      expect(item.description, 'Test Description');
      expect(item.isCompleted, true);
      expect(item.createdAt, now);
      expect(item.updatedAt, now);
    });

    test('copyWith creates new instance with updated values', () {
      const original = ItemModel(
        id: 1,
        title: 'Original',
        description: 'Original Description',
      );

      final updated = original.copyWith(
        title: 'Updated',
        isCompleted: true,
      );

      // Original unchanged
      expect(original.title, 'Original');
      expect(original.isCompleted, false);

      // Updated values
      expect(updated.id, 1);
      expect(updated.title, 'Updated');
      expect(updated.description, 'Original Description');
      expect(updated.isCompleted, true);
    });

    test('fake creates a fake item for testing', () {
      final fake = ItemModel.fake();

      expect(fake.id, 1);
      expect(fake.title, 'Test Item');
      expect(fake.description, isNotEmpty);
      expect(fake.isCompleted, false);
    });

    test('fake with custom id', () {
      final fake = ItemModel.fake(id: 42, title: 'Custom Title');

      expect(fake.id, 42);
      expect(fake.title, 'Custom Title');
    });

    group('JSON Serialization', () {
      test('fromJson parses valid JSON', () {
        final json = {
          'id': 1,
          'title': 'Test',
          'description': 'Desc',
          'isCompleted': true,
        };

        final item = ItemModel.fromJson(json);

        expect(item.id, 1);
        expect(item.title, 'Test');
        expect(item.description, 'Desc');
        expect(item.isCompleted, true);
      });

      test('toJson produces valid JSON', () {
        const item = ItemModel(
          id: 1,
          title: 'Test',
          description: 'Desc',
          isCompleted: true,
        );

        final json = item.toJson();

        expect(json['id'], 1);
        expect(json['title'], 'Test');
        expect(json['description'], 'Desc');
        expect(json['isCompleted'], true);
      });

      test('fromJson handles missing optional fields', () {
        final json = {
          'id': 1,
          'title': 'Test',
          'description': 'Desc',
        };

        final item = ItemModel.fromJson(json);

        expect(item.isCompleted, false);
        expect(item.createdAt, isNull);
      });

      test('serialization roundtrip preserves data', () {
        final original = ItemModel(
          id: 1,
          title: 'Test',
          description: 'Desc',
          isCompleted: true,
          createdAt: DateTime(2025, 1, 1),
        );

        final json = original.toJson();
        final restored = ItemModel.fromJson(json);

        expect(restored, original);
      });
    });

    group('Equality', () {
      test('equal items are equal', () {
        const item1 = ItemModel(id: 1, title: 'Test', description: 'Desc');
        const item2 = ItemModel(id: 1, title: 'Test', description: 'Desc');

        expect(item1, equals(item2));
        expect(item1.hashCode, equals(item2.hashCode));
      });

      test('different items are not equal', () {
        const item1 = ItemModel(id: 1, title: 'Test', description: 'Desc');
        const item2 = ItemModel(id: 2, title: 'Test', description: 'Desc');

        expect(item1, isNot(equals(item2)));
      });
    });
  });

  group('ItemRequest', () {
    test('creates instance with required fields', () {
      const request = ItemRequest(
        title: 'New Item',
        description: 'New Description',
      );

      expect(request.title, 'New Item');
      expect(request.description, 'New Description');
      expect(request.isCompleted, false);
    });

    test('creates instance with all fields', () {
      const request = ItemRequest(
        title: 'New Item',
        description: 'New Description',
        isCompleted: true,
      );

      expect(request.title, 'New Item');
      expect(request.description, 'New Description');
      expect(request.isCompleted, true);
    });

    test('toJson produces valid JSON', () {
      const request = ItemRequest(
        title: 'New Item',
        description: 'New Description',
        isCompleted: true,
      );

      final json = request.toJson();

      expect(json['title'], 'New Item');
      expect(json['description'], 'New Description');
      expect(json['isCompleted'], true);
    });
  });
}
