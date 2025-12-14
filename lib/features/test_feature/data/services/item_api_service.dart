import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/item_model.dart';

part 'item_api_service.g.dart';

/// Retrofit API service for items
/// Uses Dio instance from Riverpod provider (with auth, logging, error handling)
@RestApi()
abstract class ItemApiService {
  factory ItemApiService(Dio dio, {String baseUrl}) = _ItemApiService;

  /// Get all items with optional pagination
  @GET('/items')
  Future<List<ItemModel>> getItems({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('search') String? search,
  });

  /// Get single item by ID
  @GET('/items/{id}')
  Future<ItemModel> getItem(@Path('id') int id);

  /// Create new item
  @POST('/items')
  Future<ItemModel> createItem(@Body() ItemRequest request);

  /// Update existing item
  @PUT('/items/{id}')
  Future<ItemModel> updateItem(
    @Path('id') int id,
    @Body() ItemRequest request,
  );

  /// Partial update (PATCH)
  @PATCH('/items/{id}')
  Future<ItemModel> patchItem(
    @Path('id') int id,
    @Body() Map<String, dynamic> data,
  );

  /// Delete item
  @DELETE('/items/{id}')
  Future<void> deleteItem(@Path('id') int id);
}
