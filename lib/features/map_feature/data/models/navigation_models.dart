import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'navigation_models.freezed.dart';
part 'navigation_models.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// OSRM API Response Models
// ═══════════════════════════════════════════════════════════════════════════

/// OSRM Route Response from the API
@freezed
sealed class OsrmRouteResponse with _$OsrmRouteResponse {
  const factory OsrmRouteResponse({
    required String code,
    @Default([]) List<OsrmRoute> routes,
    @Default([]) List<OsrmWaypoint> waypoints,
  }) = _OsrmRouteResponse;

  factory OsrmRouteResponse.fromJson(Map<String, dynamic> json) => _$OsrmRouteResponseFromJson(json);
}

/// Single route from OSRM
@freezed
sealed class OsrmRoute with _$OsrmRoute {
  const factory OsrmRoute({
    required OsrmGeometry geometry,
    required double weight,
    required double duration,
    required double distance,
    @Default([]) List<OsrmLeg> legs,
    @JsonKey(name: 'weight_name') String? weightName,
  }) = _OsrmRoute;

  factory OsrmRoute.fromJson(Map<String, dynamic> json) => _$OsrmRouteFromJson(json);
}

/// GeoJSON geometry from OSRM
@freezed
sealed class OsrmGeometry with _$OsrmGeometry {
  const factory OsrmGeometry({required String type, required List<List<double>> coordinates}) = _OsrmGeometry;

  factory OsrmGeometry.fromJson(Map<String, dynamic> json) => _$OsrmGeometryFromJson(json);
}

/// Route leg (between waypoints)
@freezed
sealed class OsrmLeg with _$OsrmLeg {
  const factory OsrmLeg({
    required double weight,
    required double duration,
    required double distance,
    @Default('') String summary,
    @Default([]) List<OsrmStep> steps,
  }) = _OsrmLeg;

  factory OsrmLeg.fromJson(Map<String, dynamic> json) => _$OsrmLegFromJson(json);
}

/// Individual step in a route leg
@freezed
sealed class OsrmStep with _$OsrmStep {
  const factory OsrmStep({
    required OsrmGeometry geometry,
    required OsrmManeuver maneuver,
    required double duration,
    required double distance,
    @Default('') String name,
    @Default('driving') String mode,
    @JsonKey(name: 'driving_side') @Default('right') String drivingSide,
    @Default([]) List<OsrmIntersection> intersections,
  }) = _OsrmStep;

  factory OsrmStep.fromJson(Map<String, dynamic> json) => _$OsrmStepFromJson(json);
}

/// Maneuver instruction
@freezed
sealed class OsrmManeuver with _$OsrmManeuver {
  const factory OsrmManeuver({
    required List<double> location,
    @JsonKey(name: 'bearing_before') @Default(0) int bearingBefore,
    @JsonKey(name: 'bearing_after') @Default(0) int bearingAfter,
    required String type,
    String? modifier,
    @Default(0) int exit,
  }) = _OsrmManeuver;

  factory OsrmManeuver.fromJson(Map<String, dynamic> json) => _$OsrmManeuverFromJson(json);
}

/// Intersection data
@freezed
sealed class OsrmIntersection with _$OsrmIntersection {
  const factory OsrmIntersection({
    required List<double> location,
    @Default([]) List<int> bearings,
    @Default([]) List<bool> entry,
    @Default(0) int out,
    @JsonKey(name: 'in') int? inIndex,
  }) = _OsrmIntersection;

  factory OsrmIntersection.fromJson(Map<String, dynamic> json) => _$OsrmIntersectionFromJson(json);
}

/// Waypoint from OSRM
@freezed
sealed class OsrmWaypoint with _$OsrmWaypoint {
  const factory OsrmWaypoint({
    required String hint,
    required List<double> location,
    required String name,
    required double distance,
  }) = _OsrmWaypoint;

  factory OsrmWaypoint.fromJson(Map<String, dynamic> json) => _$OsrmWaypointFromJson(json);
}

// ═══════════════════════════════════════════════════════════════════════════
// Navigation Data Models (Processed)
// ═══════════════════════════════════════════════════════════════════════════

/// Processed navigation data ready for display
@freezed
sealed class NavigationData with _$NavigationData {
  const NavigationData._();

  const factory NavigationData({
    required String id,
    required LatLng origin,
    required LatLng destination,
    required List<LatLng> routePoints,
    required List<NavigationStep> steps,
    required double totalDistanceMeters,
    required double totalDurationSeconds,
    required String originName,
    required String destinationName,
    @Default(0) int currentStepIndex,
    @Default(false) bool isNavigating,
    @Default(false) bool isCompleted,
    DateTime? startTime,
    double? remainingDistanceMeters,
    double? remainingDurationSeconds,
  }) = _NavigationData;

  /// Formatted total distance
  String get formattedDistance {
    if (totalDistanceMeters >= 1000) {
      return '${(totalDistanceMeters / 1000).toStringAsFixed(1)} km';
    }
    return '${totalDistanceMeters.toInt()} m';
  }

  /// Formatted total duration
  String get formattedDuration {
    final minutes = (totalDurationSeconds / 60).floor();
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '$hours h $mins min';
    }
    return '$minutes min';
  }

  /// Formatted remaining distance
  String get formattedRemainingDistance {
    final dist = remainingDistanceMeters ?? totalDistanceMeters;
    if (dist >= 1000) {
      return '${(dist / 1000).toStringAsFixed(1)} km';
    }
    return '${dist.toInt()} m';
  }

  /// Formatted remaining duration
  String get formattedRemainingDuration {
    final dur = remainingDurationSeconds ?? totalDurationSeconds;
    final minutes = (dur / 60).floor();
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final mins = minutes % 60;
      return '$hours h $mins min';
    }
    return '$minutes min';
  }

  /// Formatted ETA
  String get formattedEta {
    final dur = remainingDurationSeconds ?? totalDurationSeconds;
    final eta = DateTime.now().add(Duration(seconds: dur.toInt()));
    return '${eta.hour.toString().padLeft(2, '0')}:${eta.minute.toString().padLeft(2, '0')}';
  }

  /// Current step
  NavigationStep? get currentStep {
    if (currentStepIndex < steps.length) {
      return steps[currentStepIndex];
    }
    return null;
  }

  /// Next step
  NavigationStep? get nextStep {
    if (currentStepIndex + 1 < steps.length) {
      return steps[currentStepIndex + 1];
    }
    return null;
  }

  /// Progress percentage (0.0 to 1.0)
  double get progress {
    if (totalDistanceMeters == 0) return 0;
    final remaining = remainingDistanceMeters ?? totalDistanceMeters;
    return 1 - (remaining / totalDistanceMeters);
  }
}

/// Individual navigation step
@freezed
sealed class NavigationStep with _$NavigationStep {
  const NavigationStep._();

  const factory NavigationStep({
    required int index,
    required LatLng location,
    required ManeuverType maneuverType,
    required String instruction,
    required double distanceMeters,
    required double durationSeconds,
    required String streetName,
    @Default(0) int bearingBefore,
    @Default(0) int bearingAfter,
    String? modifier,
    @Default([]) List<LatLng> stepPoints,
  }) = _NavigationStep;

  /// Formatted distance
  String get formattedDistance {
    if (distanceMeters >= 1000) {
      return '${(distanceMeters / 1000).toStringAsFixed(1)} km';
    }
    return '${distanceMeters.toInt()} m';
  }

  /// Get icon for maneuver
  IconData get icon => maneuverType.icon;

  /// Get color for maneuver
  Color get color => maneuverType.color;
}

// ═══════════════════════════════════════════════════════════════════════════
// Maneuver Types with Icons & Colors
// ═══════════════════════════════════════════════════════════════════════════

/// Types of navigation maneuvers
enum ManeuverType {
  depart,
  arrive,
  turnLeft,
  turnRight,
  turnSharpLeft,
  turnSharpRight,
  turnSlightLeft,
  turnSlightRight,
  straight,
  uturn,
  roundaboutLeft,
  roundaboutRight,
  merge,
  fork,
  exitLeft,
  exitRight,
  ramp,
  onRamp,
  offRamp,
  endOfRoad,
  newName,
  continueOn,
  unknown;

  /// Get icon for this maneuver type
  IconData get icon {
    switch (this) {
      case ManeuverType.depart:
        return Icons.trip_origin;
      case ManeuverType.arrive:
        return Icons.flag;
      case ManeuverType.turnLeft:
        return Icons.turn_left;
      case ManeuverType.turnRight:
        return Icons.turn_right;
      case ManeuverType.turnSharpLeft:
        return Icons.turn_sharp_left;
      case ManeuverType.turnSharpRight:
        return Icons.turn_sharp_right;
      case ManeuverType.turnSlightLeft:
        return Icons.turn_slight_left;
      case ManeuverType.turnSlightRight:
        return Icons.turn_slight_right;
      case ManeuverType.straight:
        return Icons.straight;
      case ManeuverType.uturn:
        return Icons.u_turn_left;
      case ManeuverType.roundaboutLeft:
        return Icons.roundabout_left;
      case ManeuverType.roundaboutRight:
        return Icons.roundabout_right;
      case ManeuverType.merge:
        return Icons.merge;
      case ManeuverType.fork:
        return Icons.fork_right;
      case ManeuverType.exitLeft:
        return Icons.ramp_left;
      case ManeuverType.exitRight:
        return Icons.ramp_right;
      case ManeuverType.ramp:
      case ManeuverType.onRamp:
      case ManeuverType.offRamp:
        return Icons.ramp_right;
      case ManeuverType.endOfRoad:
        return Icons.not_interested;
      case ManeuverType.newName:
      case ManeuverType.continueOn:
        return Icons.straight;
      case ManeuverType.unknown:
        return Icons.help_outline;
    }
  }

  /// Get color for this maneuver type
  Color get color {
    switch (this) {
      case ManeuverType.depart:
        return Colors.green;
      case ManeuverType.arrive:
        return Colors.red;
      case ManeuverType.turnLeft:
      case ManeuverType.turnSharpLeft:
      case ManeuverType.turnSlightLeft:
        return Colors.blue;
      case ManeuverType.turnRight:
      case ManeuverType.turnSharpRight:
      case ManeuverType.turnSlightRight:
        return Colors.orange;
      case ManeuverType.uturn:
        return Colors.purple;
      case ManeuverType.roundaboutLeft:
      case ManeuverType.roundaboutRight:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  /// Display name for UI
  String get displayName {
    switch (this) {
      case ManeuverType.depart:
        return 'Start';
      case ManeuverType.arrive:
        return 'Arrive';
      case ManeuverType.turnLeft:
        return 'Turn left';
      case ManeuverType.turnRight:
        return 'Turn right';
      case ManeuverType.turnSharpLeft:
        return 'Sharp left';
      case ManeuverType.turnSharpRight:
        return 'Sharp right';
      case ManeuverType.turnSlightLeft:
        return 'Slight left';
      case ManeuverType.turnSlightRight:
        return 'Slight right';
      case ManeuverType.straight:
        return 'Continue straight';
      case ManeuverType.uturn:
        return 'Make a U-turn';
      case ManeuverType.roundaboutLeft:
        return 'Roundabout (left)';
      case ManeuverType.roundaboutRight:
        return 'Roundabout';
      case ManeuverType.merge:
        return 'Merge';
      case ManeuverType.fork:
        return 'Fork';
      case ManeuverType.exitLeft:
        return 'Exit left';
      case ManeuverType.exitRight:
        return 'Exit right';
      case ManeuverType.ramp:
      case ManeuverType.onRamp:
        return 'Take ramp';
      case ManeuverType.offRamp:
        return 'Exit ramp';
      case ManeuverType.endOfRoad:
        return 'End of road';
      case ManeuverType.newName:
      case ManeuverType.continueOn:
        return 'Continue';
      case ManeuverType.unknown:
        return 'Continue';
    }
  }

  /// Parse OSRM maneuver type and modifier to ManeuverType
  static ManeuverType fromOsrm(String type, String? modifier) {
    switch (type) {
      case 'depart':
        return ManeuverType.depart;
      case 'arrive':
        return ManeuverType.arrive;
      case 'turn':
        switch (modifier) {
          case 'left':
            return ManeuverType.turnLeft;
          case 'right':
            return ManeuverType.turnRight;
          case 'sharp left':
            return ManeuverType.turnSharpLeft;
          case 'sharp right':
            return ManeuverType.turnSharpRight;
          case 'slight left':
            return ManeuverType.turnSlightLeft;
          case 'slight right':
            return ManeuverType.turnSlightRight;
          case 'straight':
            return ManeuverType.straight;
          case 'uturn':
            return ManeuverType.uturn;
          default:
            return ManeuverType.straight;
        }
      case 'new name':
        return ManeuverType.newName;
      case 'continue':
        return ManeuverType.continueOn;
      case 'merge':
        return ManeuverType.merge;
      case 'fork':
        if (modifier == 'left') return ManeuverType.exitLeft;
        if (modifier == 'right') return ManeuverType.exitRight;
        return ManeuverType.fork;
      case 'on ramp':
        return ManeuverType.onRamp;
      case 'off ramp':
        return ManeuverType.offRamp;
      case 'roundabout':
      case 'rotary':
        if (modifier?.contains('left') ?? false) {
          return ManeuverType.roundaboutLeft;
        }
        return ManeuverType.roundaboutRight;
      case 'roundabout turn':
        if (modifier == 'left') return ManeuverType.turnLeft;
        if (modifier == 'right') return ManeuverType.turnRight;
        return ManeuverType.straight;
      case 'exit roundabout':
      case 'exit rotary':
        return ManeuverType.exitRight;
      case 'end of road':
        if (modifier == 'left') return ManeuverType.turnLeft;
        if (modifier == 'right') return ManeuverType.turnRight;
        return ManeuverType.endOfRoad;
      default:
        return ManeuverType.unknown;
    }
  }
}

/// Navigation status enum
enum NavigationStatus { idle, calculating, ready, navigating, rerouting, arrived, error }
