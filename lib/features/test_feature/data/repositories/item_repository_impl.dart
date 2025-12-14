import '../../../../core/logger/app_logger.dart';
import '../../domain/repositories/item_repository.dart';
import '../models/item_model.dart';
import '../services/item_api_service.dart';

/// Repository implementation that uses API service
/// Handles logging and error management
class ItemRepositoryImpl implements ItemRepository {
  final ItemApiService _apiService;

  ItemRepositoryImpl(this._apiService);

  @override
  Future<List<ItemModel>> getItems({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      talker.info('📥 Fetching items: page=$page, limit=$limit, search=$search');
      final items = await _apiService.getItems(
        page: page,
        limit: limit,
        search: search,
      );
      talker.good('✅ Fetched ${items.length} items');
      return items;
    } catch (e, st) {
      talker.error('❌ Failed to fetch items', e, st);
      rethrow;
    }
  }

  @override
  Future<ItemModel> getItem(int id) async {
    try {
      talker.info('📥 Fetching item: $id');
      final item = await _apiService.getItem(id);
      talker.good('✅ Fetched item: ${item.title}');
      return item;
    } catch (e, st) {
      talker.error('❌ Failed to fetch item $id', e, st);
      rethrow;
    }
  }

  @override
  Future<ItemModel> createItem(ItemRequest request) async {
    try {
      talker.info('📤 Creating item: ${request.title}');
      final item = await _apiService.createItem(request);
      talker.good('✅ Created item: ${item.id}');
      return item;
    } catch (e, st) {
      talker.error('❌ Failed to create item', e, st);
      rethrow;
    }
  }

  @override
  Future<ItemModel> updateItem(int id, ItemRequest request) async {
    try {
      talker.info('📤 Updating item: $id');
      final item = await _apiService.updateItem(id, request);
      talker.good('✅ Updated item: ${item.title}');
      return item;
    } catch (e, st) {
      talker.error('❌ Failed to update item $id', e, st);
      rethrow;
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      talker.info('🗑️ Deleting item: $id');
      await _apiService.deleteItem(id);
      talker.good('✅ Deleted item: $id');
    } catch (e, st) {
      talker.error('❌ Failed to delete item $id', e, st);
      rethrow;
    }
  }
}
