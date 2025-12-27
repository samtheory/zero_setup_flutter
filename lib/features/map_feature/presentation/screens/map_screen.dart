import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/models/map_models.dart';
import '../providers/map_provider.dart';
import '../providers/map_state.dart';
import '../widgets/layers/poi_layer.dart';
import '../widgets/layers/route_layer.dart';
import '../widgets/layers/user_location_layer.dart';
import '../widgets/layers/vehicle_layer.dart';
import '../widgets/map_controls.dart';
import '../widgets/map_template_selector.dart';

/// Main Map Screen
/// Demonstrates:
/// - FlutterMap with customizable tile templates
/// - User location tracking
/// - POI layer with markers
/// - Routes layer with polylines
/// - Vehicles layer with rotation based on heading
/// - Layer visibility controls
/// - Map style switching
class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapStateProvider);
    final notifier = ref.read(mapStateProvider.notifier);

    // Map controller
    final mapController = useMemoized(() => MapController());

    // UI state
    final showLayerPanel = useState(false);
    final showTemplateSelector = useState(false);
    final showCustomRouteOnMap = useState(true);
    // Initialize map on first build
    useEffect(() {
      talker.info('🗺️ MapScreen mounted');
      Future.microtask(() async {
        await notifier.initializeMap();
        notifier.startWatchingVehicles();
      });
      return () {
        talker.info('🗺️ MapScreen disposed');
        notifier.stopWatchingVehicles();
        notifier.stopFollowingUser();
      };
    }, []);

    // Sync map controller with state
    useEffect(() {
      if (state.isMapReady && state.center != null) {
        try {
          mapController.move(state.center!, state.zoom);
        } catch (_) {
          // Controller might not be ready yet
        }
      }
      return null;
    }, [state.center, state.zoom, state.isMapReady]);

    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: state.effectiveCenter,
              initialZoom: state.zoom,
              minZoom: 3.0,
              maxZoom: 18.0,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture && state.isFollowingUser) {
                  notifier.stopFollowingUser();
                }
              },
              onTap: (tapPosition, latLng) {
                // Clear selections when tapping on map
                notifier.clearSelections();
                showLayerPanel.value = false;
                showTemplateSelector.value = false;
              },
            ),
            children: [
              // Base tile layer
              TileLayer(
                urlTemplate: state.currentTemplate.urlTemplate,
                userAgentPackageName: 'com.example.zero_setup_flutter',
                maxZoom: 18,
              ),

              // Routes layer
              if (state.showRoutesLayer && state.routes.isNotEmpty && showCustomRouteOnMap.value)
                RoutesLayer(routes: state.routes, selectedRoute: state.selectedRoute, onRouteTap: notifier.selectRoute),

              // POI layer
              if (state.showPoisLayer && state.visiblePois.isNotEmpty)
                PoiLayer(pois: state.visiblePois, selectedPoi: state.selectedPoi, onPoiTap: notifier.selectPoi),

              // Vehicles layer
              if (state.showVehiclesLayer && state.vehicles.isNotEmpty)
                VehiclesLayer(
                  vehicles: state.vehicles,
                  selectedVehicle: state.selectedVehicle,
                  onVehicleTap: notifier.selectVehicle,
                  showLabels: true,
                ),

              // User location layer
              if (state.userLocation != null)
                UserLocationLayer(
                  location: state.userLocation!,
                  showAccuracyCircle: true,
                  showHeadingIndicator: state.isFollowingUser,
                ),

              // Attribution
              RichAttributionWidget(
                alignment: AttributionAlignment.bottomLeft,
                attributions: [TextSourceAttribution(state.currentTemplate.attribution)],
              ),
            ],
          ),

          // Top bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                // Back button
                _CircleButton(icon: Icons.arrow_back, onPressed: () => Navigator.of(context).pop()),
                const Spacer(),
                // Template selector
                MapTemplateSelector(currentTemplate: state.currentTemplate, onTemplateChanged: notifier.setMapTemplate),
              ],
            ),
          ),

          // Right controls
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 70,
            child: MapControls(
              isShowingCustomRoute: showCustomRouteOnMap.value,
              onToggleRoutes: () => showCustomRouteOnMap.value = !showCustomRouteOnMap.value,
              currentZoom: state.zoom,
              minZoom: 3.0,
              maxZoom: 18.0,
              isFollowingLocation: state.isFollowingUser,
              isLoadingLocation: state.isLoadingLocation,
              onZoomIn: () {
                final newZoom = (state.zoom + 1).clamp(3.0, 18.0);
                mapController.move(state.effectiveCenter, newZoom);
                notifier.setZoom(newZoom);
              },
              onZoomOut: () {
                final newZoom = (state.zoom - 1).clamp(3.0, 18.0);
                mapController.move(state.effectiveCenter, newZoom);
                notifier.setZoom(newZoom);
              },
              onCenterLocation: () async {
                if (state.isFollowingUser) {
                  notifier.stopFollowingUser();
                } else {
                  await notifier.getCurrentLocation();
                  if (state.userLocation != null) {
                    mapController.move(state.userLocation!.latLng, state.zoom);
                  }
                  notifier.startFollowingUser();
                }
              },
              onToggleLayers: () {
                showLayerPanel.value = !showLayerPanel.value;
                showTemplateSelector.value = false;
              },
            ),
          ),

          // Layer panel
          if (showLayerPanel.value)
            Positioned(
              right: 70,
              top: MediaQuery.of(context).padding.top + 120,
              child: LayerTogglePanel(
                showUserLocation: state.userLocation != null,
                showPois: state.showPoisLayer,
                showRoutes: state.showRoutesLayer,
                showVehicles: state.showVehiclesLayer,
                onUserLocationChanged: (_) async {
                  if (state.userLocation == null) {
                    await notifier.getCurrentLocation();
                  }
                },
                onPoisChanged: (_) => notifier.togglePoisLayer(),
                onRoutesChanged: (_) => notifier.toggleRoutesLayer(),
                onVehiclesChanged: (_) => notifier.toggleVehiclesLayer(),
                onClose: () => showLayerPanel.value = false,
              ),
            ),

          // POI category filter
          if (state.showPoisLayer)
            Positioned(
              top: MediaQuery.of(context).padding.top + 70,
              left: 16,
              right: 80,
              child: PoiCategoryFilter(
                selectedCategories: state.poiCategoryFilter,
                onFilterChanged: notifier.setPoiCategoryFilter,
              ),
            ),

          // Bottom info cards
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomInfoArea(state: state, notifier: notifier),
          ),

          // Loading overlay
          if (state.isAnyLoading && !state.isMapReady)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.white54,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

          // Error snackbar trigger
          if (state.hasError)
            Positioned(
              bottom: 100,
              left: 16,
              right: 16,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(state.error ?? 'An error occurred', style: const TextStyle(color: Colors.red)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: notifier.clearError,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Bottom area for info cards
class _BottomInfoArea extends HookConsumerWidget {
  final MapState state;
  final MapStateNotifier notifier;

  const _BottomInfoArea({required this.state, required this.notifier});

  @override
  Widget build(BuildContext context, ref) {
    // Show POI info card
    if (state.selectedPoi != null) {
      return PoiInfoCard(
        poi: state.selectedPoi!,
        onClose: () => notifier.selectPoi(null),
        onNavigate: () {
          talker.info('🧭 Navigate to ${state.selectedPoi!.name}');
          final start = state.userLocation?.latLng ?? LatLng(0, 0);
          ref.read(vehicleRepositoryProvider).getRouteForNavigation(start, state.selectedPoi!.latLng);
          // vehicleRepositoryProvider
          talker.info('🧭 Geo ${state.selectedPoi!.latLng}');
          // TODO: Implement navigation
        },
      );
    }

    // Show route info card
    if (state.selectedRoute != null) {
      return RouteInfoCard(
        route: state.selectedRoute!,
        onClose: () => notifier.selectRoute(null),
        onStartNavigation: () {
          talker.info('🧭 Start navigation on ${state.selectedRoute!.name}');
          // TODO: Implement navigation
        },
      );
    }

    // Show vehicle info card
    if (state.selectedVehicle != null) {
      return VehicleInfoCard(
        vehicle: state.selectedVehicle!,
        onClose: () => notifier.selectVehicle(null),
        onTrack: () {
          notifier.trackVehicle(state.selectedVehicle!.id);
        },
        onShowRoute: () {
          // Show route if vehicle is on one
          if (state.selectedVehicle!.currentRouteId != null) {
            final route = state.routes.firstWhere(
              (r) => r.id == state.selectedVehicle!.currentRouteId,
              orElse: () => state.routes.first,
            );
            notifier.selectRoute(route);
          }
        },
      );
    }

    return const SizedBox.shrink();
  }
}

/// Circular button widget  -> back button
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: Theme.of(context).cardColor,
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(padding: const EdgeInsets.all(12), child: Icon(icon, size: 24)),
      ),
    );
  }
}
