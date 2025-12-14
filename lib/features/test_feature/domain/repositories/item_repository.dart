import '../../data/models/item_model.dart';

/// Abstract repository interface for items
/// This allows easy mocking for tests and follows dependency inversion principle
abstract class ItemRepository {
  /// Get all items with optional pagination and search
  Future<List<ItemModel>> getItems({int? page, int? limit, String? search});

  /// Get single item by ID
  Future<ItemModel> getItem(int id);

  /// Create new item
  Future<ItemModel> createItem(ItemRequest request);

  /// Update existing item
  Future<ItemModel> updateItem(int id, ItemRequest request);

  /// Delete item
  Future<void> deleteItem(int id);
}
