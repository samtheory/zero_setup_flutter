# 🗺️ Map SDK Implementation Roadmap

## Overview

This roadmap outlines the implementation of a comprehensive Map SDK feature for the Zero Setup Flutter project. Based on the analysis of requirements and current architecture, we'll implement a map solution that provides:

- ✅ User location display
- ✅ Hub visualization from API
- ✅ In-app zoom/navigation
- ✅ External navigation (Google Maps/Waze/Neshan)
- ✅ Custom path drawing (even in unmapped areas)
- ✅ Full customization and active community support

## 🎯 Final Technology Stack Decision

**Primary Choice: flutter_map + geolocator + url_launcher**

**Rationale:**
- Maximum customization freedom with Flutter widgets
- Active community and extensive documentation
- Perfect fit for feature-based architecture
- Easy integration with existing Riverpod + Dio setup
- Support for custom paths without official routes
- Future-ready for enterprise scaling

**Backup Option: Mapbox Maps SDK** (for enterprise styling needs)

---

## 📋 Implementation Roadmap

### Phase 1: Foundation Setup (Week 1)

#### 1.1 Dependencies Addition
Add to `pubspec.yaml`:

```yaml
dependencies:
  # Map SDK
  flutter_map: ^7.0.2
  latlong2: ^0.9.1
  
  # Location Services
  geolocator: ^13.0.1
  geocoding: ^3.0.0
  
  # Navigation
  url_launcher: ^6.3.1
  
  # UI Enhancements
  flutter_compass: ^0.8.0
  flutter_map_marker_cluster: ^4.0.0
  
dev_dependencies:
  # Testing
  patrol: ^3.0.0
```

#### 1.2 Permissions Configuration

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show your position on the map</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to provide navigation features</string>
```

#### 1.3 API Contract Design

**Hubs API Response:**
```json
{
  "hubs": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "latitude": "double",
      "longitude": "double",
      "type": "hub|station|point",
      "category": "string",
      "isActive": "boolean"
    }
  ]
}
```

**Routes API Response:**
```json
{
  "route": {
    "id": "string",
    "name": "string",
    "points": [
      {"lat": "double", "lon": "double"}
    ],
    "distance": "double",
    "duration": "int"
  }
}
```

### Phase 2: Core Architecture (Week 2)

#### 2.1 Feature Structure Creation

```
lib/features/map/
├── data/
│   ├── models/
│   │   ├── hub_model.dart
│   │   ├── route_model.dart
│   │   └── location_model.dart
│   ├── repositories/
│   │   ├── map_repository_impl.dart
│   │   └── location_repository_impl.dart
│   └── services/
│       ├── map_api.dart
│       └── location_service.dart
├── domain/
│   ├── entities/
│   │   ├── hub_entity.dart
│   │   ├── route_entity.dart
│   │   └── location_entity.dart
│   ├── repositories/
│   │   ├── map_repository.dart
│   │   └── location_repository.dart
│   └── usecases/
│       ├── get_hubs_usecase.dart
│       ├── get_user_location_usecase.dart
│       ├── calculate_route_usecase.dart
│       └── navigate_to_hub_usecase.dart
└── presentation/
    ├── providers/
    │   ├── map_provider.dart
    │   ├── location_provider.dart
    │   └── navigation_provider.dart
    ├── screens/
    │   ├── map_screen.dart
    │   └── hub_details_screen.dart
    ├── widgets/
    │   ├── map_view.dart
    │   ├── hub_marker.dart
    │   ├── location_marker.dart
    │   ├── navigation_bottom_sheet.dart
    │   └── route_overlay.dart
    └── controllers/
        ├── map_controller.dart
        └── location_controller.dart
```

#### 2.2 Core Providers Setup

**Location Provider** (`presentation/providers/location_provider.dart`):
```dart
@riverpod
class LocationNotifier extends _$LocationNotifier {
  @override
  Future<LocationEntity> build() async {
    final repository = ref.watch(locationRepositoryProvider);
    return repository.getCurrentLocation();
  }

  Future<void> updateLocation() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.watch(locationRepositoryProvider);
      final location = await repository.getCurrentLocation();
      state = AsyncValue.data(location);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
```

**Map Provider** (`presentation/providers/map_provider.dart`):
```dart
@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  MapState build() {
    return MapState.initial();
  }

  Future<void> loadHubs() async {
    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.watch(mapRepositoryProvider);
      final hubs = await repository.getHubs();
      state = state.copyWith(hubs: hubs, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void selectHub(HubEntity hub) {
    state = state.copyWith(selectedHub: hub);
  }
}
```

#### 2.3 Repository Implementation

**Map Repository** (`data/repositories/map_repository_impl.dart`):
```dart
class MapRepositoryImpl implements MapRepository {
  final MapApi _api;

  MapRepositoryImpl(this._api);

  @override
  Future<List<HubEntity>> getHubs() async {
    final response = await _api.getHubs();
    return response.hubs.map((model) => model.toEntity()).toList();
  }

  @override
  Future<RouteEntity> calculateRoute(LatLng start, LatLng end) async {
    final response = await _api.getRoute(start, end);
    return response.route.toEntity();
  }
}
```

### Phase 3: UI Implementation (Week 3)

#### 3.1 Map Screen

**Map Screen** (`presentation/screens/map_screen.dart`):
```dart
class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapNotifierProvider);
    final locationState = ref.watch(locationNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(
        children: [
          MapView(
            hubs: mapState.hubs,
            userLocation: locationState.valueOrNull,
            onHubTap: (hub) => _showHubDetails(context, ref, hub),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => ref.read(locationNotifierProvider.notifier).updateLocation(),
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  void _showHubDetails(BuildContext context, WidgetRef ref, HubEntity hub) {
    showModalBottomSheet(
      context: context,
      builder: (context) => HubDetailsSheet(hub: hub),
    );
  }
}
```

#### 3.2 Map View Widget

**Map View** (`presentation/widgets/map_view.dart`):
```dart
class MapView extends HookConsumerWidget {
  const MapView({
    super.key,
    required this.hubs,
    required this.userLocation,
    required this.onHubTap,
  });

  final List<HubEntity> hubs;
  final LocationEntity? userLocation;
  final Function(HubEntity) onHubTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = MapController();

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: userLocation?.toLatLng() ?? LatLng(35.6892, 51.3890), // Tehran
        zoom: 13.0,
        maxZoom: 18.0,
        minZoom: 3.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.zero_setup_flutter',
        ),
        if (userLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: userLocation!.toLatLng(),
                builder: (context) => const LocationMarker(),
              ),
            ],
          ),
        MarkerLayer(
          markers: hubs.map((hub) => Marker(
            point: hub.toLatLng(),
            builder: (context) => HubMarker(
              hub: hub,
              onTap: () => onHubTap(hub),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
```

#### 3.3 Navigation Integration

**Navigation Service** (`data/services/navigation_service.dart`):
```dart
class NavigationService {
  static Future<void> openInGoogleMaps(LatLng destination) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  static Future<void> openInWaze(LatLng destination) async {
    final url = 'waze://?ll=${destination.latitude},${destination.longitude}&navigate=yes';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Fallback to Google Maps
      await openInGoogleMaps(destination);
    }
  }

  static Future<void> openInNeshan(LatLng destination) async {
    final url = 'neshan://?lat=${destination.latitude}&lng=${destination.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      await openInGoogleMaps(destination);
    }
  }
}
```

### Phase 4: Advanced Features (Week 4)

#### 4.1 Custom Route Drawing

**Route Overlay** (`presentation/widgets/route_overlay.dart`):
```dart
class RouteOverlay extends StatelessWidget {
  const RouteOverlay({super.key, required this.route});

  final RouteEntity route;

  @override
  Widget build(BuildContext context) {
    return PolylineLayer(
      polylines: [
        Polyline(
          points: route.points.map((point) => LatLng(point.lat, point.lon)).toList(),
          color: Colors.blue,
          strokeWidth: 4.0,
        ),
      ],
    );
  }
}
```

#### 4.2 Clustering for Performance

**Clustered Map View**:
```dart
FlutterMap(
  children: [
    TileLayer(...),
    MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        markers: hubMarkers,
        builder: (context, markers) => ClusterWidget(markers: markers),
      ),
    ),
  ],
)
```

#### 4.3 Offline Support (Future)

**Tile Caching Strategy**:
- Implement tile caching with `flutter_map_tile_caching`
- Pre-cache tiles for offline use
- Fallback to cached tiles when offline

### Phase 5: Testing & Quality Assurance (Week 5)

#### 5.1 Unit Tests

**Repository Tests**:
```dart
void main() {
  late MockMapApi mockApi;
  late MapRepositoryImpl repository;

  setUp(() {
    mockApi = MockMapApi();
    repository = MapRepositoryImpl(mockApi);
  });

  group('MapRepositoryImpl', () {
    test('getHubs returns list of hubs', () async {
      when(() => mockApi.getHubs()).thenAnswer((_) async => mockHubsResponse);

      final result = await repository.getHubs();

      expect(result, isA<List<HubEntity>>());
      expect(result.length, 2);
    });
  });
}
```

#### 5.2 Widget Tests

**Map Screen Test**:
```dart
void main() {
  testWidgets('MapScreen displays map and hubs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          mapNotifierProvider.overrideWith(mockMapNotifier),
        ],
        child: const MaterialApp(home: MapScreen()),
      ),
    );

    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.byType(MarkerLayer), findsWidgets);
  });
}
```

#### 5.3 Integration Tests with Patrol

**Navigation Flow Test**:
```dart
void main() {
  patrolTest(
    'Navigate to hub and open external navigation',
    ($) async {
      await $.pumpWidgetAndSettle(const MyApp());

      await $('Map').tap();
      await $('Hub Marker').tap();
      await $('Navigate').tap();
      await $('Google Maps').tap();

      // Verify external app opened
      expect($('External navigation opened'), findsOneWidget);
    },
  );
}
```

#### 5.4 E2E Test Scenarios

1. **Location Permission Flow**
2. **Hub Loading and Display**
3. **Hub Selection and Details**
4. **External Navigation Options**
5. **Custom Route Drawing**
6. **Offline Mode Handling**

### Phase 6: Documentation & Deployment (Week 6)

#### 6.1 Feature Documentation

**Map Feature README** (`docs/features/map.md`):
- API contracts
- Usage examples
- Customization options
- Troubleshooting

#### 6.2 Performance Optimization

**Optimization Checklist**:
- [ ] Marker clustering for large datasets
- [ ] Tile caching implementation
- [ ] Lazy loading for distant hubs
- [ ] Memory management for map controllers
- [ ] Battery optimization for location updates

#### 6.3 Production Readiness

**Production Checklist**:
- [ ] Error handling for network failures
- [ ] Loading states for all operations
- [ ] Offline fallback strategies
- [ ] Analytics integration
- [ ] Performance monitoring

---

## 🔄 Future Enhancements

### Phase 7: Advanced Features (Month 2+)

1. **Real-time Features**
   - Live user tracking
   - Real-time hub updates
   - WebSocket integration

2. **Advanced Routing**
   - Multi-stop routes
   - Traffic-aware routing
   - Alternative route suggestions

3. **Enterprise Features**
   - Custom tile servers
   - Advanced theming
   - Heatmaps and analytics

4. **Migration Path to Mapbox**
   - Abstraction layer for easy migration
   - Feature parity assessment
   - Gradual migration strategy

---

## 📊 Success Metrics

- ✅ Map loads within 2 seconds
- ✅ Location accuracy within 10 meters
- ✅ Smooth 60fps performance
- ✅ 99% test coverage
- ✅ Zero crashes in production
- ✅ Active community contributions

---

## 🚀 Quick Start Commands

```bash
# Add dependencies
flutter pub add flutter_map latlong2 geolocator url_launcher

# Generate code
flutter pub run build_runner build

# Run tests
flutter test
patrol test

# Build for production
flutter build apk --release
```

This roadmap provides a comprehensive, phased approach to implementing a production-ready Map SDK feature that meets all requirements while maintaining code quality and architectural integrity.</content>
<parameter name="filePath">e:\Projects\______ALTERS_____\__Template__Zone\zero_setup_flutter\docs\analyze\roadmap_map_sdk.md