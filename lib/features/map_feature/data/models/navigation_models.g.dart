// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OsrmRouteResponse _$OsrmRouteResponseFromJson(Map<String, dynamic> json) =>
    _OsrmRouteResponse(
      code: json['code'] as String,
      routes:
          (json['routes'] as List<dynamic>?)
              ?.map((e) => OsrmRoute.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      waypoints:
          (json['waypoints'] as List<dynamic>?)
              ?.map((e) => OsrmWaypoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OsrmRouteResponseToJson(_OsrmRouteResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'routes': instance.routes.map((e) => e.toJson()).toList(),
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
    };

_OsrmRoute _$OsrmRouteFromJson(Map<String, dynamic> json) => _OsrmRoute(
  geometry: OsrmGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
  weight: (json['weight'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
  legs:
      (json['legs'] as List<dynamic>?)
          ?.map((e) => OsrmLeg.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  weightName: json['weight_name'] as String?,
);

Map<String, dynamic> _$OsrmRouteToJson(_OsrmRoute instance) =>
    <String, dynamic>{
      'geometry': instance.geometry.toJson(),
      'weight': instance.weight,
      'duration': instance.duration,
      'distance': instance.distance,
      'legs': instance.legs.map((e) => e.toJson()).toList(),
      'weight_name': ?instance.weightName,
    };

_OsrmGeometry _$OsrmGeometryFromJson(Map<String, dynamic> json) =>
    _OsrmGeometry(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map(
            (e) =>
                (e as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
          )
          .toList(),
    );

Map<String, dynamic> _$OsrmGeometryToJson(_OsrmGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

_OsrmLeg _$OsrmLegFromJson(Map<String, dynamic> json) => _OsrmLeg(
  weight: (json['weight'] as num).toDouble(),
  duration: (json['duration'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
  summary: json['summary'] as String? ?? '',
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => OsrmStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OsrmLegToJson(_OsrmLeg instance) => <String, dynamic>{
  'weight': instance.weight,
  'duration': instance.duration,
  'distance': instance.distance,
  'summary': instance.summary,
  'steps': instance.steps.map((e) => e.toJson()).toList(),
};

_OsrmStep _$OsrmStepFromJson(Map<String, dynamic> json) => _OsrmStep(
  geometry: OsrmGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
  maneuver: OsrmManeuver.fromJson(json['maneuver'] as Map<String, dynamic>),
  duration: (json['duration'] as num).toDouble(),
  distance: (json['distance'] as num).toDouble(),
  name: json['name'] as String? ?? '',
  mode: json['mode'] as String? ?? 'driving',
  drivingSide: json['driving_side'] as String? ?? 'right',
  intersections:
      (json['intersections'] as List<dynamic>?)
          ?.map((e) => OsrmIntersection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OsrmStepToJson(_OsrmStep instance) => <String, dynamic>{
  'geometry': instance.geometry.toJson(),
  'maneuver': instance.maneuver.toJson(),
  'duration': instance.duration,
  'distance': instance.distance,
  'name': instance.name,
  'mode': instance.mode,
  'driving_side': instance.drivingSide,
  'intersections': instance.intersections.map((e) => e.toJson()).toList(),
};

_OsrmManeuver _$OsrmManeuverFromJson(Map<String, dynamic> json) =>
    _OsrmManeuver(
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      bearingBefore: (json['bearing_before'] as num?)?.toInt() ?? 0,
      bearingAfter: (json['bearing_after'] as num?)?.toInt() ?? 0,
      type: json['type'] as String,
      modifier: json['modifier'] as String?,
      exit: (json['exit'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OsrmManeuverToJson(_OsrmManeuver instance) =>
    <String, dynamic>{
      'location': instance.location,
      'bearing_before': instance.bearingBefore,
      'bearing_after': instance.bearingAfter,
      'type': instance.type,
      'modifier': ?instance.modifier,
      'exit': instance.exit,
    };

_OsrmIntersection _$OsrmIntersectionFromJson(Map<String, dynamic> json) =>
    _OsrmIntersection(
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      bearings:
          (json['bearings'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      entry:
          (json['entry'] as List<dynamic>?)?.map((e) => e as bool).toList() ??
          const [],
      out: (json['out'] as num?)?.toInt() ?? 0,
      inIndex: (json['in'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OsrmIntersectionToJson(_OsrmIntersection instance) =>
    <String, dynamic>{
      'location': instance.location,
      'bearings': instance.bearings,
      'entry': instance.entry,
      'out': instance.out,
      'in': ?instance.inIndex,
    };

_OsrmWaypoint _$OsrmWaypointFromJson(Map<String, dynamic> json) =>
    _OsrmWaypoint(
      hint: json['hint'] as String,
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      name: json['name'] as String,
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$OsrmWaypointToJson(_OsrmWaypoint instance) =>
    <String, dynamic>{
      'hint': instance.hint,
      'location': instance.location,
      'name': instance.name,
      'distance': instance.distance,
    };
