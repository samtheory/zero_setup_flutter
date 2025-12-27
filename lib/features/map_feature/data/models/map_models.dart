import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'map_models.freezed.dart';
part 'map_models.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Map Template - Different map styles/providers
// ═══════════════════════════════════════════════════════════════════════════

/// Represents different map tile templates/styles
enum MapTemplate {
  openStreetMap('OpenStreetMap', 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
  openTopoMap('OpenTopoMap', 'https://tile.opentopomap.org/{z}/{x}/{y}.png'),
  cartoLight('Carto Light', 'https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png'),
  cartoDark('Carto Dark', 'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'),
  cartoVoyager('Carto Voyager', 'https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png'),
  esriWorldStreetMap(
    'ESRI Street',
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
  ),
  esriWorldImagery(
    'ESRI Imagery',
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  );

  const MapTemplate(this.displayName, this.urlTemplate);

  /// Human-readable name for UI display
  final String displayName;

  /// URL template for tile fetching
  final String urlTemplate;

  /// Get attribution based on the template
  String get attribution {
    switch (this) {
      case MapTemplate.openStreetMap:
        return '© OpenStreetMap contributors';
      case MapTemplate.openTopoMap:
        return '© OpenStreetMap contributors, SRTM | © OpenTopoMap';
      case MapTemplate.cartoLight:
      case MapTemplate.cartoDark:
      case MapTemplate.cartoVoyager:
        return '© OpenStreetMap contributors © CARTO';
      case MapTemplate.esriWorldStreetMap:
      case MapTemplate.esriWorldImagery:
        return '© Esri, HERE, Garmin, © OpenStreetMap contributors';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Point of Interest (POI) Model
// ═══════════════════════════════════════════════════════════════════════════

/// Category types for POIs
enum PoiCategory {
  restaurant('restaurant', '🍽️'),
  hotel('hotel', '🏨'),
  hospital('hospital', '🏥'),
  gasStation('gas_station', '⛽'),
  parking('parking', '🅿️'),
  atm('atm', '🏧'),
  pharmacy('pharmacy', '💊'),
  shopping('shopping', '🛒'),
  attraction('attraction', '🎭'),
  other('other', '📍');

  const PoiCategory(this.value, this.emoji);

  final String value;
  final String emoji;

  /// Create from JSON string value
  static PoiCategory fromValue(String value) {
    return PoiCategory.values.firstWhere((e) => e.value == value, orElse: () => PoiCategory.other);
  }
}

/// Point of Interest model
@freezed
sealed class PoiModel with _$PoiModel {
  const factory PoiModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    @Default(PoiCategory.other) PoiCategory category,
    String? description,
    String? address,
    String? phoneNumber,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PoiModel;

  const PoiModel._();

  factory PoiModel.fromJson(Map<String, dynamic> json) => _$PoiModelFromJson(json);

  /// Get LatLng for flutter_map
  LatLng get latLng => LatLng(latitude, longitude);

  /// Create a fake POI for testing
  static PoiModel fake({String? id, String? name, double? latitude, double? longitude, PoiCategory? category}) =>
      PoiModel(
        id: id ?? 'poi_1',
        name: name ?? 'Test POI',
        latitude: latitude ?? 35.6892,
        longitude: longitude ?? 51.3890,
        category: category ?? PoiCategory.restaurant,
        description: 'A sample point of interest',
        address: 'Sample Address, City',
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// Route Model
// ═══════════════════════════════════════════════════════════════════════════

/// Route waypoint model
@freezed
sealed class RouteWaypoint with _$RouteWaypoint {
  const factory RouteWaypoint({required double latitude, required double longitude, String? name, int? order}) =
      _RouteWaypoint;

  const RouteWaypoint._();

  factory RouteWaypoint.fromJson(Map<String, dynamic> json) => _$RouteWaypointFromJson(json);

  /// Get LatLng for flutter_map
  LatLng get latLng => LatLng(latitude, longitude);
}

/// Route model containing waypoints
@freezed
sealed class RouteModel with _$RouteModel {
  const factory RouteModel({
    required String id,
    required String name,
    required List<RouteWaypoint> waypoints,
    @Default(0xFF2196F3) int color, // Default blue color
    @Default(4.0) double strokeWidth,
    String? description,
    double? totalDistanceKm,
    int? estimatedTimeMinutes,
    DateTime? createdAt,
  }) = _RouteModel;

  const RouteModel._();

  factory RouteModel.fromJson(Map<String, dynamic> json) => _$RouteModelFromJson(json);

  /// Get list of LatLng points for polyline
  List<LatLng> get polylinePoints => waypoints.map((w) => w.latLng).toList();

  /// Create a fake route for testing
  static RouteModel fake({String? id, String? name}) => RouteModel(
    id: id ?? 'route_1',
    name: name ?? 'Test Route',
    waypoints: [
      const RouteWaypoint(latitude: 35.6892, longitude: 51.3890, name: 'Start'),
      const RouteWaypoint(latitude: 35.6950, longitude: 51.4000, order: 1),
      const RouteWaypoint(latitude: 35.7000, longitude: 51.4100, name: 'End'),
    ],
    description: 'A sample route',
    totalDistanceKm: 5.5,
    estimatedTimeMinutes: 15,
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// Vehicle/Car Model
// ═══════════════════════════════════════════════════════════════════════════

/// Vehicle status
enum VehicleStatus {
  available('available'),
  busy('busy'),
  offline('offline'),
  maintenance('maintenance');

  const VehicleStatus(this.value);

  final String value;

  static VehicleStatus fromValue(String value) {
    return VehicleStatus.values.firstWhere((e) => e.value == value, orElse: () => VehicleStatus.offline);
  }
}

/// Vehicle/Car model for tracking on map
@freezed
sealed class VehicleModel with _$VehicleModel {
  const factory VehicleModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,

    /// Heading angle in degrees (0 = North, 90 = East, 180 = South, 270 = West)
    @Default(0.0) double heading,

    /// Speed in km/h
    @Default(0.0) double speed,
    @Default(VehicleStatus.available) VehicleStatus status,
    String? driverName,
    String? plateNumber,
    String? vehicleType,
    String? iconUrl,
    String? currentRouteId,
    DateTime? lastUpdated,
    Map<String, dynamic>? metadata,
  }) = _VehicleModel;

  const VehicleModel._();

  factory VehicleModel.fromJson(Map<String, dynamic> json) => _$VehicleModelFromJson(json);

  /// Get LatLng for flutter_map
  LatLng get latLng => LatLng(latitude, longitude);

  /// Get heading in radians (for rotation)
  double get headingRadians => heading * (3.141592653589793 / 180);

  /// Check if vehicle is moving
  bool get isMoving => speed > 0;

  /// Create a fake vehicle for testing
  static VehicleModel fake({String? id, String? name, double? latitude, double? longitude, double? heading}) =>
      VehicleModel(
        id: id ?? 'vehicle_1',
        name: name ?? 'Test Vehicle',
        latitude: latitude ?? 35.6892,
        longitude: longitude ?? 51.3890,
        heading: heading ?? 45.0,
        speed: 35.0,
        status: VehicleStatus.available,
        driverName: 'Driver 1',
        plateNumber: '12-ABC-345',
        vehicleType: 'Sedan',
        lastUpdated: DateTime.now(),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// User Location Model
// ═══════════════════════════════════════════════════════════════════════════

/// User's current location with accuracy info
@freezed
sealed class UserLocationModel with _$UserLocationModel {
  const factory UserLocationModel({
    required double latitude,
    required double longitude,
    @Default(0.0) double heading,
    @Default(0.0) double speed,
    @Default(0.0) double accuracy,
    @Default(0.0) double altitude,
    DateTime? timestamp,
  }) = _UserLocationModel;

  const UserLocationModel._();

  factory UserLocationModel.fromJson(Map<String, dynamic> json) => _$UserLocationModelFromJson(json);

  /// Get LatLng for flutter_map
  LatLng get latLng => LatLng(latitude, longitude);

  /// Get heading in radians
  double get headingRadians => heading * (3.141592653589793 / 180);
}
