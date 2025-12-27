import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:zero_setup_flutter/core/logger/app_logger.dart';

import '../models/navigation_models.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Abstract Navigation Repository Interface
// ═══════════════════════════════════════════════════════════════════════════

/// Abstract repository for navigation operations
abstract class NavigationRepository {
  /// Calculate route between two points
  Future<NavigationData?> calculateRoute({
    required LatLng origin,
    required LatLng destination,
    String? originName,
    String? destinationName,
  });

  /// Calculate route with multiple waypoints
  Future<NavigationData?> calculateRouteWithWaypoints({required List<LatLng> waypoints, List<String>? waypointNames});
}

// ═══════════════════════════════════════════════════════════════════════════
// OSRM Navigation Repository Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// OSRM-based implementation of NavigationRepository
class OsrmNavigationRepository implements NavigationRepository {
  OsrmNavigationRepository({Dio? dio, String? baseUrl})
    : _dio = dio ?? Dio(),
      _baseUrl = baseUrl ?? 'https://router.project-osrm.org';

  final Dio _dio;
  final String _baseUrl;

  @override
  Future<NavigationData?> calculateRoute({
    required LatLng origin,
    required LatLng destination,
    String? originName,
    String? destinationName,
  }) async {
    return calculateRouteWithWaypoints(
      waypoints: [origin, destination],
      waypointNames: [originName ?? 'Origin', destinationName ?? 'Destination'],
    );
  }

  @override
  Future<NavigationData?> calculateRouteWithWaypoints({
    required List<LatLng> waypoints,
    List<String>? waypointNames,
  }) async {
    if (waypoints.length < 2) {
      talker.error('NavigationRepository: At least 2 waypoints required');
      return null;
    }

    try {
      // Build coordinates string: lon,lat;lon,lat;...
      final coordsString = waypoints.map((wp) => '${wp.longitude},${wp.latitude}').join(';');

      final url = '$_baseUrl/route/v1/driving/$coordsString';

      talker.info('NavigationRepository: Requesting route from OSRM');
      talker.debug('NavigationRepository: URL = $url');

      final response = await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: {'overview': 'full', 'geometries': 'geojson', 'steps': 'true', 'annotations': 'true'},
      );

      if (response.statusCode != 200 || response.data == null) {
        talker.error('NavigationRepository: Invalid response from OSRM');
        return null;
      }

      final osrmResponse = OsrmRouteResponse.fromJson(response.data!);

      if (osrmResponse.code != 'Ok' || osrmResponse.routes.isEmpty) {
        talker.error('NavigationRepository: OSRM returned code: ${osrmResponse.code}');
        return null;
      }

      // Parse the first route
      final route = osrmResponse.routes.first;
      final navigationData = _parseRoute(
        route: route,
        osrmResponse: osrmResponse,
        waypoints: waypoints,
        waypointNames: waypointNames,
      );

      talker.good('NavigationRepository: Route calculated successfully');
      talker.info(
        'NavigationRepository: ${navigationData.steps.length} steps, '
        '${navigationData.formattedDistance}, ${navigationData.formattedDuration}',
      );

      return navigationData;
    } on DioException catch (e) {
      talker.error('NavigationRepository: Network error - ${e.message}');
      return null;
    } catch (e, st) {
      talker.error('NavigationRepository: Error calculating route', e, st);
      return null;
    }
  }

  /// Parse OSRM route to NavigationData
  NavigationData _parseRoute({
    required OsrmRoute route,
    required OsrmRouteResponse osrmResponse,
    required List<LatLng> waypoints,
    List<String>? waypointNames,
  }) {
    // Parse route geometry points
    final routePoints = route.geometry.coordinates
        .map((coord) => LatLng(coord[1], coord[0])) // [lon, lat] -> LatLng(lat, lon)
        .toList();

    // Parse all steps from all legs
    final steps = <NavigationStep>[];
    int stepIndex = 0;

    for (final leg in route.legs) {
      for (final osrmStep in leg.steps) {
        final step = _parseStep(osrmStep, stepIndex);
        steps.add(step);
        stepIndex++;
      }
    }

    // Get waypoint names from OSRM response or use provided names
    final originName =
        waypointNames?.firstOrNull ??
        (osrmResponse.waypoints.isNotEmpty ? osrmResponse.waypoints.first.name : 'Origin');
    final destName =
        waypointNames?.lastOrNull ??
        (osrmResponse.waypoints.length > 1 ? osrmResponse.waypoints.last.name : 'Destination');

    return NavigationData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      origin: waypoints.first,
      destination: waypoints.last,
      routePoints: routePoints,
      steps: steps,
      totalDistanceMeters: route.distance,
      totalDurationSeconds: route.duration,
      originName: originName.isEmpty ? 'Origin' : originName,
      destinationName: destName.isEmpty ? 'Destination' : destName,
    );
  }

  /// Parse OSRM step to NavigationStep
  NavigationStep _parseStep(OsrmStep osrmStep, int index) {
    // Parse step geometry points
    final stepPoints = osrmStep.geometry.coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();

    // Get location from maneuver
    final location = LatLng(osrmStep.maneuver.location[1], osrmStep.maneuver.location[0]);

    // Parse maneuver type
    final maneuverType = ManeuverType.fromOsrm(osrmStep.maneuver.type, osrmStep.maneuver.modifier);

    // Build instruction text
    final instruction = _buildInstruction(
      maneuverType: maneuverType,
      streetName: osrmStep.name,
      modifier: osrmStep.maneuver.modifier,
      exit: osrmStep.maneuver.exit,
    );

    return NavigationStep(
      index: index,
      location: location,
      maneuverType: maneuverType,
      instruction: instruction,
      distanceMeters: osrmStep.distance,
      durationSeconds: osrmStep.duration,
      streetName: osrmStep.name,
      bearingBefore: osrmStep.maneuver.bearingBefore,
      bearingAfter: osrmStep.maneuver.bearingAfter,
      modifier: osrmStep.maneuver.modifier,
      stepPoints: stepPoints,
    );
  }

  /// Build human-readable instruction
  String _buildInstruction({
    required ManeuverType maneuverType,
    required String streetName,
    String? modifier,
    int exit = 0,
  }) {
    final streetPart = streetName.isNotEmpty ? ' onto $streetName' : '';

    switch (maneuverType) {
      case ManeuverType.depart:
        return 'Start$streetPart';
      case ManeuverType.arrive:
        return 'Arrive at your destination';
      case ManeuverType.turnLeft:
        return 'Turn left$streetPart';
      case ManeuverType.turnRight:
        return 'Turn right$streetPart';
      case ManeuverType.turnSharpLeft:
        return 'Turn sharp left$streetPart';
      case ManeuverType.turnSharpRight:
        return 'Turn sharp right$streetPart';
      case ManeuverType.turnSlightLeft:
        return 'Turn slight left$streetPart';
      case ManeuverType.turnSlightRight:
        return 'Turn slight right$streetPart';
      case ManeuverType.straight:
        return 'Continue straight$streetPart';
      case ManeuverType.uturn:
        return 'Make a U-turn';
      case ManeuverType.roundaboutLeft:
      case ManeuverType.roundaboutRight:
        if (exit > 0) {
          return 'Take exit $exit from the roundabout$streetPart';
        }
        return 'Enter the roundabout$streetPart';
      case ManeuverType.merge:
        return 'Merge$streetPart';
      case ManeuverType.fork:
        return 'Take the fork$streetPart';
      case ManeuverType.exitLeft:
        return 'Exit left$streetPart';
      case ManeuverType.exitRight:
        return 'Exit right$streetPart';
      case ManeuverType.ramp:
      case ManeuverType.onRamp:
        return 'Take the ramp$streetPart';
      case ManeuverType.offRamp:
        return 'Take the exit$streetPart';
      case ManeuverType.endOfRoad:
        return 'At end of road, turn ${modifier ?? 'ahead'}$streetPart';
      case ManeuverType.newName:
      case ManeuverType.continueOn:
        return 'Continue$streetPart';
      case ManeuverType.unknown:
        return 'Continue$streetPart';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Riverpod Provider
// ═══════════════════════════════════════════════════════════════════════════

final navigationRepositoryProvider = Provider<NavigationRepository>((ref) {
  return OsrmNavigationRepository();
});
