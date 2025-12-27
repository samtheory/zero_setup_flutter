import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/models/map_models.dart';
import '../../data/repositories/mock_map_repositories.dart';
import '../../domain/repositories/map_repositories.dart';
import 'map_state.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Repository Providers
// ═══════════════════════════════════════════════════════════════════════════

/// POI Repository provider - swap with API implementation when ready
final poiRepositoryProvider = Provider<PoiRepository>((ref) {
  talker.debug('Creating MockPoiRepositoryImpl');
  return MockPoiRepositoryImpl();
});

/// Route Repository provider
final routeRepositoryProvider = Provider<RouteRepository>((ref) {
  talker.debug('Creating MockRouteRepositoryImpl');
  return MockRouteRepositoryImpl();
});

/// Vehicle Repository provider
final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  talker.debug('Creating MockVehicleRepositoryImpl');
  return MockVehicleRepositoryImpl();
});

// ═══════════════════════════════════════════════════════════════════════════
// Main Map State Provider
// ═══════════════════════════════════════════════════════════════════════════

/// Main map state notifier provider
final mapStateProvider = StateNotifierProvider<MapStateNotifier, MapState>((ref) {
  return MapStateNotifier(
    ref.watch(poiRepositoryProvider),
    ref.watch(routeRepositoryProvider),
    ref.watch(vehicleRepositoryProvider),
    ref,
  );
});

/// Map State Notifier - manages all map state
class MapStateNotifier extends StateNotifier<MapState> {
  final PoiRepository _poiRepository;
  final RouteRepository _routeRepository;
  final VehicleRepository _vehicleRepository;
  final Ref _ref;

  StreamSubscription<List<VehicleModel>>? _vehicleSubscription;
  StreamSubscription<Position>? _locationSubscription;

  MapStateNotifier(this._poiRepository, this._routeRepository, this._vehicleRepository, this._ref)
    : super(const MapState()) {
    talker.debug('MapStateNotifier created');
  }

  @override
  void dispose() {
    talker.debug('MapStateNotifier disposing');
    _vehicleSubscription?.cancel();
    _locationSubscription?.cancel();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Map Configuration
  // ═══════════════════════════════════════════════════════════════════════

  /// Initialize the map
  Future<void> initializeMap() async {
    talker.info('🗺️ Initializing map');

    state = state.copyWith(isMapReady: false, error: null);

    try {
      // Load initial data in parallel
      await Future.wait([loadPois(), loadRoutes(), loadVehicles()]);

      state = state.copyWith(isMapReady: true);
      talker.good('✅ Map initialized successfully');
    } catch (e, st) {
      talker.error('❌ Failed to initialize map', e, st);
      state = state.copyWith(error: 'Failed to initialize map: $e');
    }
  }

  /// Change map template/style
  void setMapTemplate(MapTemplate template) {
    talker.info('🎨 Changing map template to: ${template.displayName}');
    state = state.copyWith(currentTemplate: template);
  }

  /// Update zoom level
  void setZoom(double zoom) {
    state = state.copyWith(zoom: zoom.clamp(1.0, 18.0));
  }

  /// Update map center
  void setCenter(LatLng center) {
    state = state.copyWith(center: center);
  }

  /// Move map to specific location
  void moveToLocation(LatLng location, {double? zoom}) {
    talker.info('📍 Moving to: ${location.latitude}, ${location.longitude}');
    state = state.copyWith(center: location, zoom: zoom ?? state.zoom);
  }

  // ═══════════════════════════════════════════════════════════════════════
  // User Location
  // ═══════════════════════════════════════════════════════════════════════

  /// Check and request location permission
  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      talker.warning('⚠️ Location services disabled');
      state = state.copyWith(locationError: 'Location services are disabled');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        talker.warning('⚠️ Location permission denied');
        state = state.copyWith(locationError: 'Location permission denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      talker.warning('⚠️ Location permission permanently denied');
      state = state.copyWith(locationError: 'Location permission permanently denied. Please enable in settings.');
      return false;
    }

    return true;
  }

  /// Get current user location
  Future<void> getCurrentLocation() async {
    talker.info('📍 Getting current location');
    state = state.copyWith(isLoadingLocation: true, locationError: null);

    try {
      if (!await _checkLocationPermission()) {
        state = state.copyWith(isLoadingLocation: false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 10)),
      );

      final userLocation = UserLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        heading: position.heading,
        speed: position.speed,
        accuracy: position.accuracy,
        altitude: position.altitude,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(userLocation: userLocation, isLoadingLocation: false, center: userLocation.latLng);

      talker.good('✅ Got location: ${position.latitude}, ${position.longitude}');
    } catch (e, st) {
      talker.error('❌ Failed to get location', e, st);
      state = state.copyWith(isLoadingLocation: false, locationError: 'Failed to get location: $e');
    }
  }

  /// Start following user location
  Future<void> startFollowingUser() async {
    talker.info('🔄 Starting to follow user location');

    if (!await _checkLocationPermission()) return;

    state = state.copyWith(isFollowingUser: true);

    _locationSubscription?.cancel();
    _locationSubscription =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10, // Update every 10 meters
          ),
        ).listen(
          (position) {
            final userLocation = UserLocationModel(
              latitude: position.latitude,
              longitude: position.longitude,
              heading: position.heading,
              speed: position.speed,
              accuracy: position.accuracy,
              altitude: position.altitude,
              timestamp: DateTime.now(),
            );

            state = state.copyWith(
              userLocation: userLocation,
              center: state.isFollowingUser ? userLocation.latLng : state.center,
            );
          },
          onError: (e) {
            talker.error('❌ Location stream error', e);
            state = state.copyWith(isFollowingUser: false, locationError: 'Location tracking error: $e');
          },
        );
  }

  /// Stop following user location
  void stopFollowingUser() {
    talker.info('⏹️ Stopping user location tracking');
    _locationSubscription?.cancel();
    _locationSubscription = null;
    state = state.copyWith(isFollowingUser: false);
  }

  // ═══════════════════════════════════════════════════════════════════════
  // POI Layer
  // ═══════════════════════════════════════════════════════════════════════

  /// Load POIs
  Future<void> loadPois({PoiCategory? category, String? searchQuery}) async {
    talker.info('📍 Loading POIs');
    state = state.copyWith(isLoadingPois: true, error: null);

    try {
      final pois = await _poiRepository.getPois(category: category, searchQuery: searchQuery);
      state = state.copyWith(pois: pois, isLoadingPois: false);
      talker.good('✅ Loaded ${pois.length} POIs');
    } catch (e, st) {
      talker.error('❌ Failed to load POIs', e, st);
      state = state.copyWith(isLoadingPois: false, error: 'Failed to load POIs: $e');
    }
  }

  /// Toggle POI layer visibility
  void togglePoisLayer() {
    state = state.copyWith(showPoisLayer: !state.showPoisLayer);
    talker.info('👁️ POIs layer: ${state.showPoisLayer ? 'visible' : 'hidden'}');
  }

  /// Set POI category filter
  void setPoiCategoryFilter(Set<PoiCategory>? categories) {
    state = state.copyWith(poiCategoryFilter: categories);
    talker.info('🏷️ POI filter: ${categories?.map((c) => c.name).join(', ') ?? 'all'}');
  }

  /// Select a POI
  void selectPoi(PoiModel? poi) {
    state = state.copyWith(selectedPoi: poi);
    if (poi != null) {
      talker.info('📍 Selected POI: ${poi.name}');
      moveToLocation(poi.latLng);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Routes Layer
  // ═══════════════════════════════════════════════════════════════════════

  /// Load routes
  Future<void> loadRoutes() async {
    talker.info('🛤️ Loading routes');
    state = state.copyWith(isLoadingRoutes: true, error: null);

    try {
      final routes = await _routeRepository.getRoutes();
      state = state.copyWith(routes: routes, isLoadingRoutes: false);
      talker.good('✅ Loaded ${routes.length} routes');
    } catch (e, st) {
      talker.error('❌ Failed to load routes', e, st);
      state = state.copyWith(isLoadingRoutes: false, error: 'Failed to load routes: $e');
    }
  }

  /// Toggle routes layer visibility
  void toggleRoutesLayer() {
    state = state.copyWith(showRoutesLayer: !state.showRoutesLayer);
    talker.info('👁️ Routes layer: ${state.showRoutesLayer ? 'visible' : 'hidden'}');
  }

  /// Select a route
  void selectRoute(RouteModel? route) {
    state = state.copyWith(selectedRoute: route);
    if (route != null && route.waypoints.isNotEmpty) {
      talker.info('🛤️ Selected route: ${route.name}');
      // Center on first waypoint
      moveToLocation(route.waypoints.first.latLng);
    }
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Vehicles Layer
  // ═══════════════════════════════════════════════════════════════════════

  /// Load vehicles
  Future<void> loadVehicles() async {
    talker.info('🚗 Loading vehicles');
    state = state.copyWith(isLoadingVehicles: true, error: null);

    try {
      final vehicles = await _vehicleRepository.getVehicles();
      state = state.copyWith(vehicles: vehicles, isLoadingVehicles: false);
      talker.good('✅ Loaded ${vehicles.length} vehicles');
    } catch (e, st) {
      talker.error('❌ Failed to load vehicles', e, st);
      state = state.copyWith(isLoadingVehicles: false, error: 'Failed to load vehicles: $e');
    }
  }

  /// Start watching vehicles for real-time updates
  void startWatchingVehicles() {
    talker.info('🔄 Starting vehicle watch');

    _vehicleSubscription?.cancel();
    _vehicleSubscription = _vehicleRepository.watchVehicles().listen(
      (vehicles) {
        state = state.copyWith(
          vehicles: vehicles,
          // Update selected vehicle if it exists
          selectedVehicle: state.selectedVehicle != null
              ? vehicles.firstWhere((v) => v.id == state.selectedVehicle!.id, orElse: () => state.selectedVehicle!)
              : null,
        );
      },
      onError: (e) {
        talker.error('❌ Vehicle stream error', e);
      },
    );
  }

  /// Stop watching vehicles
  void stopWatchingVehicles() {
    talker.info('⏹️ Stopping vehicle watch');
    _vehicleSubscription?.cancel();
    _vehicleSubscription = null;
  }

  /// Toggle vehicles layer visibility
  void toggleVehiclesLayer() {
    state = state.copyWith(showVehiclesLayer: !state.showVehiclesLayer);
    talker.info('👁️ Vehicles layer: ${state.showVehiclesLayer ? 'visible' : 'hidden'}');
  }

  /// Select a vehicle
  void selectVehicle(VehicleModel? vehicle) {
    state = state.copyWith(selectedVehicle: vehicle);
    if (vehicle != null) {
      talker.info('🚗 Selected vehicle: ${vehicle.name}');
      moveToLocation(vehicle.latLng);
    }
  }

  /// Track a specific vehicle (follow on map)
  void trackVehicle(String vehicleId) {
    final vehicle = state.vehicles.firstWhere((v) => v.id == vehicleId, orElse: () => state.vehicles.first);
    state = state.copyWith(selectedVehicle: vehicle);
    talker.info('🎯 Tracking vehicle: ${vehicle.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Clear Selections
  // ═══════════════════════════════════════════════════════════════════════

  /// Clear all selections
  void clearSelections() {
    state = state.copyWith(selectedPoi: null, selectedRoute: null, selectedVehicle: null);
    talker.info('🧹 Cleared all selections');
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null, locationError: null);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Convenience Providers
// ═══════════════════════════════════════════════════════════════════════════

/// Provider for current map template
final currentMapTemplateProvider = Provider<MapTemplate>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.currentTemplate));
});

/// Provider for visible POIs
final visiblePoisProvider = Provider<List<PoiModel>>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.visiblePois));
});

/// Provider for user location
final userLocationProvider = Provider<UserLocationModel?>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.userLocation));
});

/// Provider for vehicles list
final vehiclesProvider = Provider<List<VehicleModel>>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.vehicles));
});

/// Provider for routes list
final routesProvider = Provider<List<RouteModel>>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.routes));
});

/// Provider for selected POI
final selectedPoiProvider = Provider<PoiModel?>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.selectedPoi));
});

/// Provider for selected vehicle
final selectedVehicleProvider = Provider<VehicleModel?>((ref) {
  return ref.watch(mapStateProvider.select((s) => s.selectedVehicle));
});
