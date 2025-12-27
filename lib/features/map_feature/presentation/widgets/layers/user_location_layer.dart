import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:zero_setup_flutter/features/map_feature/data/models/map_models.dart';

/// User Location Layer Widget
/// Displays the user's current location with accuracy circle and heading indicator
class UserLocationLayer extends StatelessWidget {
  final UserLocationModel location;
  final bool showAccuracyCircle;
  final bool showHeadingIndicator;

  const UserLocationLayer({
    super.key,
    required this.location,
    this.showAccuracyCircle = true,
    this.showHeadingIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: location.latLng,
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Accuracy circle
              if (showAccuracyCircle && location.accuracy > 0)
                Container(
                  width: _accuracyToPixels(location.accuracy),
                  height: _accuracyToPixels(location.accuracy),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 1),
                  ),
                ),
              // Heading indicator
              if (showHeadingIndicator && location.heading != 0)
                Transform.rotate(
                  angle: location.headingRadians,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue.withValues(alpha: 0.3), Colors.transparent],
                      ),
                    ),
                  ),
                ),
              // User dot
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4, spreadRadius: 1)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Convert accuracy in meters to rough pixel size
  double _accuracyToPixels(double accuracy) {
    // This is an approximation - in a real app you'd calculate based on zoom level
    return math.min(100, math.max(20, accuracy / 2));
  }
}

/// Circular pulsing animation for user location
class PulsingUserLocation extends StatefulWidget {
  final UserLocationModel location;

  const PulsingUserLocation({super.key, required this.location});

  @override
  State<PulsingUserLocation> createState() => _PulsingUserLocationState();
}

class _PulsingUserLocationState extends State<PulsingUserLocation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: widget.location.latLng,
          width: 80,
          height: 80,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Pulsing circle
                  Container(
                    width: 60 + (_animation.value * 20),
                    height: 60 + (_animation.value * 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withValues(alpha: 0.2 * (1 - _animation.value)),
                    ),
                  ),
                  // User dot
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4)],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
