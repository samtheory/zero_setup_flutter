import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:zero_setup_flutter/features/map_feature/data/models/map_models.dart';

/// Routes Layer Widget
/// Displays polyline routes with waypoint markers
class RoutesLayer extends StatelessWidget {
  final List<RouteModel> routes;
  final RouteModel? selectedRoute;
  final void Function(RouteModel route)? onRouteTap;

  const RoutesLayer({super.key, required this.routes, this.selectedRoute, this.onRouteTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Polylines
        PolylineLayer(
          polylines: routes.map((route) {
            final isSelected = selectedRoute?.id == route.id;
            return Polyline(
              points: route.polylinePoints,
              color: Color(route.color).withValues(alpha: isSelected ? 1.0 : 0.7),
              strokeWidth: isSelected ? route.strokeWidth + 2 : route.strokeWidth,
              borderColor: Colors.white.withValues(alpha: 0.5),
              borderStrokeWidth: isSelected ? 2 : 1,
            );
          }).toList(),
        ),
        // Waypoint markers for selected route
        if (selectedRoute != null)
          MarkerLayer(
            markers: selectedRoute!.waypoints.asMap().entries.map((entry) {
              final index = entry.key;
              final waypoint = entry.value;
              final isFirst = index == 0;
              final isLast = index == selectedRoute!.waypoints.length - 1;

              return Marker(
                point: waypoint.latLng,
                width: 40,
                height: 40,
                child: _WaypointMarker(
                  waypoint: waypoint,
                  isStart: isFirst,
                  isEnd: isLast,
                  index: index,
                  routeColor: Color(selectedRoute!.color),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

/// Individual waypoint marker
class _WaypointMarker extends StatelessWidget {
  final RouteWaypoint waypoint;
  final bool isStart;
  final bool isEnd;
  final int index;
  final Color routeColor;

  const _WaypointMarker({
    required this.waypoint,
    this.isStart = false,
    this.isEnd = false,
    required this.index,
    required this.routeColor,
  });

  @override
  Widget build(BuildContext context) {
    // Start marker
    if (isStart) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4)],
        ),
        child: const Center(child: Icon(Icons.play_arrow, color: Colors.white, size: 20)),
      );
    }

    // End marker
    if (isEnd) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4)],
        ),
        child: const Center(child: Icon(Icons.flag, color: Colors.white, size: 18)),
      );
    }

    // Intermediate waypoint
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: routeColor,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          '$index',
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Route Info Card - shown when a route is selected
class RouteInfoCard extends StatelessWidget {
  final RouteModel route;
  final VoidCallback? onClose;
  final VoidCallback? onStartNavigation;

  const RouteInfoCard({super.key, required this.route, this.onClose, this.onStartNavigation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Color(route.color).withValues(alpha: 0.1)),
                  child: Center(child: Icon(Icons.route, color: Color(route.color), size: 24)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${route.waypoints.length} waypoints',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: onClose),
              ],
            ),
            const Divider(height: 24),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.straighten,
                  value: route.totalDistanceKm != null ? '${route.totalDistanceKm!.toStringAsFixed(1)} km' : 'N/A',
                  label: 'Distance',
                ),
                _StatItem(
                  icon: Icons.timer,
                  value: route.estimatedTimeMinutes != null ? '${route.estimatedTimeMinutes} min' : 'N/A',
                  label: 'Est. Time',
                ),
                _StatItem(icon: Icons.location_on, value: '${route.waypoints.length}', label: 'Points'),
              ],
            ),
            // Description
            if (route.description != null) ...[
              const SizedBox(height: 16),
              Text(route.description!, style: Theme.of(context).textTheme.bodyMedium),
            ],
            const SizedBox(height: 16),
            // Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onStartNavigation,
                icon: const Icon(Icons.navigation),
                label: const Text('Start Navigation'),
                style: ElevatedButton.styleFrom(backgroundColor: Color(route.color), foregroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey)),
      ],
    );
  }
}

/// Route List Tile for route selection
class RouteListTile extends StatelessWidget {
  final RouteModel route;
  final bool isSelected;
  final VoidCallback? onTap;

  const RouteListTile({super.key, required this.route, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(route.color).withValues(alpha: 0.2),
          border: Border.all(color: Color(route.color), width: 2),
        ),
        child: Icon(Icons.route, color: Color(route.color), size: 20),
      ),
      title: Text(route.name, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(
        route.totalDistanceKm != null
            ? '${route.totalDistanceKm!.toStringAsFixed(1)} km • ${route.estimatedTimeMinutes ?? '?'} min'
            : '${route.waypoints.length} waypoints',
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Color(route.color))
          : const Icon(Icons.arrow_forward_ios, size: 16),
      selected: isSelected,
      onTap: onTap,
    );
  }
}
