# 🗺️ Map Feature Documentation

## Overview

The **Map Feature** provides a fully customizable, multi-layered mapping solution for Flutter applications using `flutter_map`, `latlong2`, and `geolocator` packages.

### Key Features

- ✅ **Multiple Map Templates** - Switch between 7 different map styles (OSM, Carto, ESRI)
- ✅ **User Location** - Real-time GPS tracking with accuracy indicator
- ✅ **POI Layer** - Points of Interest with category-based filtering
- ✅ **Routes Layer** - Custom routes with waypoints and polylines
- ✅ **Vehicles Layer** - Real-time vehicle tracking with proper heading/rotation
- ✅ **Layer Controls** - Toggle visibility of each layer independently
- ✅ **Responsive UI** - Info cards, controls, and overlays

---

## 📁 Folder Structure

```
lib/features/map_feature/
├── map_feature.dart              # Barrel exports
├── data/
│   ├── models/
│   │   └── map_models.dart       # All data models (POI, Route, Vehicle, etc.)
│   └── repositories/
│       └── mock_map_repositories.dart  # Mock implementations for demo
├── domain/
│   └── repositories/
│       └── map_repositories.dart # Abstract repository interfaces
└── presentation/
    ├── providers/
    │   ├── map_provider.dart     # Riverpod providers & StateNotifier
    │   └── map_state.dart        # Freezed state classes
    ├── screens/
    │   └── map_screen.dart       # Main map screen
    └── widgets/
        ├── layers/
        │   ├── user_location_layer.dart  # User location marker
        │   ├── poi_layer.dart            # POI markers & info card
        │   ├── route_layer.dart          # Route polylines & waypoints
        │   └── vehicle_layer.dart        # Vehicle markers with rotation
        ├── map_controls.dart             # Zoom, location, layer toggles
        └── map_template_selector.dart    # Map style switcher
```

---

## 🧩 Data Models

### MapTemplate (Enum)

Available map tile templates:

| Template | Description | URL |
|----------|-------------|-----|
| `openStreetMap` | Standard OSM tiles | tile.openstreetmap.org |
| `openTopoMap` | Topographic map | tile.opentopomap.org |
| `cartoLight` | Light theme | basemaps.cartocdn.com |
| `cartoDark` | Dark theme | basemaps.cartocdn.com |
| `cartoVoyager` | Voyager style | basemaps.cartocdn.com |
| `esriWorldStreetMap` | ESRI Street | arcgisonline.com |
| `esriWorldImagery` | Satellite imagery | arcgisonline.com |

### PoiModel

Point of Interest with category support:

```dart
@freezed
class PoiModel {
  String id;
  String name;
  double latitude;
  double longitude;
  PoiCategory category;
  String? description;
  String? address;
  String? phoneNumber;
  // ...
}
```

**Categories:** `restaurant`, `hotel`, `hospital`, `gasStation`, `parking`, `atm`, `pharmacy`, `shopping`, `attraction`, `other`

### RouteModel

Route with waypoints:

```dart
@freezed
class RouteModel {
  String id;
  String name;
  List<RouteWaypoint> waypoints;
  int color;           // ARGB color
  double strokeWidth;
  double? totalDistanceKm;
  int? estimatedTimeMinutes;
}
```

### VehicleModel

Vehicle with heading for directional display:

```dart
@freezed
class VehicleModel {
  String id;
  String name;
  double latitude;
  double longitude;
  double heading;      // 0°=North, 90°=East, 180°=South, 270°=West
  double speed;        // km/h
  VehicleStatus status;
  String? driverName;
  String? plateNumber;
  String? currentRouteId;
}
```

**Status:** `available`, `busy`, `offline`, `maintenance`

### UserLocationModel

Current user location:

```dart
@freezed
class UserLocationModel {
  double latitude;
  double longitude;
  double heading;
  double speed;
  double accuracy;
  DateTime? timestamp;
}
```

---

## 🎮 State Management

### MapState

Main state containing all map data:

```dart
@freezed
class MapState {
  // Map configuration
  MapTemplate currentTemplate;
  double zoom;
  LatLng? center;
  
  // User location
  UserLocationModel? userLocation;
  bool isLoadingLocation;
  bool isFollowingUser;
  
  // Layers
  List<PoiModel> pois;
  bool showPoisLayer;
  PoiModel? selectedPoi;
  
  List<RouteModel> routes;
  bool showRoutesLayer;
  RouteModel? selectedRoute;
  
  List<VehicleModel> vehicles;
  bool showVehiclesLayer;
  VehicleModel? selectedVehicle;
}
```

### MapStateNotifier

Available actions:

```dart
// Map
void setMapTemplate(MapTemplate template);
void setZoom(double zoom);
void moveToLocation(LatLng location);

// User Location
Future<void> getCurrentLocation();
Future<void> startFollowingUser();
void stopFollowingUser();

// POI
Future<void> loadPois();
void togglePoisLayer();
void setPoiCategoryFilter(Set<PoiCategory>? categories);
void selectPoi(PoiModel? poi);

// Routes
Future<void> loadRoutes();
void toggleRoutesLayer();
void selectRoute(RouteModel? route);

// Vehicles
Future<void> loadVehicles();
void startWatchingVehicles();
void stopWatchingVehicles();
void toggleVehiclesLayer();
void selectVehicle(VehicleModel? vehicle);
```

---

## 🚗 Vehicle Heading System

Vehicles rotate to point in their direction of movement:

```
       N (0°)
         ↑
         |
W (270°) ←——→ E (90°)
         |
         ↓
       S (180°)
```

### How It Works

1. **Heading in degrees** - Stored in `VehicleModel.heading`
2. **Converted to radians** - `headingRadians` getter
3. **Applied via Transform.rotate** - Rotates the vehicle icon

```dart
Transform.rotate(
  // Rotate based on heading (0° = North)
  // Subtract PI/2 because arrow icon points East by default
  angle: vehicle.headingRadians - (pi / 2),
  child: VehicleMarker(...),
)
```

### Visual Indicators

- **Green dot** - Vehicle is moving
- **Headlight effect** - Shows when moving
- **Status color** - Available (green), Busy (blue), Offline (grey)

---

## 📍 Layer System

### Layer Z-Order (bottom to top)

1. **Base Tiles** - Map background
2. **Routes** - Polylines
3. **POIs** - Point markers
4. **Vehicles** - Moving markers
5. **User Location** - GPS marker

### Toggling Layers

```dart
// Via provider
ref.read(mapStateProvider.notifier).togglePoisLayer();
ref.read(mapStateProvider.notifier).toggleRoutesLayer();
ref.read(mapStateProvider.notifier).toggleVehiclesLayer();
```

### Layer Widgets

```dart
// POI Layer
PoiLayer(
  pois: state.visiblePois,
  selectedPoi: state.selectedPoi,
  onPoiTap: notifier.selectPoi,
)

// Routes Layer
RoutesLayer(
  routes: state.routes,
  selectedRoute: state.selectedRoute,
  onRouteTap: notifier.selectRoute,
)

// Vehicles Layer
VehiclesLayer(
  vehicles: state.vehicles,
  selectedVehicle: state.selectedVehicle,
  onVehicleTap: notifier.selectVehicle,
  showLabels: true,
)

// User Location
UserLocationLayer(
  location: state.userLocation!,
  showAccuracyCircle: true,
)
```

---

## 🎨 Map Templates

### Switching Templates

```dart
// Change map style
ref.read(mapStateProvider.notifier).setMapTemplate(MapTemplate.cartoDark);
```

### Template Selector Widget

```dart
MapTemplateSelector(
  currentTemplate: state.currentTemplate,
  onTemplateChanged: notifier.setMapTemplate,
)
```

### Grid-Style Selector

```dart
MapTemplateGrid(
  currentTemplate: state.currentTemplate,
  onTemplateChanged: notifier.setMapTemplate,
)
```

---

## 🔌 API Integration

### Replace Mock Repositories

1. Create your API service:

```dart
// data/services/map_api_service.dart
@RestApi(baseUrl: 'https://api.example.com')
abstract class MapApiService {
  factory MapApiService(Dio dio) = _MapApiService;

  @GET('/pois')
  Future<List<PoiModel>> getPois();

  @GET('/routes')
  Future<List<RouteModel>> getRoutes();

  @GET('/vehicles')
  Future<List<VehicleModel>> getVehicles();
}
```

2. Create real repository implementation:

```dart
// data/repositories/map_repository_impl.dart
class PoiRepositoryImpl implements PoiRepository {
  final MapApiService _apiService;

  @override
  Future<List<PoiModel>> getPois(...) async {
    return await _apiService.getPois();
  }
}
```

3. Update the provider:

```dart
// presentation/providers/map_provider.dart
final poiRepositoryProvider = Provider<PoiRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final apiService = MapApiService(dio);
  return PoiRepositoryImpl(apiService);
});
```

---

## 🚀 Usage Example

### Add to Router

```dart
// app/router/routes.dart
GoRoute(
  path: '/map',
  builder: (context, state) => const MapScreen(),
),
```

### Navigate to Map

```dart
context.push('/map');
```

### Full Screen Map

```dart
import 'package:zero_setup_flutter/features/map_feature/map_feature.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MapScreen();
  }
}
```

---

## 📱 Permissions

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS

Add to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show your position on the map.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs location access to track your position.</string>
```

---

## 🎯 Best Practices

### 1. Memory Management

```dart
@override
void dispose() {
  notifier.stopWatchingVehicles();
  notifier.stopFollowingUser();
  super.dispose();
}
```

### 2. Error Handling

```dart
if (state.hasError) {
  showSnackBar(context, state.error!);
  notifier.clearError();
}
```

### 3. Performance

- Use `useMemoized` for MapController
- Toggle layers off when not needed
- Limit vehicle update frequency in production

### 4. Testing

```dart
// Create fake data
final fakePoi = PoiModel.fake(name: 'Test POI');
final fakeVehicle = VehicleModel.fake(heading: 90.0);
final fakeRoute = RouteModel.fake();
```

---

## 📝 Customization

### Custom POI Marker

```dart
class CustomPoiMarker extends StatelessWidget {
  final PoiModel poi;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // Your custom design
    );
  }
}
```

### Custom Vehicle Icon

Modify `_VehicleArrowPainter` in `vehicle_layer.dart` to change the vehicle shape.

### Custom Route Style

```dart
Polyline(
  points: route.polylinePoints,
  color: Color(route.color),
  strokeWidth: route.strokeWidth,
  isDotted: true,  // Add dots
  gradientColors: [Colors.blue, Colors.red],  // Gradient
)
```

---

## 🔧 Dependencies

```yaml
dependencies:
  flutter_map: ^8.2.2
  latlong2: ^0.9.1
  geolocator: ^14.0.2
  hooks_riverpod: ^3.0.3
  flutter_hooks: ^0.21.3+1
  freezed_annotation: ^3.1.0

dev_dependencies:
  freezed: ^3.2.3
  json_serializable: ^6.9.5
  build_runner: ^2.4.15
```

---

## 🏃 Running Code Generation

After modifying Freezed models:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or watch mode:

```bash
dart run build_runner watch --delete-conflicting-outputs
```
