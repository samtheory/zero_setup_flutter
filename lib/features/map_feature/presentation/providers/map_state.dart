import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../data/models/map_models.dart';

part 'map_state.freezed.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Map State - Main state for the entire map feature
// ═══════════════════════════════════════════════════════════════════════════

/// Main state for the map feature
/// Contains all layer data and map configuration
@freezed
sealed class MapState with _$MapState {
  const factory MapState({
    // Map Configuration
    @Default(MapTemplate.openStreetMap) MapTemplate currentTemplate,
    @Default(13.0) double zoom,
    LatLng? center,

    // User Location
    UserLocationModel? userLocation,
    @Default(false) bool isLoadingLocation,
    @Default(false) bool isFollowingUser,
    String? locationError,

    // POI Layer
    @Default([]) List<PoiModel> pois,
    @Default(true) bool showPoisLayer,
    @Default(false) bool isLoadingPois,
    Set<PoiCategory>? poiCategoryFilter,
    PoiModel? selectedPoi,

    // Routes Layer
    @Default([]) List<RouteModel> routes,
    @Default(true) bool showRoutesLayer,
    @Default(false) bool isLoadingRoutes,
    RouteModel? selectedRoute,

    // Vehicles Layer
    @Default([]) List<VehicleModel> vehicles,
    @Default(true) bool showVehiclesLayer,
    @Default(false) bool isLoadingVehicles,
    VehicleModel? selectedVehicle,

    // General
    String? error,
    @Default(false) bool isMapReady,
  }) = _MapState;

  const MapState._();

  /// Default center (Tehran)
  static LatLng get defaultCenter => const LatLng(35.6892, 51.3890);

  /// Check if any layer is loading
  bool get isAnyLoading => isLoadingLocation || isLoadingPois || isLoadingRoutes || isLoadingVehicles;

  /// Get effective center
  LatLng get effectiveCenter => center ?? defaultCenter;

  /// Check if there's an error
  bool get hasError => error != null;

  /// Get visible POIs (filtered by category if filter is set)
  List<PoiModel> get visiblePois {
    if (poiCategoryFilter == null || poiCategoryFilter!.isEmpty) {
      return pois;
    }
    return pois.where((p) => poiCategoryFilter!.contains(p.category)).toList();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Layer Visibility State - For individual layer controls
// ═══════════════════════════════════════════════════════════════════════════

/// State for managing layer visibility
@freezed
sealed class MapLayersVisibility with _$MapLayersVisibility {
  const factory MapLayersVisibility({
    @Default(true) bool showUserLocation,
    @Default(true) bool showPois,
    @Default(true) bool showRoutes,
    @Default(true) bool showVehicles,
  }) = _MapLayersVisibility;

  const MapLayersVisibility._();

  /// Count of visible layers
  int get visibleLayerCount =>
      (showUserLocation ? 1 : 0) + (showPois ? 1 : 0) + (showRoutes ? 1 : 0) + (showVehicles ? 1 : 0);
}

// ═══════════════════════════════════════════════════════════════════════════
// POI Selection State
// ═══════════════════════════════════════════════════════════════════════════

/// State for POI detail view
@freezed
sealed class PoiDetailState with _$PoiDetailState {
  const factory PoiDetailState({PoiModel? poi, @Default(false) bool isLoading, String? error}) = _PoiDetailState;

  const PoiDetailState._();
}

// ═══════════════════════════════════════════════════════════════════════════
// Vehicle Tracking State
// ═══════════════════════════════════════════════════════════════════════════

/// State for tracking a specific vehicle
@freezed
sealed class VehicleTrackingState with _$VehicleTrackingState {
  const factory VehicleTrackingState({
    VehicleModel? trackedVehicle,
    @Default(false) bool isTracking,
    @Default([]) List<LatLng> trackHistory,
    String? error,
  }) = _VehicleTrackingState;

  const VehicleTrackingState._();

  /// Check if currently tracking any vehicle
  bool get hasTrackedVehicle => trackedVehicle != null && isTracking;
}
