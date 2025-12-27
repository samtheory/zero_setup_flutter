// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PoiModel _$PoiModelFromJson(Map<String, dynamic> json) => _PoiModel(
  id: json['id'] as String,
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  category:
      $enumDecodeNullable(_$PoiCategoryEnumMap, json['category']) ??
      PoiCategory.other,
  description: json['description'] as String?,
  address: json['address'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  imageUrl: json['imageUrl'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PoiModelToJson(_PoiModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'category': _$PoiCategoryEnumMap[instance.category]!,
  'description': ?instance.description,
  'address': ?instance.address,
  'phoneNumber': ?instance.phoneNumber,
  'imageUrl': ?instance.imageUrl,
  'metadata': ?instance.metadata,
  'createdAt': ?instance.createdAt?.toIso8601String(),
  'updatedAt': ?instance.updatedAt?.toIso8601String(),
};

const _$PoiCategoryEnumMap = {
  PoiCategory.restaurant: 'restaurant',
  PoiCategory.hotel: 'hotel',
  PoiCategory.hospital: 'hospital',
  PoiCategory.gasStation: 'gasStation',
  PoiCategory.parking: 'parking',
  PoiCategory.atm: 'atm',
  PoiCategory.pharmacy: 'pharmacy',
  PoiCategory.shopping: 'shopping',
  PoiCategory.attraction: 'attraction',
  PoiCategory.other: 'other',
};

_RouteWaypoint _$RouteWaypointFromJson(Map<String, dynamic> json) =>
    _RouteWaypoint(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      name: json['name'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RouteWaypointToJson(_RouteWaypoint instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': ?instance.name,
      'order': ?instance.order,
    };

_RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => _RouteModel(
  id: json['id'] as String,
  name: json['name'] as String,
  waypoints: (json['waypoints'] as List<dynamic>)
      .map((e) => RouteWaypoint.fromJson(e as Map<String, dynamic>))
      .toList(),
  color: (json['color'] as num?)?.toInt() ?? 0xFF2196F3,
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 4.0,
  description: json['description'] as String?,
  totalDistanceKm: (json['totalDistanceKm'] as num?)?.toDouble(),
  estimatedTimeMinutes: (json['estimatedTimeMinutes'] as num?)?.toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$RouteModelToJson(_RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
      'color': instance.color,
      'strokeWidth': instance.strokeWidth,
      'description': ?instance.description,
      'totalDistanceKm': ?instance.totalDistanceKm,
      'estimatedTimeMinutes': ?instance.estimatedTimeMinutes,
      'createdAt': ?instance.createdAt?.toIso8601String(),
    };

_VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) =>
    _VehicleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      heading: (json['heading'] as num?)?.toDouble() ?? 0.0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      status:
          $enumDecodeNullable(_$VehicleStatusEnumMap, json['status']) ??
          VehicleStatus.available,
      driverName: json['driverName'] as String?,
      plateNumber: json['plateNumber'] as String?,
      vehicleType: json['vehicleType'] as String?,
      iconUrl: json['iconUrl'] as String?,
      currentRouteId: json['currentRouteId'] as String?,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$VehicleModelToJson(_VehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'heading': instance.heading,
      'speed': instance.speed,
      'status': _$VehicleStatusEnumMap[instance.status]!,
      'driverName': ?instance.driverName,
      'plateNumber': ?instance.plateNumber,
      'vehicleType': ?instance.vehicleType,
      'iconUrl': ?instance.iconUrl,
      'currentRouteId': ?instance.currentRouteId,
      'lastUpdated': ?instance.lastUpdated?.toIso8601String(),
      'metadata': ?instance.metadata,
    };

const _$VehicleStatusEnumMap = {
  VehicleStatus.available: 'available',
  VehicleStatus.busy: 'busy',
  VehicleStatus.offline: 'offline',
  VehicleStatus.maintenance: 'maintenance',
};

_UserLocationModel _$UserLocationModelFromJson(Map<String, dynamic> json) =>
    _UserLocationModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      heading: (json['heading'] as num?)?.toDouble() ?? 0.0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
      altitude: (json['altitude'] as num?)?.toDouble() ?? 0.0,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$UserLocationModelToJson(_UserLocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'heading': instance.heading,
      'speed': instance.speed,
      'accuracy': instance.accuracy,
      'altitude': instance.altitude,
      'timestamp': ?instance.timestamp?.toIso8601String(),
    };
