// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapState {
  // Map Configuration
  MapTemplate get currentTemplate;
  double get zoom;
  LatLng? get center; // User Location
  UserLocationModel? get userLocation;
  bool get isLoadingLocation;
  bool get isFollowingUser;
  String? get locationError; // POI Layer
  List<PoiModel> get pois;
  bool get showPoisLayer;
  bool get isLoadingPois;
  Set<PoiCategory>? get poiCategoryFilter;
  PoiModel? get selectedPoi; // Routes Layer
  List<RouteModel> get routes;
  bool get showRoutesLayer;
  bool get isLoadingRoutes;
  RouteModel? get selectedRoute; // Vehicles Layer
  List<VehicleModel> get vehicles;
  bool get showVehiclesLayer;
  bool get isLoadingVehicles;
  VehicleModel? get selectedVehicle; // General
  String? get error;
  bool get isMapReady;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapStateCopyWith<MapState> get copyWith =>
      _$MapStateCopyWithImpl<MapState>(this as MapState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapState &&
            (identical(other.currentTemplate, currentTemplate) ||
                other.currentTemplate == currentTemplate) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation) &&
            (identical(other.isLoadingLocation, isLoadingLocation) ||
                other.isLoadingLocation == isLoadingLocation) &&
            (identical(other.isFollowingUser, isFollowingUser) ||
                other.isFollowingUser == isFollowingUser) &&
            (identical(other.locationError, locationError) ||
                other.locationError == locationError) &&
            const DeepCollectionEquality().equals(other.pois, pois) &&
            (identical(other.showPoisLayer, showPoisLayer) ||
                other.showPoisLayer == showPoisLayer) &&
            (identical(other.isLoadingPois, isLoadingPois) ||
                other.isLoadingPois == isLoadingPois) &&
            const DeepCollectionEquality().equals(
              other.poiCategoryFilter,
              poiCategoryFilter,
            ) &&
            (identical(other.selectedPoi, selectedPoi) ||
                other.selectedPoi == selectedPoi) &&
            const DeepCollectionEquality().equals(other.routes, routes) &&
            (identical(other.showRoutesLayer, showRoutesLayer) ||
                other.showRoutesLayer == showRoutesLayer) &&
            (identical(other.isLoadingRoutes, isLoadingRoutes) ||
                other.isLoadingRoutes == isLoadingRoutes) &&
            (identical(other.selectedRoute, selectedRoute) ||
                other.selectedRoute == selectedRoute) &&
            const DeepCollectionEquality().equals(other.vehicles, vehicles) &&
            (identical(other.showVehiclesLayer, showVehiclesLayer) ||
                other.showVehiclesLayer == showVehiclesLayer) &&
            (identical(other.isLoadingVehicles, isLoadingVehicles) ||
                other.isLoadingVehicles == isLoadingVehicles) &&
            (identical(other.selectedVehicle, selectedVehicle) ||
                other.selectedVehicle == selectedVehicle) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isMapReady, isMapReady) ||
                other.isMapReady == isMapReady));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    currentTemplate,
    zoom,
    center,
    userLocation,
    isLoadingLocation,
    isFollowingUser,
    locationError,
    const DeepCollectionEquality().hash(pois),
    showPoisLayer,
    isLoadingPois,
    const DeepCollectionEquality().hash(poiCategoryFilter),
    selectedPoi,
    const DeepCollectionEquality().hash(routes),
    showRoutesLayer,
    isLoadingRoutes,
    selectedRoute,
    const DeepCollectionEquality().hash(vehicles),
    showVehiclesLayer,
    isLoadingVehicles,
    selectedVehicle,
    error,
    isMapReady,
  ]);

  @override
  String toString() {
    return 'MapState(currentTemplate: $currentTemplate, zoom: $zoom, center: $center, userLocation: $userLocation, isLoadingLocation: $isLoadingLocation, isFollowingUser: $isFollowingUser, locationError: $locationError, pois: $pois, showPoisLayer: $showPoisLayer, isLoadingPois: $isLoadingPois, poiCategoryFilter: $poiCategoryFilter, selectedPoi: $selectedPoi, routes: $routes, showRoutesLayer: $showRoutesLayer, isLoadingRoutes: $isLoadingRoutes, selectedRoute: $selectedRoute, vehicles: $vehicles, showVehiclesLayer: $showVehiclesLayer, isLoadingVehicles: $isLoadingVehicles, selectedVehicle: $selectedVehicle, error: $error, isMapReady: $isMapReady)';
  }
}

/// @nodoc
abstract mixin class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) _then) =
      _$MapStateCopyWithImpl;
  @useResult
  $Res call({
    MapTemplate currentTemplate,
    double zoom,
    LatLng? center,
    UserLocationModel? userLocation,
    bool isLoadingLocation,
    bool isFollowingUser,
    String? locationError,
    List<PoiModel> pois,
    bool showPoisLayer,
    bool isLoadingPois,
    Set<PoiCategory>? poiCategoryFilter,
    PoiModel? selectedPoi,
    List<RouteModel> routes,
    bool showRoutesLayer,
    bool isLoadingRoutes,
    RouteModel? selectedRoute,
    List<VehicleModel> vehicles,
    bool showVehiclesLayer,
    bool isLoadingVehicles,
    VehicleModel? selectedVehicle,
    String? error,
    bool isMapReady,
  });

  $UserLocationModelCopyWith<$Res>? get userLocation;
  $PoiModelCopyWith<$Res>? get selectedPoi;
  $RouteModelCopyWith<$Res>? get selectedRoute;
  $VehicleModelCopyWith<$Res>? get selectedVehicle;
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res> implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._self, this._then);

  final MapState _self;
  final $Res Function(MapState) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTemplate = null,
    Object? zoom = null,
    Object? center = freezed,
    Object? userLocation = freezed,
    Object? isLoadingLocation = null,
    Object? isFollowingUser = null,
    Object? locationError = freezed,
    Object? pois = null,
    Object? showPoisLayer = null,
    Object? isLoadingPois = null,
    Object? poiCategoryFilter = freezed,
    Object? selectedPoi = freezed,
    Object? routes = null,
    Object? showRoutesLayer = null,
    Object? isLoadingRoutes = null,
    Object? selectedRoute = freezed,
    Object? vehicles = null,
    Object? showVehiclesLayer = null,
    Object? isLoadingVehicles = null,
    Object? selectedVehicle = freezed,
    Object? error = freezed,
    Object? isMapReady = null,
  }) {
    return _then(
      _self.copyWith(
        currentTemplate: null == currentTemplate
            ? _self.currentTemplate
            : currentTemplate // ignore: cast_nullable_to_non_nullable
                  as MapTemplate,
        zoom: null == zoom
            ? _self.zoom
            : zoom // ignore: cast_nullable_to_non_nullable
                  as double,
        center: freezed == center
            ? _self.center
            : center // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        userLocation: freezed == userLocation
            ? _self.userLocation
            : userLocation // ignore: cast_nullable_to_non_nullable
                  as UserLocationModel?,
        isLoadingLocation: null == isLoadingLocation
            ? _self.isLoadingLocation
            : isLoadingLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFollowingUser: null == isFollowingUser
            ? _self.isFollowingUser
            : isFollowingUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        locationError: freezed == locationError
            ? _self.locationError
            : locationError // ignore: cast_nullable_to_non_nullable
                  as String?,
        pois: null == pois
            ? _self.pois
            : pois // ignore: cast_nullable_to_non_nullable
                  as List<PoiModel>,
        showPoisLayer: null == showPoisLayer
            ? _self.showPoisLayer
            : showPoisLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingPois: null == isLoadingPois
            ? _self.isLoadingPois
            : isLoadingPois // ignore: cast_nullable_to_non_nullable
                  as bool,
        poiCategoryFilter: freezed == poiCategoryFilter
            ? _self.poiCategoryFilter
            : poiCategoryFilter // ignore: cast_nullable_to_non_nullable
                  as Set<PoiCategory>?,
        selectedPoi: freezed == selectedPoi
            ? _self.selectedPoi
            : selectedPoi // ignore: cast_nullable_to_non_nullable
                  as PoiModel?,
        routes: null == routes
            ? _self.routes
            : routes // ignore: cast_nullable_to_non_nullable
                  as List<RouteModel>,
        showRoutesLayer: null == showRoutesLayer
            ? _self.showRoutesLayer
            : showRoutesLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingRoutes: null == isLoadingRoutes
            ? _self.isLoadingRoutes
            : isLoadingRoutes // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedRoute: freezed == selectedRoute
            ? _self.selectedRoute
            : selectedRoute // ignore: cast_nullable_to_non_nullable
                  as RouteModel?,
        vehicles: null == vehicles
            ? _self.vehicles
            : vehicles // ignore: cast_nullable_to_non_nullable
                  as List<VehicleModel>,
        showVehiclesLayer: null == showVehiclesLayer
            ? _self.showVehiclesLayer
            : showVehiclesLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingVehicles: null == isLoadingVehicles
            ? _self.isLoadingVehicles
            : isLoadingVehicles // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedVehicle: freezed == selectedVehicle
            ? _self.selectedVehicle
            : selectedVehicle // ignore: cast_nullable_to_non_nullable
                  as VehicleModel?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        isMapReady: null == isMapReady
            ? _self.isMapReady
            : isMapReady // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserLocationModelCopyWith<$Res>? get userLocation {
    if (_self.userLocation == null) {
      return null;
    }

    return $UserLocationModelCopyWith<$Res>(_self.userLocation!, (value) {
      return _then(_self.copyWith(userLocation: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoiModelCopyWith<$Res>? get selectedPoi {
    if (_self.selectedPoi == null) {
      return null;
    }

    return $PoiModelCopyWith<$Res>(_self.selectedPoi!, (value) {
      return _then(_self.copyWith(selectedPoi: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<$Res>? get selectedRoute {
    if (_self.selectedRoute == null) {
      return null;
    }

    return $RouteModelCopyWith<$Res>(_self.selectedRoute!, (value) {
      return _then(_self.copyWith(selectedRoute: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleModelCopyWith<$Res>? get selectedVehicle {
    if (_self.selectedVehicle == null) {
      return null;
    }

    return $VehicleModelCopyWith<$Res>(_self.selectedVehicle!, (value) {
      return _then(_self.copyWith(selectedVehicle: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MapState].
extension MapStatePatterns on MapState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MapState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MapState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MapState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      MapTemplate currentTemplate,
      double zoom,
      LatLng? center,
      UserLocationModel? userLocation,
      bool isLoadingLocation,
      bool isFollowingUser,
      String? locationError,
      List<PoiModel> pois,
      bool showPoisLayer,
      bool isLoadingPois,
      Set<PoiCategory>? poiCategoryFilter,
      PoiModel? selectedPoi,
      List<RouteModel> routes,
      bool showRoutesLayer,
      bool isLoadingRoutes,
      RouteModel? selectedRoute,
      List<VehicleModel> vehicles,
      bool showVehiclesLayer,
      bool isLoadingVehicles,
      VehicleModel? selectedVehicle,
      String? error,
      bool isMapReady,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapState() when $default != null:
        return $default(
          _that.currentTemplate,
          _that.zoom,
          _that.center,
          _that.userLocation,
          _that.isLoadingLocation,
          _that.isFollowingUser,
          _that.locationError,
          _that.pois,
          _that.showPoisLayer,
          _that.isLoadingPois,
          _that.poiCategoryFilter,
          _that.selectedPoi,
          _that.routes,
          _that.showRoutesLayer,
          _that.isLoadingRoutes,
          _that.selectedRoute,
          _that.vehicles,
          _that.showVehiclesLayer,
          _that.isLoadingVehicles,
          _that.selectedVehicle,
          _that.error,
          _that.isMapReady,
        );
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      MapTemplate currentTemplate,
      double zoom,
      LatLng? center,
      UserLocationModel? userLocation,
      bool isLoadingLocation,
      bool isFollowingUser,
      String? locationError,
      List<PoiModel> pois,
      bool showPoisLayer,
      bool isLoadingPois,
      Set<PoiCategory>? poiCategoryFilter,
      PoiModel? selectedPoi,
      List<RouteModel> routes,
      bool showRoutesLayer,
      bool isLoadingRoutes,
      RouteModel? selectedRoute,
      List<VehicleModel> vehicles,
      bool showVehiclesLayer,
      bool isLoadingVehicles,
      VehicleModel? selectedVehicle,
      String? error,
      bool isMapReady,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapState():
        return $default(
          _that.currentTemplate,
          _that.zoom,
          _that.center,
          _that.userLocation,
          _that.isLoadingLocation,
          _that.isFollowingUser,
          _that.locationError,
          _that.pois,
          _that.showPoisLayer,
          _that.isLoadingPois,
          _that.poiCategoryFilter,
          _that.selectedPoi,
          _that.routes,
          _that.showRoutesLayer,
          _that.isLoadingRoutes,
          _that.selectedRoute,
          _that.vehicles,
          _that.showVehiclesLayer,
          _that.isLoadingVehicles,
          _that.selectedVehicle,
          _that.error,
          _that.isMapReady,
        );
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      MapTemplate currentTemplate,
      double zoom,
      LatLng? center,
      UserLocationModel? userLocation,
      bool isLoadingLocation,
      bool isFollowingUser,
      String? locationError,
      List<PoiModel> pois,
      bool showPoisLayer,
      bool isLoadingPois,
      Set<PoiCategory>? poiCategoryFilter,
      PoiModel? selectedPoi,
      List<RouteModel> routes,
      bool showRoutesLayer,
      bool isLoadingRoutes,
      RouteModel? selectedRoute,
      List<VehicleModel> vehicles,
      bool showVehiclesLayer,
      bool isLoadingVehicles,
      VehicleModel? selectedVehicle,
      String? error,
      bool isMapReady,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapState() when $default != null:
        return $default(
          _that.currentTemplate,
          _that.zoom,
          _that.center,
          _that.userLocation,
          _that.isLoadingLocation,
          _that.isFollowingUser,
          _that.locationError,
          _that.pois,
          _that.showPoisLayer,
          _that.isLoadingPois,
          _that.poiCategoryFilter,
          _that.selectedPoi,
          _that.routes,
          _that.showRoutesLayer,
          _that.isLoadingRoutes,
          _that.selectedRoute,
          _that.vehicles,
          _that.showVehiclesLayer,
          _that.isLoadingVehicles,
          _that.selectedVehicle,
          _that.error,
          _that.isMapReady,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MapState extends MapState {
  const _MapState({
    this.currentTemplate = MapTemplate.openStreetMap,
    this.zoom = 13.0,
    this.center,
    this.userLocation,
    this.isLoadingLocation = false,
    this.isFollowingUser = false,
    this.locationError,
    final List<PoiModel> pois = const [],
    this.showPoisLayer = true,
    this.isLoadingPois = false,
    final Set<PoiCategory>? poiCategoryFilter,
    this.selectedPoi,
    final List<RouteModel> routes = const [],
    this.showRoutesLayer = true,
    this.isLoadingRoutes = false,
    this.selectedRoute,
    final List<VehicleModel> vehicles = const [],
    this.showVehiclesLayer = true,
    this.isLoadingVehicles = false,
    this.selectedVehicle,
    this.error,
    this.isMapReady = false,
  }) : _pois = pois,
       _poiCategoryFilter = poiCategoryFilter,
       _routes = routes,
       _vehicles = vehicles,
       super._();

  // Map Configuration
  @override
  @JsonKey()
  final MapTemplate currentTemplate;
  @override
  @JsonKey()
  final double zoom;
  @override
  final LatLng? center;
  // User Location
  @override
  final UserLocationModel? userLocation;
  @override
  @JsonKey()
  final bool isLoadingLocation;
  @override
  @JsonKey()
  final bool isFollowingUser;
  @override
  final String? locationError;
  // POI Layer
  final List<PoiModel> _pois;
  // POI Layer
  @override
  @JsonKey()
  List<PoiModel> get pois {
    if (_pois is EqualUnmodifiableListView) return _pois;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pois);
  }

  @override
  @JsonKey()
  final bool showPoisLayer;
  @override
  @JsonKey()
  final bool isLoadingPois;
  final Set<PoiCategory>? _poiCategoryFilter;
  @override
  Set<PoiCategory>? get poiCategoryFilter {
    final value = _poiCategoryFilter;
    if (value == null) return null;
    if (_poiCategoryFilter is EqualUnmodifiableSetView)
      return _poiCategoryFilter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  final PoiModel? selectedPoi;
  // Routes Layer
  final List<RouteModel> _routes;
  // Routes Layer
  @override
  @JsonKey()
  List<RouteModel> get routes {
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  @override
  @JsonKey()
  final bool showRoutesLayer;
  @override
  @JsonKey()
  final bool isLoadingRoutes;
  @override
  final RouteModel? selectedRoute;
  // Vehicles Layer
  final List<VehicleModel> _vehicles;
  // Vehicles Layer
  @override
  @JsonKey()
  List<VehicleModel> get vehicles {
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicles);
  }

  @override
  @JsonKey()
  final bool showVehiclesLayer;
  @override
  @JsonKey()
  final bool isLoadingVehicles;
  @override
  final VehicleModel? selectedVehicle;
  // General
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isMapReady;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapStateCopyWith<_MapState> get copyWith =>
      __$MapStateCopyWithImpl<_MapState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapState &&
            (identical(other.currentTemplate, currentTemplate) ||
                other.currentTemplate == currentTemplate) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.center, center) || other.center == center) &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation) &&
            (identical(other.isLoadingLocation, isLoadingLocation) ||
                other.isLoadingLocation == isLoadingLocation) &&
            (identical(other.isFollowingUser, isFollowingUser) ||
                other.isFollowingUser == isFollowingUser) &&
            (identical(other.locationError, locationError) ||
                other.locationError == locationError) &&
            const DeepCollectionEquality().equals(other._pois, _pois) &&
            (identical(other.showPoisLayer, showPoisLayer) ||
                other.showPoisLayer == showPoisLayer) &&
            (identical(other.isLoadingPois, isLoadingPois) ||
                other.isLoadingPois == isLoadingPois) &&
            const DeepCollectionEquality().equals(
              other._poiCategoryFilter,
              _poiCategoryFilter,
            ) &&
            (identical(other.selectedPoi, selectedPoi) ||
                other.selectedPoi == selectedPoi) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            (identical(other.showRoutesLayer, showRoutesLayer) ||
                other.showRoutesLayer == showRoutesLayer) &&
            (identical(other.isLoadingRoutes, isLoadingRoutes) ||
                other.isLoadingRoutes == isLoadingRoutes) &&
            (identical(other.selectedRoute, selectedRoute) ||
                other.selectedRoute == selectedRoute) &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles) &&
            (identical(other.showVehiclesLayer, showVehiclesLayer) ||
                other.showVehiclesLayer == showVehiclesLayer) &&
            (identical(other.isLoadingVehicles, isLoadingVehicles) ||
                other.isLoadingVehicles == isLoadingVehicles) &&
            (identical(other.selectedVehicle, selectedVehicle) ||
                other.selectedVehicle == selectedVehicle) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isMapReady, isMapReady) ||
                other.isMapReady == isMapReady));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    currentTemplate,
    zoom,
    center,
    userLocation,
    isLoadingLocation,
    isFollowingUser,
    locationError,
    const DeepCollectionEquality().hash(_pois),
    showPoisLayer,
    isLoadingPois,
    const DeepCollectionEquality().hash(_poiCategoryFilter),
    selectedPoi,
    const DeepCollectionEquality().hash(_routes),
    showRoutesLayer,
    isLoadingRoutes,
    selectedRoute,
    const DeepCollectionEquality().hash(_vehicles),
    showVehiclesLayer,
    isLoadingVehicles,
    selectedVehicle,
    error,
    isMapReady,
  ]);

  @override
  String toString() {
    return 'MapState(currentTemplate: $currentTemplate, zoom: $zoom, center: $center, userLocation: $userLocation, isLoadingLocation: $isLoadingLocation, isFollowingUser: $isFollowingUser, locationError: $locationError, pois: $pois, showPoisLayer: $showPoisLayer, isLoadingPois: $isLoadingPois, poiCategoryFilter: $poiCategoryFilter, selectedPoi: $selectedPoi, routes: $routes, showRoutesLayer: $showRoutesLayer, isLoadingRoutes: $isLoadingRoutes, selectedRoute: $selectedRoute, vehicles: $vehicles, showVehiclesLayer: $showVehiclesLayer, isLoadingVehicles: $isLoadingVehicles, selectedVehicle: $selectedVehicle, error: $error, isMapReady: $isMapReady)';
  }
}

/// @nodoc
abstract mixin class _$MapStateCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$MapStateCopyWith(_MapState value, $Res Function(_MapState) _then) =
      __$MapStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    MapTemplate currentTemplate,
    double zoom,
    LatLng? center,
    UserLocationModel? userLocation,
    bool isLoadingLocation,
    bool isFollowingUser,
    String? locationError,
    List<PoiModel> pois,
    bool showPoisLayer,
    bool isLoadingPois,
    Set<PoiCategory>? poiCategoryFilter,
    PoiModel? selectedPoi,
    List<RouteModel> routes,
    bool showRoutesLayer,
    bool isLoadingRoutes,
    RouteModel? selectedRoute,
    List<VehicleModel> vehicles,
    bool showVehiclesLayer,
    bool isLoadingVehicles,
    VehicleModel? selectedVehicle,
    String? error,
    bool isMapReady,
  });

  @override
  $UserLocationModelCopyWith<$Res>? get userLocation;
  @override
  $PoiModelCopyWith<$Res>? get selectedPoi;
  @override
  $RouteModelCopyWith<$Res>? get selectedRoute;
  @override
  $VehicleModelCopyWith<$Res>? get selectedVehicle;
}

/// @nodoc
class __$MapStateCopyWithImpl<$Res> implements _$MapStateCopyWith<$Res> {
  __$MapStateCopyWithImpl(this._self, this._then);

  final _MapState _self;
  final $Res Function(_MapState) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentTemplate = null,
    Object? zoom = null,
    Object? center = freezed,
    Object? userLocation = freezed,
    Object? isLoadingLocation = null,
    Object? isFollowingUser = null,
    Object? locationError = freezed,
    Object? pois = null,
    Object? showPoisLayer = null,
    Object? isLoadingPois = null,
    Object? poiCategoryFilter = freezed,
    Object? selectedPoi = freezed,
    Object? routes = null,
    Object? showRoutesLayer = null,
    Object? isLoadingRoutes = null,
    Object? selectedRoute = freezed,
    Object? vehicles = null,
    Object? showVehiclesLayer = null,
    Object? isLoadingVehicles = null,
    Object? selectedVehicle = freezed,
    Object? error = freezed,
    Object? isMapReady = null,
  }) {
    return _then(
      _MapState(
        currentTemplate: null == currentTemplate
            ? _self.currentTemplate
            : currentTemplate // ignore: cast_nullable_to_non_nullable
                  as MapTemplate,
        zoom: null == zoom
            ? _self.zoom
            : zoom // ignore: cast_nullable_to_non_nullable
                  as double,
        center: freezed == center
            ? _self.center
            : center // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        userLocation: freezed == userLocation
            ? _self.userLocation
            : userLocation // ignore: cast_nullable_to_non_nullable
                  as UserLocationModel?,
        isLoadingLocation: null == isLoadingLocation
            ? _self.isLoadingLocation
            : isLoadingLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFollowingUser: null == isFollowingUser
            ? _self.isFollowingUser
            : isFollowingUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        locationError: freezed == locationError
            ? _self.locationError
            : locationError // ignore: cast_nullable_to_non_nullable
                  as String?,
        pois: null == pois
            ? _self._pois
            : pois // ignore: cast_nullable_to_non_nullable
                  as List<PoiModel>,
        showPoisLayer: null == showPoisLayer
            ? _self.showPoisLayer
            : showPoisLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingPois: null == isLoadingPois
            ? _self.isLoadingPois
            : isLoadingPois // ignore: cast_nullable_to_non_nullable
                  as bool,
        poiCategoryFilter: freezed == poiCategoryFilter
            ? _self._poiCategoryFilter
            : poiCategoryFilter // ignore: cast_nullable_to_non_nullable
                  as Set<PoiCategory>?,
        selectedPoi: freezed == selectedPoi
            ? _self.selectedPoi
            : selectedPoi // ignore: cast_nullable_to_non_nullable
                  as PoiModel?,
        routes: null == routes
            ? _self._routes
            : routes // ignore: cast_nullable_to_non_nullable
                  as List<RouteModel>,
        showRoutesLayer: null == showRoutesLayer
            ? _self.showRoutesLayer
            : showRoutesLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingRoutes: null == isLoadingRoutes
            ? _self.isLoadingRoutes
            : isLoadingRoutes // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedRoute: freezed == selectedRoute
            ? _self.selectedRoute
            : selectedRoute // ignore: cast_nullable_to_non_nullable
                  as RouteModel?,
        vehicles: null == vehicles
            ? _self._vehicles
            : vehicles // ignore: cast_nullable_to_non_nullable
                  as List<VehicleModel>,
        showVehiclesLayer: null == showVehiclesLayer
            ? _self.showVehiclesLayer
            : showVehiclesLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingVehicles: null == isLoadingVehicles
            ? _self.isLoadingVehicles
            : isLoadingVehicles // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedVehicle: freezed == selectedVehicle
            ? _self.selectedVehicle
            : selectedVehicle // ignore: cast_nullable_to_non_nullable
                  as VehicleModel?,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        isMapReady: null == isMapReady
            ? _self.isMapReady
            : isMapReady // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserLocationModelCopyWith<$Res>? get userLocation {
    if (_self.userLocation == null) {
      return null;
    }

    return $UserLocationModelCopyWith<$Res>(_self.userLocation!, (value) {
      return _then(_self.copyWith(userLocation: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoiModelCopyWith<$Res>? get selectedPoi {
    if (_self.selectedPoi == null) {
      return null;
    }

    return $PoiModelCopyWith<$Res>(_self.selectedPoi!, (value) {
      return _then(_self.copyWith(selectedPoi: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<$Res>? get selectedRoute {
    if (_self.selectedRoute == null) {
      return null;
    }

    return $RouteModelCopyWith<$Res>(_self.selectedRoute!, (value) {
      return _then(_self.copyWith(selectedRoute: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleModelCopyWith<$Res>? get selectedVehicle {
    if (_self.selectedVehicle == null) {
      return null;
    }

    return $VehicleModelCopyWith<$Res>(_self.selectedVehicle!, (value) {
      return _then(_self.copyWith(selectedVehicle: value));
    });
  }
}

/// @nodoc
mixin _$MapLayersVisibility {
  bool get showUserLocation;
  bool get showPois;
  bool get showRoutes;
  bool get showVehicles;

  /// Create a copy of MapLayersVisibility
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapLayersVisibilityCopyWith<MapLayersVisibility> get copyWith =>
      _$MapLayersVisibilityCopyWithImpl<MapLayersVisibility>(
        this as MapLayersVisibility,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapLayersVisibility &&
            (identical(other.showUserLocation, showUserLocation) ||
                other.showUserLocation == showUserLocation) &&
            (identical(other.showPois, showPois) ||
                other.showPois == showPois) &&
            (identical(other.showRoutes, showRoutes) ||
                other.showRoutes == showRoutes) &&
            (identical(other.showVehicles, showVehicles) ||
                other.showVehicles == showVehicles));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showUserLocation,
    showPois,
    showRoutes,
    showVehicles,
  );

  @override
  String toString() {
    return 'MapLayersVisibility(showUserLocation: $showUserLocation, showPois: $showPois, showRoutes: $showRoutes, showVehicles: $showVehicles)';
  }
}

/// @nodoc
abstract mixin class $MapLayersVisibilityCopyWith<$Res> {
  factory $MapLayersVisibilityCopyWith(
    MapLayersVisibility value,
    $Res Function(MapLayersVisibility) _then,
  ) = _$MapLayersVisibilityCopyWithImpl;
  @useResult
  $Res call({
    bool showUserLocation,
    bool showPois,
    bool showRoutes,
    bool showVehicles,
  });
}

/// @nodoc
class _$MapLayersVisibilityCopyWithImpl<$Res>
    implements $MapLayersVisibilityCopyWith<$Res> {
  _$MapLayersVisibilityCopyWithImpl(this._self, this._then);

  final MapLayersVisibility _self;
  final $Res Function(MapLayersVisibility) _then;

  /// Create a copy of MapLayersVisibility
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showUserLocation = null,
    Object? showPois = null,
    Object? showRoutes = null,
    Object? showVehicles = null,
  }) {
    return _then(
      _self.copyWith(
        showUserLocation: null == showUserLocation
            ? _self.showUserLocation
            : showUserLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        showPois: null == showPois
            ? _self.showPois
            : showPois // ignore: cast_nullable_to_non_nullable
                  as bool,
        showRoutes: null == showRoutes
            ? _self.showRoutes
            : showRoutes // ignore: cast_nullable_to_non_nullable
                  as bool,
        showVehicles: null == showVehicles
            ? _self.showVehicles
            : showVehicles // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [MapLayersVisibility].
extension MapLayersVisibilityPatterns on MapLayersVisibility {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MapLayersVisibility value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapLayersVisibility() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MapLayersVisibility value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapLayersVisibility():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MapLayersVisibility value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapLayersVisibility() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      bool showUserLocation,
      bool showPois,
      bool showRoutes,
      bool showVehicles,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapLayersVisibility() when $default != null:
        return $default(
          _that.showUserLocation,
          _that.showPois,
          _that.showRoutes,
          _that.showVehicles,
        );
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      bool showUserLocation,
      bool showPois,
      bool showRoutes,
      bool showVehicles,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapLayersVisibility():
        return $default(
          _that.showUserLocation,
          _that.showPois,
          _that.showRoutes,
          _that.showVehicles,
        );
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      bool showUserLocation,
      bool showPois,
      bool showRoutes,
      bool showVehicles,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapLayersVisibility() when $default != null:
        return $default(
          _that.showUserLocation,
          _that.showPois,
          _that.showRoutes,
          _that.showVehicles,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MapLayersVisibility extends MapLayersVisibility {
  const _MapLayersVisibility({
    this.showUserLocation = true,
    this.showPois = true,
    this.showRoutes = true,
    this.showVehicles = true,
  }) : super._();

  @override
  @JsonKey()
  final bool showUserLocation;
  @override
  @JsonKey()
  final bool showPois;
  @override
  @JsonKey()
  final bool showRoutes;
  @override
  @JsonKey()
  final bool showVehicles;

  /// Create a copy of MapLayersVisibility
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapLayersVisibilityCopyWith<_MapLayersVisibility> get copyWith =>
      __$MapLayersVisibilityCopyWithImpl<_MapLayersVisibility>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapLayersVisibility &&
            (identical(other.showUserLocation, showUserLocation) ||
                other.showUserLocation == showUserLocation) &&
            (identical(other.showPois, showPois) ||
                other.showPois == showPois) &&
            (identical(other.showRoutes, showRoutes) ||
                other.showRoutes == showRoutes) &&
            (identical(other.showVehicles, showVehicles) ||
                other.showVehicles == showVehicles));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showUserLocation,
    showPois,
    showRoutes,
    showVehicles,
  );

  @override
  String toString() {
    return 'MapLayersVisibility(showUserLocation: $showUserLocation, showPois: $showPois, showRoutes: $showRoutes, showVehicles: $showVehicles)';
  }
}

/// @nodoc
abstract mixin class _$MapLayersVisibilityCopyWith<$Res>
    implements $MapLayersVisibilityCopyWith<$Res> {
  factory _$MapLayersVisibilityCopyWith(
    _MapLayersVisibility value,
    $Res Function(_MapLayersVisibility) _then,
  ) = __$MapLayersVisibilityCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool showUserLocation,
    bool showPois,
    bool showRoutes,
    bool showVehicles,
  });
}

/// @nodoc
class __$MapLayersVisibilityCopyWithImpl<$Res>
    implements _$MapLayersVisibilityCopyWith<$Res> {
  __$MapLayersVisibilityCopyWithImpl(this._self, this._then);

  final _MapLayersVisibility _self;
  final $Res Function(_MapLayersVisibility) _then;

  /// Create a copy of MapLayersVisibility
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? showUserLocation = null,
    Object? showPois = null,
    Object? showRoutes = null,
    Object? showVehicles = null,
  }) {
    return _then(
      _MapLayersVisibility(
        showUserLocation: null == showUserLocation
            ? _self.showUserLocation
            : showUserLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        showPois: null == showPois
            ? _self.showPois
            : showPois // ignore: cast_nullable_to_non_nullable
                  as bool,
        showRoutes: null == showRoutes
            ? _self.showRoutes
            : showRoutes // ignore: cast_nullable_to_non_nullable
                  as bool,
        showVehicles: null == showVehicles
            ? _self.showVehicles
            : showVehicles // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
mixin _$PoiDetailState {
  PoiModel? get poi;
  bool get isLoading;
  String? get error;

  /// Create a copy of PoiDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PoiDetailStateCopyWith<PoiDetailState> get copyWith =>
      _$PoiDetailStateCopyWithImpl<PoiDetailState>(
        this as PoiDetailState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PoiDetailState &&
            (identical(other.poi, poi) || other.poi == poi) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poi, isLoading, error);

  @override
  String toString() {
    return 'PoiDetailState(poi: $poi, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class $PoiDetailStateCopyWith<$Res> {
  factory $PoiDetailStateCopyWith(
    PoiDetailState value,
    $Res Function(PoiDetailState) _then,
  ) = _$PoiDetailStateCopyWithImpl;
  @useResult
  $Res call({PoiModel? poi, bool isLoading, String? error});

  $PoiModelCopyWith<$Res>? get poi;
}

/// @nodoc
class _$PoiDetailStateCopyWithImpl<$Res>
    implements $PoiDetailStateCopyWith<$Res> {
  _$PoiDetailStateCopyWithImpl(this._self, this._then);

  final PoiDetailState _self;
  final $Res Function(PoiDetailState) _then;

  /// Create a copy of PoiDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poi = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _self.copyWith(
        poi: freezed == poi
            ? _self.poi
            : poi // ignore: cast_nullable_to_non_nullable
                  as PoiModel?,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of PoiDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoiModelCopyWith<$Res>? get poi {
    if (_self.poi == null) {
      return null;
    }

    return $PoiModelCopyWith<$Res>(_self.poi!, (value) {
      return _then(_self.copyWith(poi: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PoiDetailState].
extension PoiDetailStatePatterns on PoiDetailState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PoiDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PoiDetailState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PoiDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiDetailState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PoiDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiDetailState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(PoiModel? poi, bool isLoading, String? error)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PoiDetailState() when $default != null:
        return $default(_that.poi, _that.isLoading, _that.error);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(PoiModel? poi, bool isLoading, String? error) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiDetailState():
        return $default(_that.poi, _that.isLoading, _that.error);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(PoiModel? poi, bool isLoading, String? error)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiDetailState() when $default != null:
        return $default(_that.poi, _that.isLoading, _that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PoiDetailState extends PoiDetailState {
  const _PoiDetailState({this.poi, this.isLoading = false, this.error})
    : super._();

  @override
  final PoiModel? poi;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  /// Create a copy of PoiDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PoiDetailStateCopyWith<_PoiDetailState> get copyWith =>
      __$PoiDetailStateCopyWithImpl<_PoiDetailState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PoiDetailState &&
            (identical(other.poi, poi) || other.poi == poi) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, poi, isLoading, error);

  @override
  String toString() {
    return 'PoiDetailState(poi: $poi, isLoading: $isLoading, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$PoiDetailStateCopyWith<$Res>
    implements $PoiDetailStateCopyWith<$Res> {
  factory _$PoiDetailStateCopyWith(
    _PoiDetailState value,
    $Res Function(_PoiDetailState) _then,
  ) = __$PoiDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call({PoiModel? poi, bool isLoading, String? error});

  @override
  $PoiModelCopyWith<$Res>? get poi;
}

/// @nodoc
class __$PoiDetailStateCopyWithImpl<$Res>
    implements _$PoiDetailStateCopyWith<$Res> {
  __$PoiDetailStateCopyWithImpl(this._self, this._then);

  final _PoiDetailState _self;
  final $Res Function(_PoiDetailState) _then;

  /// Create a copy of PoiDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? poi = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _PoiDetailState(
        poi: freezed == poi
            ? _self.poi
            : poi // ignore: cast_nullable_to_non_nullable
                  as PoiModel?,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of PoiDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PoiModelCopyWith<$Res>? get poi {
    if (_self.poi == null) {
      return null;
    }

    return $PoiModelCopyWith<$Res>(_self.poi!, (value) {
      return _then(_self.copyWith(poi: value));
    });
  }
}

/// @nodoc
mixin _$VehicleTrackingState {
  VehicleModel? get trackedVehicle;
  bool get isTracking;
  List<LatLng> get trackHistory;
  String? get error;

  /// Create a copy of VehicleTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VehicleTrackingStateCopyWith<VehicleTrackingState> get copyWith =>
      _$VehicleTrackingStateCopyWithImpl<VehicleTrackingState>(
        this as VehicleTrackingState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VehicleTrackingState &&
            (identical(other.trackedVehicle, trackedVehicle) ||
                other.trackedVehicle == trackedVehicle) &&
            (identical(other.isTracking, isTracking) ||
                other.isTracking == isTracking) &&
            const DeepCollectionEquality().equals(
              other.trackHistory,
              trackHistory,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    trackedVehicle,
    isTracking,
    const DeepCollectionEquality().hash(trackHistory),
    error,
  );

  @override
  String toString() {
    return 'VehicleTrackingState(trackedVehicle: $trackedVehicle, isTracking: $isTracking, trackHistory: $trackHistory, error: $error)';
  }
}

/// @nodoc
abstract mixin class $VehicleTrackingStateCopyWith<$Res> {
  factory $VehicleTrackingStateCopyWith(
    VehicleTrackingState value,
    $Res Function(VehicleTrackingState) _then,
  ) = _$VehicleTrackingStateCopyWithImpl;
  @useResult
  $Res call({
    VehicleModel? trackedVehicle,
    bool isTracking,
    List<LatLng> trackHistory,
    String? error,
  });

  $VehicleModelCopyWith<$Res>? get trackedVehicle;
}

/// @nodoc
class _$VehicleTrackingStateCopyWithImpl<$Res>
    implements $VehicleTrackingStateCopyWith<$Res> {
  _$VehicleTrackingStateCopyWithImpl(this._self, this._then);

  final VehicleTrackingState _self;
  final $Res Function(VehicleTrackingState) _then;

  /// Create a copy of VehicleTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackedVehicle = freezed,
    Object? isTracking = null,
    Object? trackHistory = null,
    Object? error = freezed,
  }) {
    return _then(
      _self.copyWith(
        trackedVehicle: freezed == trackedVehicle
            ? _self.trackedVehicle
            : trackedVehicle // ignore: cast_nullable_to_non_nullable
                  as VehicleModel?,
        isTracking: null == isTracking
            ? _self.isTracking
            : isTracking // ignore: cast_nullable_to_non_nullable
                  as bool,
        trackHistory: null == trackHistory
            ? _self.trackHistory
            : trackHistory // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of VehicleTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleModelCopyWith<$Res>? get trackedVehicle {
    if (_self.trackedVehicle == null) {
      return null;
    }

    return $VehicleModelCopyWith<$Res>(_self.trackedVehicle!, (value) {
      return _then(_self.copyWith(trackedVehicle: value));
    });
  }
}

/// Adds pattern-matching-related methods to [VehicleTrackingState].
extension VehicleTrackingStatePatterns on VehicleTrackingState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VehicleTrackingState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleTrackingState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VehicleTrackingState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleTrackingState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VehicleTrackingState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleTrackingState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      VehicleModel? trackedVehicle,
      bool isTracking,
      List<LatLng> trackHistory,
      String? error,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleTrackingState() when $default != null:
        return $default(
          _that.trackedVehicle,
          _that.isTracking,
          _that.trackHistory,
          _that.error,
        );
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      VehicleModel? trackedVehicle,
      bool isTracking,
      List<LatLng> trackHistory,
      String? error,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleTrackingState():
        return $default(
          _that.trackedVehicle,
          _that.isTracking,
          _that.trackHistory,
          _that.error,
        );
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      VehicleModel? trackedVehicle,
      bool isTracking,
      List<LatLng> trackHistory,
      String? error,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleTrackingState() when $default != null:
        return $default(
          _that.trackedVehicle,
          _that.isTracking,
          _that.trackHistory,
          _that.error,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _VehicleTrackingState extends VehicleTrackingState {
  const _VehicleTrackingState({
    this.trackedVehicle,
    this.isTracking = false,
    final List<LatLng> trackHistory = const [],
    this.error,
  }) : _trackHistory = trackHistory,
       super._();

  @override
  final VehicleModel? trackedVehicle;
  @override
  @JsonKey()
  final bool isTracking;
  final List<LatLng> _trackHistory;
  @override
  @JsonKey()
  List<LatLng> get trackHistory {
    if (_trackHistory is EqualUnmodifiableListView) return _trackHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackHistory);
  }

  @override
  final String? error;

  /// Create a copy of VehicleTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VehicleTrackingStateCopyWith<_VehicleTrackingState> get copyWith =>
      __$VehicleTrackingStateCopyWithImpl<_VehicleTrackingState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VehicleTrackingState &&
            (identical(other.trackedVehicle, trackedVehicle) ||
                other.trackedVehicle == trackedVehicle) &&
            (identical(other.isTracking, isTracking) ||
                other.isTracking == isTracking) &&
            const DeepCollectionEquality().equals(
              other._trackHistory,
              _trackHistory,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    trackedVehicle,
    isTracking,
    const DeepCollectionEquality().hash(_trackHistory),
    error,
  );

  @override
  String toString() {
    return 'VehicleTrackingState(trackedVehicle: $trackedVehicle, isTracking: $isTracking, trackHistory: $trackHistory, error: $error)';
  }
}

/// @nodoc
abstract mixin class _$VehicleTrackingStateCopyWith<$Res>
    implements $VehicleTrackingStateCopyWith<$Res> {
  factory _$VehicleTrackingStateCopyWith(
    _VehicleTrackingState value,
    $Res Function(_VehicleTrackingState) _then,
  ) = __$VehicleTrackingStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    VehicleModel? trackedVehicle,
    bool isTracking,
    List<LatLng> trackHistory,
    String? error,
  });

  @override
  $VehicleModelCopyWith<$Res>? get trackedVehicle;
}

/// @nodoc
class __$VehicleTrackingStateCopyWithImpl<$Res>
    implements _$VehicleTrackingStateCopyWith<$Res> {
  __$VehicleTrackingStateCopyWithImpl(this._self, this._then);

  final _VehicleTrackingState _self;
  final $Res Function(_VehicleTrackingState) _then;

  /// Create a copy of VehicleTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? trackedVehicle = freezed,
    Object? isTracking = null,
    Object? trackHistory = null,
    Object? error = freezed,
  }) {
    return _then(
      _VehicleTrackingState(
        trackedVehicle: freezed == trackedVehicle
            ? _self.trackedVehicle
            : trackedVehicle // ignore: cast_nullable_to_non_nullable
                  as VehicleModel?,
        isTracking: null == isTracking
            ? _self.isTracking
            : isTracking // ignore: cast_nullable_to_non_nullable
                  as bool,
        trackHistory: null == trackHistory
            ? _self._trackHistory
            : trackHistory // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of VehicleTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleModelCopyWith<$Res>? get trackedVehicle {
    if (_self.trackedVehicle == null) {
      return null;
    }

    return $VehicleModelCopyWith<$Res>(_self.trackedVehicle!, (value) {
      return _then(_self.copyWith(trackedVehicle: value));
    });
  }
}
