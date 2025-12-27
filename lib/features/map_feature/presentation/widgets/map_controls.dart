import 'package:flutter/material.dart';

/// Map Controls Widget
/// Provides zoom, compass, location, and layer toggle buttons
class MapControls extends StatelessWidget {
  final VoidCallback? onZoomIn;
  final VoidCallback? onZoomOut;
  final VoidCallback? onCenterLocation;
  final VoidCallback? onToggleLayers;
  final VoidCallback? onToggleRoutes;
  final VoidCallback? onToggleMapStyle;

  final bool isFollowingLocation;
  final bool isShowingCustomRoute;
  final bool isLoadingLocation;
  final double? currentZoom;
  final double minZoom;
  final double maxZoom;

  const MapControls({
    super.key,
    this.isShowingCustomRoute = false,
    this.onZoomIn,
    this.onToggleRoutes,
    this.onZoomOut,
    this.onCenterLocation,
    this.onToggleLayers,
    this.onToggleMapStyle,
    this.isFollowingLocation = false,
    this.isLoadingLocation = false,
    this.currentZoom,
    this.minZoom = 1.0,
    this.maxZoom = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Map style button
        if (onToggleMapStyle != null) ...[
          _ControlButton(icon: Icons.layers, onPressed: onToggleMapStyle, tooltip: 'Map Style'),
          const SizedBox(height: 8),
        ],
        // Layers toggle
        if (onToggleLayers != null) ...[
          _ControlButton(icon: Icons.filter_list, onPressed: onToggleLayers, tooltip: 'Toggle Layers'),
          const SizedBox(height: 8),
        ],

        if (onToggleRoutes != null) ...[
          _ControlButton(
            isActive: isShowingCustomRoute,
            icon: Icons.route,
            onPressed: onToggleRoutes,
            tooltip: 'Toggle Routes',
          ),
          const SizedBox(height: 8),
        ],

        // Zoom controls
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ControlButton(
                icon: Icons.add,
                onPressed: currentZoom != null && currentZoom! >= maxZoom ? null : onZoomIn,
                tooltip: 'Zoom In',
                showShadow: false,
              ),
              Container(width: 40, height: 1, color: Colors.grey.shade300),
              _ControlButton(
                icon: Icons.remove,
                onPressed: currentZoom != null && currentZoom! <= minZoom ? null : onZoomOut,
                tooltip: 'Zoom Out',
                showShadow: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Location button
        _ControlButton(
          icon: isFollowingLocation ? Icons.gps_fixed : Icons.gps_not_fixed,
          onPressed: isLoadingLocation ? null : onCenterLocation,
          tooltip: 'My Location',
          isActive: isFollowingLocation,
          isLoading: isLoadingLocation,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool showShadow;
  final bool isActive;
  final bool isLoading;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.showShadow = true,
    this.isActive = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 40,
        height: 40,
        decoration: showShadow
            ? BoxDecoration(
                color: isActive ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)],
              )
            : null,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isActive ? Colors.white : Theme.of(context).primaryColor,
                      ),
                    )
                  : Icon(
                      icon,
                      size: 20,
                      color: onPressed == null
                          ? Colors.grey.shade400
                          : isActive
                          ? Colors.blue
                          : Colors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compass Widget
/// Shows north direction and allows resetting map rotation
class MapCompass extends StatelessWidget {
  final double rotation; // In radians
  final VoidCallback? onPressed;

  const MapCompass({super.key, required this.rotation, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Only show compass when map is rotated
    if (rotation.abs() < 0.01) {
      return const SizedBox.shrink();
    }

    return Tooltip(
      message: 'Reset North',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)],
          ),
          child: Transform.rotate(
            angle: -rotation,
            child: CustomPaint(size: const Size(40, 40), painter: _CompassPainter()),
          ),
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    // North arrow (red)
    final northPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final northPath = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..lineTo(center.dx - 6, center.dy)
      ..lineTo(center.dx + 6, center.dy)
      ..close();

    canvas.drawPath(northPath, northPaint);

    // South arrow (grey)
    final southPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final southPath = Path()
      ..moveTo(center.dx, center.dy + radius)
      ..lineTo(center.dx - 6, center.dy)
      ..lineTo(center.dx + 6, center.dy)
      ..close();

    canvas.drawPath(southPath, southPaint);

    // N label
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'N',
        style: TextStyle(color: Colors.red, fontSize: 8, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, 2));
  }

  @override
  bool shouldRepaint(_CompassPainter oldDelegate) => false;
}

/// Layer Toggle Panel
/// Quick toggles for showing/hiding map layers
class LayerTogglePanel extends StatelessWidget {
  final bool showUserLocation;
  final bool showPois;
  final bool showRoutes;
  final bool showVehicles;
  final ValueChanged<bool> onUserLocationChanged;
  final ValueChanged<bool> onPoisChanged;
  final ValueChanged<bool> onRoutesChanged;
  final ValueChanged<bool> onVehiclesChanged;
  final VoidCallback? onClose;

  const LayerTogglePanel({
    super.key,
    required this.showUserLocation,
    required this.showPois,
    required this.showRoutes,
    required this.showVehicles,
    required this.onUserLocationChanged,
    required this.onPoisChanged,
    required this.onRoutesChanged,
    required this.onVehiclesChanged,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Map Layers', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              if (onClose != null)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          const SizedBox(height: 8),
          _LayerToggle(
            icon: Icons.my_location,
            label: 'My Location',
            value: showUserLocation,
            onChanged: onUserLocationChanged,
            color: Colors.blue,
          ),
          _LayerToggle(
            icon: Icons.place,
            label: 'Points of Interest',
            value: showPois,
            onChanged: onPoisChanged,
            color: Colors.orange,
          ),
          _LayerToggle(
            icon: Icons.route,
            label: 'Routes',
            value: showRoutes,
            onChanged: onRoutesChanged,
            color: Colors.green,
          ),
          _LayerToggle(
            icon: Icons.directions_car,
            label: 'Vehicles',
            value: showVehicles,
            onChanged: onVehiclesChanged,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _LayerToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color color;

  const _LayerToggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: value ? color : Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: value ? null : Colors.grey)),
          ),
          Switch(value: value, onChanged: onChanged, activeThumbColor: color),
        ],
      ),
    );
  }
}

/// Scale Bar Widget
/// Shows distance scale on the map
class MapScaleBar extends StatelessWidget {
  final double metersPerPixel;
  final double width;

  const MapScaleBar({super.key, required this.metersPerPixel, this.width = 100});

  @override
  Widget build(BuildContext context) {
    final totalMeters = metersPerPixel * width;
    final (displayValue, unit) = _formatDistance(totalMeters);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            height: 4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Expanded(child: Container(color: Colors.black)),
                Expanded(child: Container(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text('$displayValue $unit', style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  (String, String) _formatDistance(double meters) {
    if (meters >= 1000) {
      final km = meters / 1000;
      return (km.toStringAsFixed(km < 10 ? 1 : 0), 'km');
    }
    return (meters.toStringAsFixed(0), 'm');
  }
}
