import 'package:latlong2/latlong.dart';
import 'package:zero_setup_flutter/features/map_feature/data/services/navigation_api_service.dart';

import '../../../../core/logger/app_logger.dart';
import '../../domain/repositories/map_repositories.dart';
import '../models/map_models.dart';

/// Mock implementation of PoiRepository for demo/testing
/// Replace with actual API implementation when available
class MockPoiRepositoryImpl implements PoiRepository {
  /// Sample POI data - in real app, this comes from API
  final List<PoiModel> _mockPois = [
    const PoiModel(
      id: 'poi_1',
      name: 'Milad Tower',
      latitude: 35.7448,
      longitude: 51.3753,
      category: PoiCategory.attraction,
      description: 'Iconic telecommunications tower',
      address: 'Milad Tower, Tehran',
    ),
    const PoiModel(
      id: 'poi_2',
      name: 'Azadi Tower',
      latitude: 35.6997,
      longitude: 51.3380,
      category: PoiCategory.attraction,
      description: 'Freedom Tower monument',
      address: 'Azadi Square, Tehran',
    ),
    const PoiModel(
      id: 'poi_3',
      name: 'Darband Restaurant',
      latitude: 35.8115,
      longitude: 51.4229,
      category: PoiCategory.restaurant,
      description: 'Traditional Iranian cuisine',
      address: 'Darband, Tehran',
    ),
    const PoiModel(
      id: 'poi_4',
      name: 'Espinas Palace Hotel',
      latitude: 35.7575,
      longitude: 51.4100,
      category: PoiCategory.hotel,
      description: '5-star luxury hotel',
      address: 'Chamran Highway, Tehran',
    ),
    const PoiModel(
      id: 'poi_5',
      name: 'Taleghani Hospital',
      latitude: 35.7165,
      longitude: 51.4257,
      category: PoiCategory.hospital,
      description: 'General hospital',
      address: 'Taleghani St, Tehran',
    ),
    const PoiModel(
      id: 'poi_6',
      name: 'Iran Mall',
      latitude: 35.7338,
      longitude: 51.2550,
      category: PoiCategory.shopping,
      description: 'Largest mall in Iran',
      address: 'Iran Mall, Tehran',
    ),
  ];

  @override
  Future<List<PoiModel>> getPois({
    double? centerLat,
    double? centerLng,
    double? radiusKm,
    PoiCategory? category,
    String? searchQuery,
  }) async {
    talker.info('📍 Fetching POIs: category=$category, search=$searchQuery');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    var result = List<PoiModel>.from(_mockPois);

    // Filter by category
    if (category != null) {
      result = result.where((p) => p.category == category).toList();
    }

    // Filter by search query
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      result = result
          .where((p) => p.name.toLowerCase().contains(query) || (p.description?.toLowerCase().contains(query) ?? false))
          .toList();
    }

    talker.good('✅ Found ${result.length} POIs');
    return result;
  }

  @override
  Future<PoiModel> getPoi(String id) async {
    talker.info('📍 Fetching POI: $id');
    await Future.delayed(const Duration(milliseconds: 300));

    final poi = _mockPois.firstWhere((p) => p.id == id, orElse: () => throw Exception('POI not found: $id'));

    talker.good('✅ Found POI: ${poi.name}');
    return poi;
  }

  @override
  Future<PoiModel> createPoi(PoiModel poi) async {
    talker.info('📍 Creating POI: ${poi.name}');
    await Future.delayed(const Duration(milliseconds: 300));
    _mockPois.add(poi);
    talker.good('✅ Created POI: ${poi.id}');
    return poi;
  }

  @override
  Future<PoiModel> updatePoi(PoiModel poi) async {
    talker.info('📍 Updating POI: ${poi.id}');
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _mockPois.indexWhere((p) => p.id == poi.id);
    if (index == -1) throw Exception('POI not found: ${poi.id}');

    _mockPois[index] = poi;
    talker.good('✅ Updated POI: ${poi.name}');
    return poi;
  }

  @override
  Future<void> deletePoi(String id) async {
    talker.info('🗑️ Deleting POI: $id');
    await Future.delayed(const Duration(milliseconds: 300));
    _mockPois.removeWhere((p) => p.id == id);
    talker.good('✅ Deleted POI: $id');
  }
}

/// Mock implementation of RouteRepository for demo/testing
class MockRouteRepositoryImpl implements RouteRepository {
  final List<RouteModel> _mockRoutes = [
    const RouteModel(
      id: 'route_1',
      name: 'North Tehran Tour',
      waypoints: [
        RouteWaypoint(latitude: 35.7000, longitude: 51.4000, name: 'Start - Tajrish'),
        RouteWaypoint(latitude: 35.7500, longitude: 51.4100, order: 1),
        RouteWaypoint(latitude: 35.7800, longitude: 51.4150, order: 2),
        RouteWaypoint(latitude: 35.8115, longitude: 51.4229, name: 'End - Darband'),
      ],
      color: 0xFF4CAF50, // Green
      strokeWidth: 5.0,
      description: 'Scenic route through northern Tehran',
      totalDistanceKm: 12.5,
      estimatedTimeMinutes: 35,
    ),
    const RouteModel(
      id: 'route_2',
      name: 'City Center Loop',
      waypoints: [
        RouteWaypoint(latitude: 35.6892, longitude: 51.3890, name: 'Start - Ferdowsi'),
        RouteWaypoint(latitude: 35.6997, longitude: 51.3380, order: 1, name: 'Azadi'),
        RouteWaypoint(latitude: 35.7100, longitude: 51.3600, order: 2),
        RouteWaypoint(latitude: 35.6950, longitude: 51.3950, name: 'End - Enghelab'),
      ],
      color: 0xFF2196F3, // Blue
      strokeWidth: 4.0,
      description: 'Loop through city landmarks',
      totalDistanceKm: 8.0,
      estimatedTimeMinutes: 25,
    ),
  ];

  @override
  Future<List<RouteModel>> getRoutes() async {
    talker.info('🛤️ Fetching routes');
    await Future.delayed(const Duration(milliseconds: 500));
    talker.good('✅ Found ${_mockRoutes.length} routes');
    return List.from(_mockRoutes);
  }

  @override
  Future<RouteModel> getRoute(String id) async {
    talker.info('🛤️ Fetching route: $id');
    await Future.delayed(const Duration(milliseconds: 300));

    final route = _mockRoutes.firstWhere((r) => r.id == id, orElse: () => throw Exception('Route not found: $id'));

    talker.good('✅ Found route: ${route.name}');
    return route;
  }

  @override
  Future<RouteModel> createRoute(RouteModel route) async {
    talker.info('🛤️ Creating route: ${route.name}');
    await Future.delayed(const Duration(milliseconds: 300));
    _mockRoutes.add(route);
    talker.good('✅ Created route: ${route.id}');
    return route;
  }

  @override
  Future<RouteModel> updateRoute(RouteModel route) async {
    talker.info('🛤️ Updating route: ${route.id}');
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _mockRoutes.indexWhere((r) => r.id == route.id);
    if (index == -1) throw Exception('Route not found: ${route.id}');

    _mockRoutes[index] = route;
    talker.good('✅ Updated route: ${route.name}');
    return route;
  }

  @override
  Future<void> deleteRoute(String id) async {
    talker.info('🗑️ Deleting route: $id');
    await Future.delayed(const Duration(milliseconds: 300));
    _mockRoutes.removeWhere((r) => r.id == id);
    talker.good('✅ Deleted route: $id');
  }
}

/// Mock implementation of VehicleRepository for demo/testing
class MockVehicleRepositoryImpl implements VehicleRepository {
  final NavigationApiService _apiService;

  MockVehicleRepositoryImpl(this._apiService);
  final List<VehicleModel> _mockVehicles = [
    VehicleModel(
      id: 'vehicle_1',
      name: 'Taxi 101',
      latitude: 35.7200,
      longitude: 51.4050,
      heading: 45.0, // Northeast
      speed: 35.0,
      status: VehicleStatus.busy,
      driverName: 'Ali Ahmadi',
      plateNumber: '12-ABC-345',
      vehicleType: 'Sedan',
      currentRouteId: 'route_1',
      lastUpdated: DateTime.now(),
    ),
    VehicleModel(
      id: 'vehicle_2',
      name: 'Taxi 102',
      latitude: 35.6950,
      longitude: 51.3700,
      heading: 180.0, // South
      speed: 0.0,
      status: VehicleStatus.available,
      driverName: 'Mohammad Reza',
      plateNumber: '15-XYZ-789',
      vehicleType: 'Sedan',
      lastUpdated: DateTime.now(),
    ),
    VehicleModel(
      id: 'vehicle_3',
      name: 'Van 201',
      latitude: 35.7338,
      longitude: 51.2600,
      heading: 270.0, // West
      speed: 50.0,
      status: VehicleStatus.busy,
      driverName: 'Hassan Karimi',
      plateNumber: '22-DEF-456',
      vehicleType: 'Van',
      lastUpdated: DateTime.now(),
    ),
    VehicleModel(
      id: 'vehicle_4',
      name: 'Taxi 103',
      latitude: 35.7500,
      longitude: 51.3900,
      heading: 0.0, // North
      speed: 25.0,
      status: VehicleStatus.busy,
      driverName: 'Reza Safari',
      plateNumber: '33-GHI-123',
      vehicleType: 'Sedan',
      currentRouteId: 'route_2',
      lastUpdated: DateTime.now(),
    ),
  ];

  @override
  Future<List<VehicleModel>> getVehicles() async {
    talker.info('🚗 Fetching vehicles');
    await Future.delayed(const Duration(milliseconds: 500));
    talker.good('✅ Found ${_mockVehicles.length} vehicles');
    return List.from(_mockVehicles);
  }

  @override
  Future<List<LatLng>> getRouteForNavigation(LatLng start, LatLng end) async {
    

    
    try {
      talker.info('📥 Fetching routes navigation from: start.longitude=${start.longitude}, start.latitude=${start.latitude}, TO end.longitude=${end.longitude}, end.latitude=${end.latitude}');
      final routes = await _apiService.getRoutes(start.longitude, start.latitude, end.longitude, end.latitude);
      talker.good('✅ Fetched ${routes.length} routes');
      return routes;
    } catch (e, st) {
      talker.error('❌ خطا در مسیریابی:', e, st);
      rethrow;
    }
      return [];
  }

  @override
  Future<VehicleModel> getVehicle(String id) async {
    talker.info('🚗 Fetching vehicle: $id');
    await Future.delayed(const Duration(milliseconds: 300));

    final vehicle = _mockVehicles.firstWhere(
      (v) => v.id == id,
      orElse: () => throw Exception('Vehicle not found: $id'),
    );

    talker.good('✅ Found vehicle: ${vehicle.name}');
    return vehicle;
  }

  @override
  Stream<List<VehicleModel>> watchVehicles() async* {
    talker.info('🚗 Starting vehicle stream');

    // Initial data
    yield List.from(_mockVehicles);

    // Simulate real-time updates every 3 seconds
    while (true) {
      await Future.delayed(const Duration(seconds: 3));

      // Simulate vehicle movement
      for (int i = 0; i < _mockVehicles.length; i++) {
        if (_mockVehicles[i].isMoving) {
          final vehicle = _mockVehicles[i];
          // Move slightly in heading direction
          final headingRad = vehicle.headingRadians;
          final deltaLat = 0.001 * _cos(headingRad);
          final deltaLng = 0.001 * _sin(headingRad);

          _mockVehicles[i] = vehicle.copyWith(
            latitude: vehicle.latitude + deltaLat,
            longitude: vehicle.longitude + deltaLng,
            lastUpdated: DateTime.now(),
          );
        }
      }

      yield List.from(_mockVehicles);
    }
  }

  @override
  Stream<VehicleModel> watchVehicle(String id) async* {
    talker.info('🚗 Starting stream for vehicle: $id');

    await for (final vehicles in watchVehicles()) {
      final vehicle = vehicles.firstWhere((v) => v.id == id, orElse: () => throw Exception('Vehicle not found: $id'));
      yield vehicle;
    }
  }

  // Simple math functions to avoid importing dart:math
  double _sin(double radians) {
    // Taylor series approximation
    double result = radians;
    double term = radians;
    for (int i = 1; i < 10; i++) {
      term *= -radians * radians / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  double _cos(double radians) {
    return _sin(radians + 1.5707963267948966); // cos(x) = sin(x + π/2)
  }
}
