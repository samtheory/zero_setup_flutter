import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:zero_setup_flutter/features/map_feature/map_feature.dart';


/// Layer widget that displays navigation route on the map
class NavigationLayer extends StatelessWidget {
  const NavigationLayer({
    super.key,
    required this.navigationState,
    this.routeColor = Colors.blue,
    this.routeWidth = 6.0,
    this.routeBorderColor = const Color(0xFF1565C0),
    this.routeBorderWidth = 8.0,
    this.showStepMarkers = true,
    this.showOriginDestination = true,
    this.onStepTapped,
  });

  final NavigationState navigationState;
  final Color routeColor;
  final double routeWidth;
  final Color routeBorderColor;
  final double routeBorderWidth;
  final bool showStepMarkers;
  final bool showOriginDestination;
  final void Function(int stepIndex)? onStepTapped;

  @override
  Widget build(BuildContext context) {
    if (!navigationState.hasRoute) {
      return const SizedBox.shrink();
    }

    final routePoints = navigationState.routePoints;
    final steps = navigationState.steps;
    final navigationData = navigationState.navigationData!;

    return Stack(
      children: [
        // Route polyline layer (border/outline)
        PolylineLayer(
          polylines: [
            Polyline(
              points: routePoints,
              strokeWidth: routeBorderWidth,
              color: routeBorderColor,
              borderStrokeWidth: 1,
              borderColor: routeBorderColor.withOpacity(0.3),
            ),
          ],
        ),
        // Route polyline layer (main)
        PolylineLayer(
          polylines: [Polyline(points: routePoints, strokeWidth: routeWidth, color: routeColor)],
        ),
        // Step markers
        if (showStepMarkers) MarkerLayer(markers: _buildStepMarkers(steps, context)),
        // Origin and Destination markers
        if (showOriginDestination)
          MarkerLayer(
            markers: [
              _buildOriginMarker(navigationData.origin, navigationData.originName),
              _buildDestinationMarker(navigationData.destination, navigationData.destinationName),
            ],
          ),
      ],
    );
  }

  /// Build markers for each navigation step (turn indicators)
  List<Marker> _buildStepMarkers(List<NavigationStep> steps, BuildContext context) {
    final markers = <Marker>[];

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];

      // Skip depart and arrive - they have their own markers
      if (step.maneuverType == ManeuverType.depart || step.maneuverType == ManeuverType.arrive) {
        continue;
      }

      // Skip continue/new name steps (minor turns)
      if (step.maneuverType == ManeuverType.continueOn || step.maneuverType == ManeuverType.newName) {
        continue;
      }

      final isHighlighted = navigationState.highlightedStepIndex == i;

      markers.add(
        Marker(
          point: step.location,
          width: isHighlighted ? 36 : 28,
          height: isHighlighted ? 36 : 28,
          child: GestureDetector(
            onTap: () => onStepTapped?.call(i),
            child: _StepMarkerWidget(step: step, isHighlighted: isHighlighted),
          ),
        ),
      );
    }

    return markers;
  }

  /// Build origin marker (green)
  Marker _buildOriginMarker(LatLng origin, String name) {
    return Marker(
      point: origin,
      width: 50,
      height: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: const Icon(Icons.trip_origin, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
            ),
            child: const Text(
              'Start',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  /// Build destination marker (red)
  Marker _buildDestinationMarker(LatLng destination, String name) {
    return Marker(
      point: destination,
      width: 50,
      height: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: const Icon(Icons.flag, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
            ),
            child: Text(
              name.length > 10 ? '${name.substring(0, 10)}...' : name,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for individual step marker (turn indicator)
class _StepMarkerWidget extends StatelessWidget {
  const _StepMarkerWidget({required this.step, required this.isHighlighted});

  final NavigationStep step;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final size = isHighlighted ? 36.0 : 28.0;
    final iconSize = isHighlighted ? 20.0 : 16.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isHighlighted ? step.color : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: step.color, width: isHighlighted ? 3 : 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isHighlighted ? 0.4 : 0.2),
            blurRadius: isHighlighted ? 8 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Transform.rotate(
          angle: _getRotationAngle(),
          child: Icon(step.icon, color: isHighlighted ? Colors.white : step.color, size: iconSize),
        ),
      ),
    );
  }

  /// Get rotation angle for directional icons based on bearing
  double _getRotationAngle() {
    // Only rotate directional icons
    switch (step.maneuverType) {
      case ManeuverType.straight:
      case ManeuverType.continueOn:
      case ManeuverType.newName:
        // Rotate straight icon based on bearing
        return (step.bearingAfter * math.pi / 180);
      default:
        return 0;
    }
  }
}

/// Animated navigation route layer with gradient effect
class AnimatedNavigationLayer extends StatefulWidget {
  const AnimatedNavigationLayer({
    super.key,
    required this.navigationState,
    this.completedColor = Colors.grey,
    this.remainingColor = Colors.blue,
    this.routeWidth = 6.0,
  });

  final NavigationState navigationState;
  final Color completedColor;
  final Color remainingColor;
  final double routeWidth;

  @override
  State<AnimatedNavigationLayer> createState() => _AnimatedNavigationLayerState();
}

class _AnimatedNavigationLayerState extends State<AnimatedNavigationLayer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.navigationState.hasRoute) {
      return const SizedBox.shrink();
    }

    final routePoints = widget.navigationState.routePoints;
    final progress = widget.navigationState.navigationData?.progress ?? 0;

    // Split route into completed and remaining parts
    final splitIndex = (routePoints.length * progress).floor();
    final completedPoints = routePoints.sublist(0, splitIndex + 1);
    final remainingPoints = routePoints.sublist(splitIndex);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Completed portion (grey)
            if (completedPoints.length > 1)
              PolylineLayer(
                polylines: [
                  Polyline(points: completedPoints, strokeWidth: widget.routeWidth, color: widget.completedColor),
                ],
              ),
            // Remaining portion (animated blue)
            if (remainingPoints.length > 1)
              PolylineLayer(
                polylines: [
                  Polyline(points: remainingPoints, strokeWidth: widget.routeWidth, color: widget.remainingColor),
                ],
              ),
          ],
        );
      },
    );
  }
}
