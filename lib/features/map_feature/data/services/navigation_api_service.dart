import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:retrofit/retrofit.dart';

part 'navigation_api_service.g.dart';

/// Retrofit API service for items
/// Uses Dio instance from Riverpod provider (with auth, logging, error handling)
@RestApi()
abstract class NavigationApiService {
  factory NavigationApiService(Dio dio, {String baseUrl}) = _NavigationApiService;

  /// Get all items with optional pagination
  // @GET('/items')
  // Future<List<ItemModel>> getItems({
  //   @Query('page') int? page,
  //   @Query('limit') int? limit,
  //   @Query('search') String? search,
  // });

  /// Get single item by ID
  @GET(
    '/route/v1/driving/{startLongitude},{startLatitude};{endLongitude},{endLatitude}?overview=full&geometries=geojson',
  )
  Future<List<LatLng>> getRoutes(
    @Path('startLongitude') double startLongitude,
    @Path('startLatitude') double startLatitude,
    @Path('endLongitude') double endLongitude,
    @Path('endLatitude') double endLatitude,
  );
}
