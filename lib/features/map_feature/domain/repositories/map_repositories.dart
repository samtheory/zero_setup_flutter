import '../../data/models/map_models.dart';

/// Abstract repository interface for POI data
/// Allows fetching points of interest from various sources (API, local, etc.)
abstract class PoiRepository {
  /// Get all POIs with optional filtering
  Future<List<PoiModel>> getPois({
    double? centerLat,
    double? centerLng,
    double? radiusKm,
    PoiCategory? category,
    String? searchQuery,
  });

  /// Get single POI by ID
  Future<PoiModel> getPoi(String id);

  /// Create new POI (for admin/editing features)
  Future<PoiModel> createPoi(PoiModel poi);

  /// Update existing POI
  Future<PoiModel> updatePoi(PoiModel poi);

  /// Delete POI
  Future<void> deletePoi(String id);
}

/// Abstract repository interface for Route data
abstract class RouteRepository {
  /// Get all routes
  Future<List<RouteModel>> getRoutes();

  /// Get single route by ID
  Future<RouteModel> getRoute(String id);

  /// Create new route
  Future<RouteModel> createRoute(RouteModel route);

  /// Update existing route
  Future<RouteModel> updateRoute(RouteModel route);

  /// Delete route
  Future<void> deleteRoute(String id);
}

/// Abstract repository interface for Vehicle/Car data
abstract class VehicleRepository {
  /// Get all vehicles (usually from real-time source)
  Future<List<VehicleModel>> getVehicles();

  /// Get single vehicle by ID
  Future<VehicleModel> getVehicle(String id);

  /// Subscribe to vehicle updates (for real-time tracking)
  Stream<List<VehicleModel>> watchVehicles();

  /// Subscribe to single vehicle updates
  Stream<VehicleModel> watchVehicle(String id);
}
