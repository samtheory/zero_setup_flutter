// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OsrmRouteResponse {
  String get code;
  List<OsrmRoute> get routes;
  List<OsrmWaypoint> get waypoints;

  /// Create a copy of OsrmRouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmRouteResponseCopyWith<OsrmRouteResponse> get copyWith =>
      _$OsrmRouteResponseCopyWithImpl<OsrmRouteResponse>(
        this as OsrmRouteResponse,
        _$identity,
      );

  /// Serializes this OsrmRouteResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmRouteResponse &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.routes, routes) &&
            const DeepCollectionEquality().equals(other.waypoints, waypoints));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    const DeepCollectionEquality().hash(routes),
    const DeepCollectionEquality().hash(waypoints),
  );

  @override
  String toString() {
    return 'OsrmRouteResponse(code: $code, routes: $routes, waypoints: $waypoints)';
  }
}

/// @nodoc
abstract mixin class $OsrmRouteResponseCopyWith<$Res> {
  factory $OsrmRouteResponseCopyWith(
    OsrmRouteResponse value,
    $Res Function(OsrmRouteResponse) _then,
  ) = _$OsrmRouteResponseCopyWithImpl;
  @useResult
  $Res call({
    String code,
    List<OsrmRoute> routes,
    List<OsrmWaypoint> waypoints,
  });
}

/// @nodoc
class _$OsrmRouteResponseCopyWithImpl<$Res>
    implements $OsrmRouteResponseCopyWith<$Res> {
  _$OsrmRouteResponseCopyWithImpl(this._self, this._then);

  final OsrmRouteResponse _self;
  final $Res Function(OsrmRouteResponse) _then;

  /// Create a copy of OsrmRouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? routes = null,
    Object? waypoints = null,
  }) {
    return _then(
      _self.copyWith(
        code: null == code
            ? _self.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        routes: null == routes
            ? _self.routes
            : routes // ignore: cast_nullable_to_non_nullable
                  as List<OsrmRoute>,
        waypoints: null == waypoints
            ? _self.waypoints
            : waypoints // ignore: cast_nullable_to_non_nullable
                  as List<OsrmWaypoint>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [OsrmRouteResponse].
extension OsrmRouteResponsePatterns on OsrmRouteResponse {
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
    TResult Function(_OsrmRouteResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmRouteResponse() when $default != null:
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
    TResult Function(_OsrmRouteResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRouteResponse():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmRouteResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRouteResponse() when $default != null:
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
      String code,
      List<OsrmRoute> routes,
      List<OsrmWaypoint> waypoints,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmRouteResponse() when $default != null:
        return $default(_that.code, _that.routes, _that.waypoints);
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
      String code,
      List<OsrmRoute> routes,
      List<OsrmWaypoint> waypoints,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRouteResponse():
        return $default(_that.code, _that.routes, _that.waypoints);
      case _:
        throw StateError('Unexpected subclass');
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
      String code,
      List<OsrmRoute> routes,
      List<OsrmWaypoint> waypoints,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRouteResponse() when $default != null:
        return $default(_that.code, _that.routes, _that.waypoints);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmRouteResponse implements OsrmRouteResponse {
  const _OsrmRouteResponse({
    required this.code,
    final List<OsrmRoute> routes = const [],
    final List<OsrmWaypoint> waypoints = const [],
  }) : _routes = routes,
       _waypoints = waypoints;
  factory _OsrmRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$OsrmRouteResponseFromJson(json);

  @override
  final String code;
  final List<OsrmRoute> _routes;
  @override
  @JsonKey()
  List<OsrmRoute> get routes {
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  final List<OsrmWaypoint> _waypoints;
  @override
  @JsonKey()
  List<OsrmWaypoint> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  /// Create a copy of OsrmRouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmRouteResponseCopyWith<_OsrmRouteResponse> get copyWith =>
      __$OsrmRouteResponseCopyWithImpl<_OsrmRouteResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmRouteResponseToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmRouteResponse &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            const DeepCollectionEquality().equals(
              other._waypoints,
              _waypoints,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    const DeepCollectionEquality().hash(_routes),
    const DeepCollectionEquality().hash(_waypoints),
  );

  @override
  String toString() {
    return 'OsrmRouteResponse(code: $code, routes: $routes, waypoints: $waypoints)';
  }
}

/// @nodoc
abstract mixin class _$OsrmRouteResponseCopyWith<$Res>
    implements $OsrmRouteResponseCopyWith<$Res> {
  factory _$OsrmRouteResponseCopyWith(
    _OsrmRouteResponse value,
    $Res Function(_OsrmRouteResponse) _then,
  ) = __$OsrmRouteResponseCopyWithImpl;
  @override
  @useResult
  $Res call({
    String code,
    List<OsrmRoute> routes,
    List<OsrmWaypoint> waypoints,
  });
}

/// @nodoc
class __$OsrmRouteResponseCopyWithImpl<$Res>
    implements _$OsrmRouteResponseCopyWith<$Res> {
  __$OsrmRouteResponseCopyWithImpl(this._self, this._then);

  final _OsrmRouteResponse _self;
  final $Res Function(_OsrmRouteResponse) _then;

  /// Create a copy of OsrmRouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? routes = null,
    Object? waypoints = null,
  }) {
    return _then(
      _OsrmRouteResponse(
        code: null == code
            ? _self.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        routes: null == routes
            ? _self._routes
            : routes // ignore: cast_nullable_to_non_nullable
                  as List<OsrmRoute>,
        waypoints: null == waypoints
            ? _self._waypoints
            : waypoints // ignore: cast_nullable_to_non_nullable
                  as List<OsrmWaypoint>,
      ),
    );
  }
}

/// @nodoc
mixin _$OsrmRoute {
  OsrmGeometry get geometry;
  double get weight;
  double get duration;
  double get distance;
  List<OsrmLeg> get legs;
  @JsonKey(name: 'weight_name')
  String? get weightName;

  /// Create a copy of OsrmRoute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmRouteCopyWith<OsrmRoute> get copyWith =>
      _$OsrmRouteCopyWithImpl<OsrmRoute>(this as OsrmRoute, _$identity);

  /// Serializes this OsrmRoute to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmRoute &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality().equals(other.legs, legs) &&
            (identical(other.weightName, weightName) ||
                other.weightName == weightName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    geometry,
    weight,
    duration,
    distance,
    const DeepCollectionEquality().hash(legs),
    weightName,
  );

  @override
  String toString() {
    return 'OsrmRoute(geometry: $geometry, weight: $weight, duration: $duration, distance: $distance, legs: $legs, weightName: $weightName)';
  }
}

/// @nodoc
abstract mixin class $OsrmRouteCopyWith<$Res> {
  factory $OsrmRouteCopyWith(OsrmRoute value, $Res Function(OsrmRoute) _then) =
      _$OsrmRouteCopyWithImpl;
  @useResult
  $Res call({
    OsrmGeometry geometry,
    double weight,
    double duration,
    double distance,
    List<OsrmLeg> legs,
    @JsonKey(name: 'weight_name') String? weightName,
  });

  $OsrmGeometryCopyWith<$Res> get geometry;
}

/// @nodoc
class _$OsrmRouteCopyWithImpl<$Res> implements $OsrmRouteCopyWith<$Res> {
  _$OsrmRouteCopyWithImpl(this._self, this._then);

  final OsrmRoute _self;
  final $Res Function(OsrmRoute) _then;

  /// Create a copy of OsrmRoute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? weight = null,
    Object? duration = null,
    Object? distance = null,
    Object? legs = null,
    Object? weightName = freezed,
  }) {
    return _then(
      _self.copyWith(
        geometry: null == geometry
            ? _self.geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as OsrmGeometry,
        weight: null == weight
            ? _self.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        legs: null == legs
            ? _self.legs
            : legs // ignore: cast_nullable_to_non_nullable
                  as List<OsrmLeg>,
        weightName: freezed == weightName
            ? _self.weightName
            : weightName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of OsrmRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OsrmGeometryCopyWith<$Res> get geometry {
    return $OsrmGeometryCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }
}

/// Adds pattern-matching-related methods to [OsrmRoute].
extension OsrmRoutePatterns on OsrmRoute {
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
    TResult Function(_OsrmRoute value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmRoute() when $default != null:
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
    TResult Function(_OsrmRoute value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRoute():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmRoute value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRoute() when $default != null:
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
      OsrmGeometry geometry,
      double weight,
      double duration,
      double distance,
      List<OsrmLeg> legs,
      @JsonKey(name: 'weight_name') String? weightName,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmRoute() when $default != null:
        return $default(
          _that.geometry,
          _that.weight,
          _that.duration,
          _that.distance,
          _that.legs,
          _that.weightName,
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
      OsrmGeometry geometry,
      double weight,
      double duration,
      double distance,
      List<OsrmLeg> legs,
      @JsonKey(name: 'weight_name') String? weightName,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRoute():
        return $default(
          _that.geometry,
          _that.weight,
          _that.duration,
          _that.distance,
          _that.legs,
          _that.weightName,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      OsrmGeometry geometry,
      double weight,
      double duration,
      double distance,
      List<OsrmLeg> legs,
      @JsonKey(name: 'weight_name') String? weightName,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmRoute() when $default != null:
        return $default(
          _that.geometry,
          _that.weight,
          _that.duration,
          _that.distance,
          _that.legs,
          _that.weightName,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmRoute implements OsrmRoute {
  const _OsrmRoute({
    required this.geometry,
    required this.weight,
    required this.duration,
    required this.distance,
    final List<OsrmLeg> legs = const [],
    @JsonKey(name: 'weight_name') this.weightName,
  }) : _legs = legs;
  factory _OsrmRoute.fromJson(Map<String, dynamic> json) =>
      _$OsrmRouteFromJson(json);

  @override
  final OsrmGeometry geometry;
  @override
  final double weight;
  @override
  final double duration;
  @override
  final double distance;
  final List<OsrmLeg> _legs;
  @override
  @JsonKey()
  List<OsrmLeg> get legs {
    if (_legs is EqualUnmodifiableListView) return _legs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_legs);
  }

  @override
  @JsonKey(name: 'weight_name')
  final String? weightName;

  /// Create a copy of OsrmRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmRouteCopyWith<_OsrmRoute> get copyWith =>
      __$OsrmRouteCopyWithImpl<_OsrmRoute>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmRouteToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmRoute &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality().equals(other._legs, _legs) &&
            (identical(other.weightName, weightName) ||
                other.weightName == weightName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    geometry,
    weight,
    duration,
    distance,
    const DeepCollectionEquality().hash(_legs),
    weightName,
  );

  @override
  String toString() {
    return 'OsrmRoute(geometry: $geometry, weight: $weight, duration: $duration, distance: $distance, legs: $legs, weightName: $weightName)';
  }
}

/// @nodoc
abstract mixin class _$OsrmRouteCopyWith<$Res>
    implements $OsrmRouteCopyWith<$Res> {
  factory _$OsrmRouteCopyWith(
    _OsrmRoute value,
    $Res Function(_OsrmRoute) _then,
  ) = __$OsrmRouteCopyWithImpl;
  @override
  @useResult
  $Res call({
    OsrmGeometry geometry,
    double weight,
    double duration,
    double distance,
    List<OsrmLeg> legs,
    @JsonKey(name: 'weight_name') String? weightName,
  });

  @override
  $OsrmGeometryCopyWith<$Res> get geometry;
}

/// @nodoc
class __$OsrmRouteCopyWithImpl<$Res> implements _$OsrmRouteCopyWith<$Res> {
  __$OsrmRouteCopyWithImpl(this._self, this._then);

  final _OsrmRoute _self;
  final $Res Function(_OsrmRoute) _then;

  /// Create a copy of OsrmRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? geometry = null,
    Object? weight = null,
    Object? duration = null,
    Object? distance = null,
    Object? legs = null,
    Object? weightName = freezed,
  }) {
    return _then(
      _OsrmRoute(
        geometry: null == geometry
            ? _self.geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as OsrmGeometry,
        weight: null == weight
            ? _self.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        legs: null == legs
            ? _self._legs
            : legs // ignore: cast_nullable_to_non_nullable
                  as List<OsrmLeg>,
        weightName: freezed == weightName
            ? _self.weightName
            : weightName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of OsrmRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OsrmGeometryCopyWith<$Res> get geometry {
    return $OsrmGeometryCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }
}

/// @nodoc
mixin _$OsrmGeometry {
  String get type;
  List<List<double>> get coordinates;

  /// Create a copy of OsrmGeometry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmGeometryCopyWith<OsrmGeometry> get copyWith =>
      _$OsrmGeometryCopyWithImpl<OsrmGeometry>(
        this as OsrmGeometry,
        _$identity,
      );

  /// Serializes this OsrmGeometry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmGeometry &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other.coordinates,
              coordinates,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(coordinates),
  );

  @override
  String toString() {
    return 'OsrmGeometry(type: $type, coordinates: $coordinates)';
  }
}

/// @nodoc
abstract mixin class $OsrmGeometryCopyWith<$Res> {
  factory $OsrmGeometryCopyWith(
    OsrmGeometry value,
    $Res Function(OsrmGeometry) _then,
  ) = _$OsrmGeometryCopyWithImpl;
  @useResult
  $Res call({String type, List<List<double>> coordinates});
}

/// @nodoc
class _$OsrmGeometryCopyWithImpl<$Res> implements $OsrmGeometryCopyWith<$Res> {
  _$OsrmGeometryCopyWithImpl(this._self, this._then);

  final OsrmGeometry _self;
  final $Res Function(OsrmGeometry) _then;

  /// Create a copy of OsrmGeometry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? coordinates = null}) {
    return _then(
      _self.copyWith(
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        coordinates: null == coordinates
            ? _self.coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as List<List<double>>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [OsrmGeometry].
extension OsrmGeometryPatterns on OsrmGeometry {
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
    TResult Function(_OsrmGeometry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmGeometry() when $default != null:
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
    TResult Function(_OsrmGeometry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmGeometry():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmGeometry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmGeometry() when $default != null:
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
    TResult Function(String type, List<List<double>> coordinates)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmGeometry() when $default != null:
        return $default(_that.type, _that.coordinates);
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
    TResult Function(String type, List<List<double>> coordinates) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmGeometry():
        return $default(_that.type, _that.coordinates);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(String type, List<List<double>> coordinates)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmGeometry() when $default != null:
        return $default(_that.type, _that.coordinates);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmGeometry implements OsrmGeometry {
  const _OsrmGeometry({
    required this.type,
    required final List<List<double>> coordinates,
  }) : _coordinates = coordinates;
  factory _OsrmGeometry.fromJson(Map<String, dynamic> json) =>
      _$OsrmGeometryFromJson(json);

  @override
  final String type;
  final List<List<double>> _coordinates;
  @override
  List<List<double>> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  /// Create a copy of OsrmGeometry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmGeometryCopyWith<_OsrmGeometry> get copyWith =>
      __$OsrmGeometryCopyWithImpl<_OsrmGeometry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmGeometryToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmGeometry &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._coordinates,
              _coordinates,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    const DeepCollectionEquality().hash(_coordinates),
  );

  @override
  String toString() {
    return 'OsrmGeometry(type: $type, coordinates: $coordinates)';
  }
}

/// @nodoc
abstract mixin class _$OsrmGeometryCopyWith<$Res>
    implements $OsrmGeometryCopyWith<$Res> {
  factory _$OsrmGeometryCopyWith(
    _OsrmGeometry value,
    $Res Function(_OsrmGeometry) _then,
  ) = __$OsrmGeometryCopyWithImpl;
  @override
  @useResult
  $Res call({String type, List<List<double>> coordinates});
}

/// @nodoc
class __$OsrmGeometryCopyWithImpl<$Res>
    implements _$OsrmGeometryCopyWith<$Res> {
  __$OsrmGeometryCopyWithImpl(this._self, this._then);

  final _OsrmGeometry _self;
  final $Res Function(_OsrmGeometry) _then;

  /// Create a copy of OsrmGeometry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? type = null, Object? coordinates = null}) {
    return _then(
      _OsrmGeometry(
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        coordinates: null == coordinates
            ? _self._coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as List<List<double>>,
      ),
    );
  }
}

/// @nodoc
mixin _$OsrmLeg {
  double get weight;
  double get duration;
  double get distance;
  String get summary;
  List<OsrmStep> get steps;

  /// Create a copy of OsrmLeg
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmLegCopyWith<OsrmLeg> get copyWith =>
      _$OsrmLegCopyWithImpl<OsrmLeg>(this as OsrmLeg, _$identity);

  /// Serializes this OsrmLeg to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmLeg &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other.steps, steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    weight,
    duration,
    distance,
    summary,
    const DeepCollectionEquality().hash(steps),
  );

  @override
  String toString() {
    return 'OsrmLeg(weight: $weight, duration: $duration, distance: $distance, summary: $summary, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class $OsrmLegCopyWith<$Res> {
  factory $OsrmLegCopyWith(OsrmLeg value, $Res Function(OsrmLeg) _then) =
      _$OsrmLegCopyWithImpl;
  @useResult
  $Res call({
    double weight,
    double duration,
    double distance,
    String summary,
    List<OsrmStep> steps,
  });
}

/// @nodoc
class _$OsrmLegCopyWithImpl<$Res> implements $OsrmLegCopyWith<$Res> {
  _$OsrmLegCopyWithImpl(this._self, this._then);

  final OsrmLeg _self;
  final $Res Function(OsrmLeg) _then;

  /// Create a copy of OsrmLeg
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? duration = null,
    Object? distance = null,
    Object? summary = null,
    Object? steps = null,
  }) {
    return _then(
      _self.copyWith(
        weight: null == weight
            ? _self.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        summary: null == summary
            ? _self.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        steps: null == steps
            ? _self.steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<OsrmStep>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [OsrmLeg].
extension OsrmLegPatterns on OsrmLeg {
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
    TResult Function(_OsrmLeg value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmLeg() when $default != null:
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
    TResult Function(_OsrmLeg value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmLeg():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmLeg value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmLeg() when $default != null:
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
      double weight,
      double duration,
      double distance,
      String summary,
      List<OsrmStep> steps,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmLeg() when $default != null:
        return $default(
          _that.weight,
          _that.duration,
          _that.distance,
          _that.summary,
          _that.steps,
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
      double weight,
      double duration,
      double distance,
      String summary,
      List<OsrmStep> steps,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmLeg():
        return $default(
          _that.weight,
          _that.duration,
          _that.distance,
          _that.summary,
          _that.steps,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      double weight,
      double duration,
      double distance,
      String summary,
      List<OsrmStep> steps,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmLeg() when $default != null:
        return $default(
          _that.weight,
          _that.duration,
          _that.distance,
          _that.summary,
          _that.steps,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmLeg implements OsrmLeg {
  const _OsrmLeg({
    required this.weight,
    required this.duration,
    required this.distance,
    this.summary = '',
    final List<OsrmStep> steps = const [],
  }) : _steps = steps;
  factory _OsrmLeg.fromJson(Map<String, dynamic> json) =>
      _$OsrmLegFromJson(json);

  @override
  final double weight;
  @override
  final double duration;
  @override
  final double distance;
  @override
  @JsonKey()
  final String summary;
  final List<OsrmStep> _steps;
  @override
  @JsonKey()
  List<OsrmStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Create a copy of OsrmLeg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmLegCopyWith<_OsrmLeg> get copyWith =>
      __$OsrmLegCopyWithImpl<_OsrmLeg>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmLegToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmLeg &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    weight,
    duration,
    distance,
    summary,
    const DeepCollectionEquality().hash(_steps),
  );

  @override
  String toString() {
    return 'OsrmLeg(weight: $weight, duration: $duration, distance: $distance, summary: $summary, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class _$OsrmLegCopyWith<$Res> implements $OsrmLegCopyWith<$Res> {
  factory _$OsrmLegCopyWith(_OsrmLeg value, $Res Function(_OsrmLeg) _then) =
      __$OsrmLegCopyWithImpl;
  @override
  @useResult
  $Res call({
    double weight,
    double duration,
    double distance,
    String summary,
    List<OsrmStep> steps,
  });
}

/// @nodoc
class __$OsrmLegCopyWithImpl<$Res> implements _$OsrmLegCopyWith<$Res> {
  __$OsrmLegCopyWithImpl(this._self, this._then);

  final _OsrmLeg _self;
  final $Res Function(_OsrmLeg) _then;

  /// Create a copy of OsrmLeg
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weight = null,
    Object? duration = null,
    Object? distance = null,
    Object? summary = null,
    Object? steps = null,
  }) {
    return _then(
      _OsrmLeg(
        weight: null == weight
            ? _self.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        summary: null == summary
            ? _self.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        steps: null == steps
            ? _self._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<OsrmStep>,
      ),
    );
  }
}

/// @nodoc
mixin _$OsrmStep {
  OsrmGeometry get geometry;
  OsrmManeuver get maneuver;
  double get duration;
  double get distance;
  String get name;
  String get mode;
  @JsonKey(name: 'driving_side')
  String get drivingSide;
  List<OsrmIntersection> get intersections;

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmStepCopyWith<OsrmStep> get copyWith =>
      _$OsrmStepCopyWithImpl<OsrmStep>(this as OsrmStep, _$identity);

  /// Serializes this OsrmStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmStep &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.maneuver, maneuver) ||
                other.maneuver == maneuver) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.drivingSide, drivingSide) ||
                other.drivingSide == drivingSide) &&
            const DeepCollectionEquality().equals(
              other.intersections,
              intersections,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    geometry,
    maneuver,
    duration,
    distance,
    name,
    mode,
    drivingSide,
    const DeepCollectionEquality().hash(intersections),
  );

  @override
  String toString() {
    return 'OsrmStep(geometry: $geometry, maneuver: $maneuver, duration: $duration, distance: $distance, name: $name, mode: $mode, drivingSide: $drivingSide, intersections: $intersections)';
  }
}

/// @nodoc
abstract mixin class $OsrmStepCopyWith<$Res> {
  factory $OsrmStepCopyWith(OsrmStep value, $Res Function(OsrmStep) _then) =
      _$OsrmStepCopyWithImpl;
  @useResult
  $Res call({
    OsrmGeometry geometry,
    OsrmManeuver maneuver,
    double duration,
    double distance,
    String name,
    String mode,
    @JsonKey(name: 'driving_side') String drivingSide,
    List<OsrmIntersection> intersections,
  });

  $OsrmGeometryCopyWith<$Res> get geometry;
  $OsrmManeuverCopyWith<$Res> get maneuver;
}

/// @nodoc
class _$OsrmStepCopyWithImpl<$Res> implements $OsrmStepCopyWith<$Res> {
  _$OsrmStepCopyWithImpl(this._self, this._then);

  final OsrmStep _self;
  final $Res Function(OsrmStep) _then;

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geometry = null,
    Object? maneuver = null,
    Object? duration = null,
    Object? distance = null,
    Object? name = null,
    Object? mode = null,
    Object? drivingSide = null,
    Object? intersections = null,
  }) {
    return _then(
      _self.copyWith(
        geometry: null == geometry
            ? _self.geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as OsrmGeometry,
        maneuver: null == maneuver
            ? _self.maneuver
            : maneuver // ignore: cast_nullable_to_non_nullable
                  as OsrmManeuver,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as String,
        drivingSide: null == drivingSide
            ? _self.drivingSide
            : drivingSide // ignore: cast_nullable_to_non_nullable
                  as String,
        intersections: null == intersections
            ? _self.intersections
            : intersections // ignore: cast_nullable_to_non_nullable
                  as List<OsrmIntersection>,
      ),
    );
  }

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OsrmGeometryCopyWith<$Res> get geometry {
    return $OsrmGeometryCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OsrmManeuverCopyWith<$Res> get maneuver {
    return $OsrmManeuverCopyWith<$Res>(_self.maneuver, (value) {
      return _then(_self.copyWith(maneuver: value));
    });
  }
}

/// Adds pattern-matching-related methods to [OsrmStep].
extension OsrmStepPatterns on OsrmStep {
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
    TResult Function(_OsrmStep value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmStep() when $default != null:
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
    TResult Function(_OsrmStep value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmStep():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmStep value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmStep() when $default != null:
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
      OsrmGeometry geometry,
      OsrmManeuver maneuver,
      double duration,
      double distance,
      String name,
      String mode,
      @JsonKey(name: 'driving_side') String drivingSide,
      List<OsrmIntersection> intersections,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmStep() when $default != null:
        return $default(
          _that.geometry,
          _that.maneuver,
          _that.duration,
          _that.distance,
          _that.name,
          _that.mode,
          _that.drivingSide,
          _that.intersections,
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
      OsrmGeometry geometry,
      OsrmManeuver maneuver,
      double duration,
      double distance,
      String name,
      String mode,
      @JsonKey(name: 'driving_side') String drivingSide,
      List<OsrmIntersection> intersections,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmStep():
        return $default(
          _that.geometry,
          _that.maneuver,
          _that.duration,
          _that.distance,
          _that.name,
          _that.mode,
          _that.drivingSide,
          _that.intersections,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      OsrmGeometry geometry,
      OsrmManeuver maneuver,
      double duration,
      double distance,
      String name,
      String mode,
      @JsonKey(name: 'driving_side') String drivingSide,
      List<OsrmIntersection> intersections,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmStep() when $default != null:
        return $default(
          _that.geometry,
          _that.maneuver,
          _that.duration,
          _that.distance,
          _that.name,
          _that.mode,
          _that.drivingSide,
          _that.intersections,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmStep implements OsrmStep {
  const _OsrmStep({
    required this.geometry,
    required this.maneuver,
    required this.duration,
    required this.distance,
    this.name = '',
    this.mode = 'driving',
    @JsonKey(name: 'driving_side') this.drivingSide = 'right',
    final List<OsrmIntersection> intersections = const [],
  }) : _intersections = intersections;
  factory _OsrmStep.fromJson(Map<String, dynamic> json) =>
      _$OsrmStepFromJson(json);

  @override
  final OsrmGeometry geometry;
  @override
  final OsrmManeuver maneuver;
  @override
  final double duration;
  @override
  final double distance;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String mode;
  @override
  @JsonKey(name: 'driving_side')
  final String drivingSide;
  final List<OsrmIntersection> _intersections;
  @override
  @JsonKey()
  List<OsrmIntersection> get intersections {
    if (_intersections is EqualUnmodifiableListView) return _intersections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_intersections);
  }

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmStepCopyWith<_OsrmStep> get copyWith =>
      __$OsrmStepCopyWithImpl<_OsrmStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmStepToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmStep &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.maneuver, maneuver) ||
                other.maneuver == maneuver) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.drivingSide, drivingSide) ||
                other.drivingSide == drivingSide) &&
            const DeepCollectionEquality().equals(
              other._intersections,
              _intersections,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    geometry,
    maneuver,
    duration,
    distance,
    name,
    mode,
    drivingSide,
    const DeepCollectionEquality().hash(_intersections),
  );

  @override
  String toString() {
    return 'OsrmStep(geometry: $geometry, maneuver: $maneuver, duration: $duration, distance: $distance, name: $name, mode: $mode, drivingSide: $drivingSide, intersections: $intersections)';
  }
}

/// @nodoc
abstract mixin class _$OsrmStepCopyWith<$Res>
    implements $OsrmStepCopyWith<$Res> {
  factory _$OsrmStepCopyWith(_OsrmStep value, $Res Function(_OsrmStep) _then) =
      __$OsrmStepCopyWithImpl;
  @override
  @useResult
  $Res call({
    OsrmGeometry geometry,
    OsrmManeuver maneuver,
    double duration,
    double distance,
    String name,
    String mode,
    @JsonKey(name: 'driving_side') String drivingSide,
    List<OsrmIntersection> intersections,
  });

  @override
  $OsrmGeometryCopyWith<$Res> get geometry;
  @override
  $OsrmManeuverCopyWith<$Res> get maneuver;
}

/// @nodoc
class __$OsrmStepCopyWithImpl<$Res> implements _$OsrmStepCopyWith<$Res> {
  __$OsrmStepCopyWithImpl(this._self, this._then);

  final _OsrmStep _self;
  final $Res Function(_OsrmStep) _then;

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? geometry = null,
    Object? maneuver = null,
    Object? duration = null,
    Object? distance = null,
    Object? name = null,
    Object? mode = null,
    Object? drivingSide = null,
    Object? intersections = null,
  }) {
    return _then(
      _OsrmStep(
        geometry: null == geometry
            ? _self.geometry
            : geometry // ignore: cast_nullable_to_non_nullable
                  as OsrmGeometry,
        maneuver: null == maneuver
            ? _self.maneuver
            : maneuver // ignore: cast_nullable_to_non_nullable
                  as OsrmManeuver,
        duration: null == duration
            ? _self.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        mode: null == mode
            ? _self.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as String,
        drivingSide: null == drivingSide
            ? _self.drivingSide
            : drivingSide // ignore: cast_nullable_to_non_nullable
                  as String,
        intersections: null == intersections
            ? _self._intersections
            : intersections // ignore: cast_nullable_to_non_nullable
                  as List<OsrmIntersection>,
      ),
    );
  }

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OsrmGeometryCopyWith<$Res> get geometry {
    return $OsrmGeometryCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }

  /// Create a copy of OsrmStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OsrmManeuverCopyWith<$Res> get maneuver {
    return $OsrmManeuverCopyWith<$Res>(_self.maneuver, (value) {
      return _then(_self.copyWith(maneuver: value));
    });
  }
}

/// @nodoc
mixin _$OsrmManeuver {
  List<double> get location;
  @JsonKey(name: 'bearing_before')
  int get bearingBefore;
  @JsonKey(name: 'bearing_after')
  int get bearingAfter;
  String get type;
  String? get modifier;
  int get exit;

  /// Create a copy of OsrmManeuver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmManeuverCopyWith<OsrmManeuver> get copyWith =>
      _$OsrmManeuverCopyWithImpl<OsrmManeuver>(
        this as OsrmManeuver,
        _$identity,
      );

  /// Serializes this OsrmManeuver to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmManeuver &&
            const DeepCollectionEquality().equals(other.location, location) &&
            (identical(other.bearingBefore, bearingBefore) ||
                other.bearingBefore == bearingBefore) &&
            (identical(other.bearingAfter, bearingAfter) ||
                other.bearingAfter == bearingAfter) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier) &&
            (identical(other.exit, exit) || other.exit == exit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(location),
    bearingBefore,
    bearingAfter,
    type,
    modifier,
    exit,
  );

  @override
  String toString() {
    return 'OsrmManeuver(location: $location, bearingBefore: $bearingBefore, bearingAfter: $bearingAfter, type: $type, modifier: $modifier, exit: $exit)';
  }
}

/// @nodoc
abstract mixin class $OsrmManeuverCopyWith<$Res> {
  factory $OsrmManeuverCopyWith(
    OsrmManeuver value,
    $Res Function(OsrmManeuver) _then,
  ) = _$OsrmManeuverCopyWithImpl;
  @useResult
  $Res call({
    List<double> location,
    @JsonKey(name: 'bearing_before') int bearingBefore,
    @JsonKey(name: 'bearing_after') int bearingAfter,
    String type,
    String? modifier,
    int exit,
  });
}

/// @nodoc
class _$OsrmManeuverCopyWithImpl<$Res> implements $OsrmManeuverCopyWith<$Res> {
  _$OsrmManeuverCopyWithImpl(this._self, this._then);

  final OsrmManeuver _self;
  final $Res Function(OsrmManeuver) _then;

  /// Create a copy of OsrmManeuver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? bearingBefore = null,
    Object? bearingAfter = null,
    Object? type = null,
    Object? modifier = freezed,
    Object? exit = null,
  }) {
    return _then(
      _self.copyWith(
        location: null == location
            ? _self.location
            : location // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        bearingBefore: null == bearingBefore
            ? _self.bearingBefore
            : bearingBefore // ignore: cast_nullable_to_non_nullable
                  as int,
        bearingAfter: null == bearingAfter
            ? _self.bearingAfter
            : bearingAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        modifier: freezed == modifier
            ? _self.modifier
            : modifier // ignore: cast_nullable_to_non_nullable
                  as String?,
        exit: null == exit
            ? _self.exit
            : exit // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [OsrmManeuver].
extension OsrmManeuverPatterns on OsrmManeuver {
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
    TResult Function(_OsrmManeuver value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmManeuver() when $default != null:
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
    TResult Function(_OsrmManeuver value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmManeuver():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmManeuver value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmManeuver() when $default != null:
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
      List<double> location,
      @JsonKey(name: 'bearing_before') int bearingBefore,
      @JsonKey(name: 'bearing_after') int bearingAfter,
      String type,
      String? modifier,
      int exit,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmManeuver() when $default != null:
        return $default(
          _that.location,
          _that.bearingBefore,
          _that.bearingAfter,
          _that.type,
          _that.modifier,
          _that.exit,
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
      List<double> location,
      @JsonKey(name: 'bearing_before') int bearingBefore,
      @JsonKey(name: 'bearing_after') int bearingAfter,
      String type,
      String? modifier,
      int exit,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmManeuver():
        return $default(
          _that.location,
          _that.bearingBefore,
          _that.bearingAfter,
          _that.type,
          _that.modifier,
          _that.exit,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      List<double> location,
      @JsonKey(name: 'bearing_before') int bearingBefore,
      @JsonKey(name: 'bearing_after') int bearingAfter,
      String type,
      String? modifier,
      int exit,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmManeuver() when $default != null:
        return $default(
          _that.location,
          _that.bearingBefore,
          _that.bearingAfter,
          _that.type,
          _that.modifier,
          _that.exit,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmManeuver implements OsrmManeuver {
  const _OsrmManeuver({
    required final List<double> location,
    @JsonKey(name: 'bearing_before') this.bearingBefore = 0,
    @JsonKey(name: 'bearing_after') this.bearingAfter = 0,
    required this.type,
    this.modifier,
    this.exit = 0,
  }) : _location = location;
  factory _OsrmManeuver.fromJson(Map<String, dynamic> json) =>
      _$OsrmManeuverFromJson(json);

  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

  @override
  @JsonKey(name: 'bearing_before')
  final int bearingBefore;
  @override
  @JsonKey(name: 'bearing_after')
  final int bearingAfter;
  @override
  final String type;
  @override
  final String? modifier;
  @override
  @JsonKey()
  final int exit;

  /// Create a copy of OsrmManeuver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmManeuverCopyWith<_OsrmManeuver> get copyWith =>
      __$OsrmManeuverCopyWithImpl<_OsrmManeuver>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmManeuverToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmManeuver &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.bearingBefore, bearingBefore) ||
                other.bearingBefore == bearingBefore) &&
            (identical(other.bearingAfter, bearingAfter) ||
                other.bearingAfter == bearingAfter) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier) &&
            (identical(other.exit, exit) || other.exit == exit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_location),
    bearingBefore,
    bearingAfter,
    type,
    modifier,
    exit,
  );

  @override
  String toString() {
    return 'OsrmManeuver(location: $location, bearingBefore: $bearingBefore, bearingAfter: $bearingAfter, type: $type, modifier: $modifier, exit: $exit)';
  }
}

/// @nodoc
abstract mixin class _$OsrmManeuverCopyWith<$Res>
    implements $OsrmManeuverCopyWith<$Res> {
  factory _$OsrmManeuverCopyWith(
    _OsrmManeuver value,
    $Res Function(_OsrmManeuver) _then,
  ) = __$OsrmManeuverCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<double> location,
    @JsonKey(name: 'bearing_before') int bearingBefore,
    @JsonKey(name: 'bearing_after') int bearingAfter,
    String type,
    String? modifier,
    int exit,
  });
}

/// @nodoc
class __$OsrmManeuverCopyWithImpl<$Res>
    implements _$OsrmManeuverCopyWith<$Res> {
  __$OsrmManeuverCopyWithImpl(this._self, this._then);

  final _OsrmManeuver _self;
  final $Res Function(_OsrmManeuver) _then;

  /// Create a copy of OsrmManeuver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? location = null,
    Object? bearingBefore = null,
    Object? bearingAfter = null,
    Object? type = null,
    Object? modifier = freezed,
    Object? exit = null,
  }) {
    return _then(
      _OsrmManeuver(
        location: null == location
            ? _self._location
            : location // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        bearingBefore: null == bearingBefore
            ? _self.bearingBefore
            : bearingBefore // ignore: cast_nullable_to_non_nullable
                  as int,
        bearingAfter: null == bearingAfter
            ? _self.bearingAfter
            : bearingAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _self.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        modifier: freezed == modifier
            ? _self.modifier
            : modifier // ignore: cast_nullable_to_non_nullable
                  as String?,
        exit: null == exit
            ? _self.exit
            : exit // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
mixin _$OsrmIntersection {
  List<double> get location;
  List<int> get bearings;
  List<bool> get entry;
  int get out;
  @JsonKey(name: 'in')
  int? get inIndex;

  /// Create a copy of OsrmIntersection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmIntersectionCopyWith<OsrmIntersection> get copyWith =>
      _$OsrmIntersectionCopyWithImpl<OsrmIntersection>(
        this as OsrmIntersection,
        _$identity,
      );

  /// Serializes this OsrmIntersection to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmIntersection &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.bearings, bearings) &&
            const DeepCollectionEquality().equals(other.entry, entry) &&
            (identical(other.out, out) || other.out == out) &&
            (identical(other.inIndex, inIndex) || other.inIndex == inIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(location),
    const DeepCollectionEquality().hash(bearings),
    const DeepCollectionEquality().hash(entry),
    out,
    inIndex,
  );

  @override
  String toString() {
    return 'OsrmIntersection(location: $location, bearings: $bearings, entry: $entry, out: $out, inIndex: $inIndex)';
  }
}

/// @nodoc
abstract mixin class $OsrmIntersectionCopyWith<$Res> {
  factory $OsrmIntersectionCopyWith(
    OsrmIntersection value,
    $Res Function(OsrmIntersection) _then,
  ) = _$OsrmIntersectionCopyWithImpl;
  @useResult
  $Res call({
    List<double> location,
    List<int> bearings,
    List<bool> entry,
    int out,
    @JsonKey(name: 'in') int? inIndex,
  });
}

/// @nodoc
class _$OsrmIntersectionCopyWithImpl<$Res>
    implements $OsrmIntersectionCopyWith<$Res> {
  _$OsrmIntersectionCopyWithImpl(this._self, this._then);

  final OsrmIntersection _self;
  final $Res Function(OsrmIntersection) _then;

  /// Create a copy of OsrmIntersection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? bearings = null,
    Object? entry = null,
    Object? out = null,
    Object? inIndex = freezed,
  }) {
    return _then(
      _self.copyWith(
        location: null == location
            ? _self.location
            : location // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        bearings: null == bearings
            ? _self.bearings
            : bearings // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        entry: null == entry
            ? _self.entry
            : entry // ignore: cast_nullable_to_non_nullable
                  as List<bool>,
        out: null == out
            ? _self.out
            : out // ignore: cast_nullable_to_non_nullable
                  as int,
        inIndex: freezed == inIndex
            ? _self.inIndex
            : inIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [OsrmIntersection].
extension OsrmIntersectionPatterns on OsrmIntersection {
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
    TResult Function(_OsrmIntersection value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmIntersection() when $default != null:
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
    TResult Function(_OsrmIntersection value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmIntersection():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmIntersection value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmIntersection() when $default != null:
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
      List<double> location,
      List<int> bearings,
      List<bool> entry,
      int out,
      @JsonKey(name: 'in') int? inIndex,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmIntersection() when $default != null:
        return $default(
          _that.location,
          _that.bearings,
          _that.entry,
          _that.out,
          _that.inIndex,
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
      List<double> location,
      List<int> bearings,
      List<bool> entry,
      int out,
      @JsonKey(name: 'in') int? inIndex,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmIntersection():
        return $default(
          _that.location,
          _that.bearings,
          _that.entry,
          _that.out,
          _that.inIndex,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      List<double> location,
      List<int> bearings,
      List<bool> entry,
      int out,
      @JsonKey(name: 'in') int? inIndex,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmIntersection() when $default != null:
        return $default(
          _that.location,
          _that.bearings,
          _that.entry,
          _that.out,
          _that.inIndex,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmIntersection implements OsrmIntersection {
  const _OsrmIntersection({
    required final List<double> location,
    final List<int> bearings = const [],
    final List<bool> entry = const [],
    this.out = 0,
    @JsonKey(name: 'in') this.inIndex,
  }) : _location = location,
       _bearings = bearings,
       _entry = entry;
  factory _OsrmIntersection.fromJson(Map<String, dynamic> json) =>
      _$OsrmIntersectionFromJson(json);

  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

  final List<int> _bearings;
  @override
  @JsonKey()
  List<int> get bearings {
    if (_bearings is EqualUnmodifiableListView) return _bearings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bearings);
  }

  final List<bool> _entry;
  @override
  @JsonKey()
  List<bool> get entry {
    if (_entry is EqualUnmodifiableListView) return _entry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entry);
  }

  @override
  @JsonKey()
  final int out;
  @override
  @JsonKey(name: 'in')
  final int? inIndex;

  /// Create a copy of OsrmIntersection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmIntersectionCopyWith<_OsrmIntersection> get copyWith =>
      __$OsrmIntersectionCopyWithImpl<_OsrmIntersection>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmIntersectionToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmIntersection &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            const DeepCollectionEquality().equals(other._bearings, _bearings) &&
            const DeepCollectionEquality().equals(other._entry, _entry) &&
            (identical(other.out, out) || other.out == out) &&
            (identical(other.inIndex, inIndex) || other.inIndex == inIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_location),
    const DeepCollectionEquality().hash(_bearings),
    const DeepCollectionEquality().hash(_entry),
    out,
    inIndex,
  );

  @override
  String toString() {
    return 'OsrmIntersection(location: $location, bearings: $bearings, entry: $entry, out: $out, inIndex: $inIndex)';
  }
}

/// @nodoc
abstract mixin class _$OsrmIntersectionCopyWith<$Res>
    implements $OsrmIntersectionCopyWith<$Res> {
  factory _$OsrmIntersectionCopyWith(
    _OsrmIntersection value,
    $Res Function(_OsrmIntersection) _then,
  ) = __$OsrmIntersectionCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<double> location,
    List<int> bearings,
    List<bool> entry,
    int out,
    @JsonKey(name: 'in') int? inIndex,
  });
}

/// @nodoc
class __$OsrmIntersectionCopyWithImpl<$Res>
    implements _$OsrmIntersectionCopyWith<$Res> {
  __$OsrmIntersectionCopyWithImpl(this._self, this._then);

  final _OsrmIntersection _self;
  final $Res Function(_OsrmIntersection) _then;

  /// Create a copy of OsrmIntersection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? location = null,
    Object? bearings = null,
    Object? entry = null,
    Object? out = null,
    Object? inIndex = freezed,
  }) {
    return _then(
      _OsrmIntersection(
        location: null == location
            ? _self._location
            : location // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        bearings: null == bearings
            ? _self._bearings
            : bearings // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        entry: null == entry
            ? _self._entry
            : entry // ignore: cast_nullable_to_non_nullable
                  as List<bool>,
        out: null == out
            ? _self.out
            : out // ignore: cast_nullable_to_non_nullable
                  as int,
        inIndex: freezed == inIndex
            ? _self.inIndex
            : inIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
mixin _$OsrmWaypoint {
  String get hint;
  List<double> get location;
  String get name;
  double get distance;

  /// Create a copy of OsrmWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OsrmWaypointCopyWith<OsrmWaypoint> get copyWith =>
      _$OsrmWaypointCopyWithImpl<OsrmWaypoint>(
        this as OsrmWaypoint,
        _$identity,
      );

  /// Serializes this OsrmWaypoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OsrmWaypoint &&
            (identical(other.hint, hint) || other.hint == hint) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    hint,
    const DeepCollectionEquality().hash(location),
    name,
    distance,
  );

  @override
  String toString() {
    return 'OsrmWaypoint(hint: $hint, location: $location, name: $name, distance: $distance)';
  }
}

/// @nodoc
abstract mixin class $OsrmWaypointCopyWith<$Res> {
  factory $OsrmWaypointCopyWith(
    OsrmWaypoint value,
    $Res Function(OsrmWaypoint) _then,
  ) = _$OsrmWaypointCopyWithImpl;
  @useResult
  $Res call({String hint, List<double> location, String name, double distance});
}

/// @nodoc
class _$OsrmWaypointCopyWithImpl<$Res> implements $OsrmWaypointCopyWith<$Res> {
  _$OsrmWaypointCopyWithImpl(this._self, this._then);

  final OsrmWaypoint _self;
  final $Res Function(OsrmWaypoint) _then;

  /// Create a copy of OsrmWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hint = null,
    Object? location = null,
    Object? name = null,
    Object? distance = null,
  }) {
    return _then(
      _self.copyWith(
        hint: null == hint
            ? _self.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _self.location
            : location // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [OsrmWaypoint].
extension OsrmWaypointPatterns on OsrmWaypoint {
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
    TResult Function(_OsrmWaypoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmWaypoint() when $default != null:
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
    TResult Function(_OsrmWaypoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmWaypoint():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_OsrmWaypoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmWaypoint() when $default != null:
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
      String hint,
      List<double> location,
      String name,
      double distance,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _OsrmWaypoint() when $default != null:
        return $default(_that.hint, _that.location, _that.name, _that.distance);
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
      String hint,
      List<double> location,
      String name,
      double distance,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmWaypoint():
        return $default(_that.hint, _that.location, _that.name, _that.distance);
      case _:
        throw StateError('Unexpected subclass');
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
      String hint,
      List<double> location,
      String name,
      double distance,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _OsrmWaypoint() when $default != null:
        return $default(_that.hint, _that.location, _that.name, _that.distance);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _OsrmWaypoint implements OsrmWaypoint {
  const _OsrmWaypoint({
    required this.hint,
    required final List<double> location,
    required this.name,
    required this.distance,
  }) : _location = location;
  factory _OsrmWaypoint.fromJson(Map<String, dynamic> json) =>
      _$OsrmWaypointFromJson(json);

  @override
  final String hint;
  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

  @override
  final String name;
  @override
  final double distance;

  /// Create a copy of OsrmWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OsrmWaypointCopyWith<_OsrmWaypoint> get copyWith =>
      __$OsrmWaypointCopyWithImpl<_OsrmWaypoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OsrmWaypointToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OsrmWaypoint &&
            (identical(other.hint, hint) || other.hint == hint) &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    hint,
    const DeepCollectionEquality().hash(_location),
    name,
    distance,
  );

  @override
  String toString() {
    return 'OsrmWaypoint(hint: $hint, location: $location, name: $name, distance: $distance)';
  }
}

/// @nodoc
abstract mixin class _$OsrmWaypointCopyWith<$Res>
    implements $OsrmWaypointCopyWith<$Res> {
  factory _$OsrmWaypointCopyWith(
    _OsrmWaypoint value,
    $Res Function(_OsrmWaypoint) _then,
  ) = __$OsrmWaypointCopyWithImpl;
  @override
  @useResult
  $Res call({String hint, List<double> location, String name, double distance});
}

/// @nodoc
class __$OsrmWaypointCopyWithImpl<$Res>
    implements _$OsrmWaypointCopyWith<$Res> {
  __$OsrmWaypointCopyWithImpl(this._self, this._then);

  final _OsrmWaypoint _self;
  final $Res Function(_OsrmWaypoint) _then;

  /// Create a copy of OsrmWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? hint = null,
    Object? location = null,
    Object? name = null,
    Object? distance = null,
  }) {
    return _then(
      _OsrmWaypoint(
        hint: null == hint
            ? _self.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _self._location
            : location // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        distance: null == distance
            ? _self.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
mixin _$NavigationData {
  String get id;
  LatLng get origin;
  LatLng get destination;
  List<LatLng> get routePoints;
  List<NavigationStep> get steps;
  double get totalDistanceMeters;
  double get totalDurationSeconds;
  String get originName;
  String get destinationName;
  int get currentStepIndex;
  bool get isNavigating;
  bool get isCompleted;
  DateTime? get startTime;
  double? get remainingDistanceMeters;
  double? get remainingDurationSeconds;

  /// Create a copy of NavigationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NavigationDataCopyWith<NavigationData> get copyWith =>
      _$NavigationDataCopyWithImpl<NavigationData>(
        this as NavigationData,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NavigationData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            const DeepCollectionEquality().equals(
              other.routePoints,
              routePoints,
            ) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.totalDistanceMeters, totalDistanceMeters) ||
                other.totalDistanceMeters == totalDistanceMeters) &&
            (identical(other.totalDurationSeconds, totalDurationSeconds) ||
                other.totalDurationSeconds == totalDurationSeconds) &&
            (identical(other.originName, originName) ||
                other.originName == originName) &&
            (identical(other.destinationName, destinationName) ||
                other.destinationName == destinationName) &&
            (identical(other.currentStepIndex, currentStepIndex) ||
                other.currentStepIndex == currentStepIndex) &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(
                  other.remainingDistanceMeters,
                  remainingDistanceMeters,
                ) ||
                other.remainingDistanceMeters == remainingDistanceMeters) &&
            (identical(
                  other.remainingDurationSeconds,
                  remainingDurationSeconds,
                ) ||
                other.remainingDurationSeconds == remainingDurationSeconds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    origin,
    destination,
    const DeepCollectionEquality().hash(routePoints),
    const DeepCollectionEquality().hash(steps),
    totalDistanceMeters,
    totalDurationSeconds,
    originName,
    destinationName,
    currentStepIndex,
    isNavigating,
    isCompleted,
    startTime,
    remainingDistanceMeters,
    remainingDurationSeconds,
  );

  @override
  String toString() {
    return 'NavigationData(id: $id, origin: $origin, destination: $destination, routePoints: $routePoints, steps: $steps, totalDistanceMeters: $totalDistanceMeters, totalDurationSeconds: $totalDurationSeconds, originName: $originName, destinationName: $destinationName, currentStepIndex: $currentStepIndex, isNavigating: $isNavigating, isCompleted: $isCompleted, startTime: $startTime, remainingDistanceMeters: $remainingDistanceMeters, remainingDurationSeconds: $remainingDurationSeconds)';
  }
}

/// @nodoc
abstract mixin class $NavigationDataCopyWith<$Res> {
  factory $NavigationDataCopyWith(
    NavigationData value,
    $Res Function(NavigationData) _then,
  ) = _$NavigationDataCopyWithImpl;
  @useResult
  $Res call({
    String id,
    LatLng origin,
    LatLng destination,
    List<LatLng> routePoints,
    List<NavigationStep> steps,
    double totalDistanceMeters,
    double totalDurationSeconds,
    String originName,
    String destinationName,
    int currentStepIndex,
    bool isNavigating,
    bool isCompleted,
    DateTime? startTime,
    double? remainingDistanceMeters,
    double? remainingDurationSeconds,
  });
}

/// @nodoc
class _$NavigationDataCopyWithImpl<$Res>
    implements $NavigationDataCopyWith<$Res> {
  _$NavigationDataCopyWithImpl(this._self, this._then);

  final NavigationData _self;
  final $Res Function(NavigationData) _then;

  /// Create a copy of NavigationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? origin = null,
    Object? destination = null,
    Object? routePoints = null,
    Object? steps = null,
    Object? totalDistanceMeters = null,
    Object? totalDurationSeconds = null,
    Object? originName = null,
    Object? destinationName = null,
    Object? currentStepIndex = null,
    Object? isNavigating = null,
    Object? isCompleted = null,
    Object? startTime = freezed,
    Object? remainingDistanceMeters = freezed,
    Object? remainingDurationSeconds = freezed,
  }) {
    return _then(
      _self.copyWith(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        origin: null == origin
            ? _self.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        destination: null == destination
            ? _self.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        routePoints: null == routePoints
            ? _self.routePoints
            : routePoints // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
        steps: null == steps
            ? _self.steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<NavigationStep>,
        totalDistanceMeters: null == totalDistanceMeters
            ? _self.totalDistanceMeters
            : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
                  as double,
        totalDurationSeconds: null == totalDurationSeconds
            ? _self.totalDurationSeconds
            : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        originName: null == originName
            ? _self.originName
            : originName // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationName: null == destinationName
            ? _self.destinationName
            : destinationName // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStepIndex: null == currentStepIndex
            ? _self.currentStepIndex
            : currentStepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isNavigating: null == isNavigating
            ? _self.isNavigating
            : isNavigating // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompleted: null == isCompleted
            ? _self.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        startTime: freezed == startTime
            ? _self.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        remainingDistanceMeters: freezed == remainingDistanceMeters
            ? _self.remainingDistanceMeters
            : remainingDistanceMeters // ignore: cast_nullable_to_non_nullable
                  as double?,
        remainingDurationSeconds: freezed == remainingDurationSeconds
            ? _self.remainingDurationSeconds
            : remainingDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [NavigationData].
extension NavigationDataPatterns on NavigationData {
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
    TResult Function(_NavigationData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NavigationData() when $default != null:
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
    TResult Function(_NavigationData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_NavigationData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationData() when $default != null:
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
      String id,
      LatLng origin,
      LatLng destination,
      List<LatLng> routePoints,
      List<NavigationStep> steps,
      double totalDistanceMeters,
      double totalDurationSeconds,
      String originName,
      String destinationName,
      int currentStepIndex,
      bool isNavigating,
      bool isCompleted,
      DateTime? startTime,
      double? remainingDistanceMeters,
      double? remainingDurationSeconds,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NavigationData() when $default != null:
        return $default(
          _that.id,
          _that.origin,
          _that.destination,
          _that.routePoints,
          _that.steps,
          _that.totalDistanceMeters,
          _that.totalDurationSeconds,
          _that.originName,
          _that.destinationName,
          _that.currentStepIndex,
          _that.isNavigating,
          _that.isCompleted,
          _that.startTime,
          _that.remainingDistanceMeters,
          _that.remainingDurationSeconds,
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
      String id,
      LatLng origin,
      LatLng destination,
      List<LatLng> routePoints,
      List<NavigationStep> steps,
      double totalDistanceMeters,
      double totalDurationSeconds,
      String originName,
      String destinationName,
      int currentStepIndex,
      bool isNavigating,
      bool isCompleted,
      DateTime? startTime,
      double? remainingDistanceMeters,
      double? remainingDurationSeconds,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationData():
        return $default(
          _that.id,
          _that.origin,
          _that.destination,
          _that.routePoints,
          _that.steps,
          _that.totalDistanceMeters,
          _that.totalDurationSeconds,
          _that.originName,
          _that.destinationName,
          _that.currentStepIndex,
          _that.isNavigating,
          _that.isCompleted,
          _that.startTime,
          _that.remainingDistanceMeters,
          _that.remainingDurationSeconds,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      String id,
      LatLng origin,
      LatLng destination,
      List<LatLng> routePoints,
      List<NavigationStep> steps,
      double totalDistanceMeters,
      double totalDurationSeconds,
      String originName,
      String destinationName,
      int currentStepIndex,
      bool isNavigating,
      bool isCompleted,
      DateTime? startTime,
      double? remainingDistanceMeters,
      double? remainingDurationSeconds,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationData() when $default != null:
        return $default(
          _that.id,
          _that.origin,
          _that.destination,
          _that.routePoints,
          _that.steps,
          _that.totalDistanceMeters,
          _that.totalDurationSeconds,
          _that.originName,
          _that.destinationName,
          _that.currentStepIndex,
          _that.isNavigating,
          _that.isCompleted,
          _that.startTime,
          _that.remainingDistanceMeters,
          _that.remainingDurationSeconds,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NavigationData extends NavigationData {
  const _NavigationData({
    required this.id,
    required this.origin,
    required this.destination,
    required final List<LatLng> routePoints,
    required final List<NavigationStep> steps,
    required this.totalDistanceMeters,
    required this.totalDurationSeconds,
    required this.originName,
    required this.destinationName,
    this.currentStepIndex = 0,
    this.isNavigating = false,
    this.isCompleted = false,
    this.startTime,
    this.remainingDistanceMeters,
    this.remainingDurationSeconds,
  }) : _routePoints = routePoints,
       _steps = steps,
       super._();

  @override
  final String id;
  @override
  final LatLng origin;
  @override
  final LatLng destination;
  final List<LatLng> _routePoints;
  @override
  List<LatLng> get routePoints {
    if (_routePoints is EqualUnmodifiableListView) return _routePoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routePoints);
  }

  final List<NavigationStep> _steps;
  @override
  List<NavigationStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final double totalDistanceMeters;
  @override
  final double totalDurationSeconds;
  @override
  final String originName;
  @override
  final String destinationName;
  @override
  @JsonKey()
  final int currentStepIndex;
  @override
  @JsonKey()
  final bool isNavigating;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? startTime;
  @override
  final double? remainingDistanceMeters;
  @override
  final double? remainingDurationSeconds;

  /// Create a copy of NavigationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NavigationDataCopyWith<_NavigationData> get copyWith =>
      __$NavigationDataCopyWithImpl<_NavigationData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigationData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            const DeepCollectionEquality().equals(
              other._routePoints,
              _routePoints,
            ) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.totalDistanceMeters, totalDistanceMeters) ||
                other.totalDistanceMeters == totalDistanceMeters) &&
            (identical(other.totalDurationSeconds, totalDurationSeconds) ||
                other.totalDurationSeconds == totalDurationSeconds) &&
            (identical(other.originName, originName) ||
                other.originName == originName) &&
            (identical(other.destinationName, destinationName) ||
                other.destinationName == destinationName) &&
            (identical(other.currentStepIndex, currentStepIndex) ||
                other.currentStepIndex == currentStepIndex) &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(
                  other.remainingDistanceMeters,
                  remainingDistanceMeters,
                ) ||
                other.remainingDistanceMeters == remainingDistanceMeters) &&
            (identical(
                  other.remainingDurationSeconds,
                  remainingDurationSeconds,
                ) ||
                other.remainingDurationSeconds == remainingDurationSeconds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    origin,
    destination,
    const DeepCollectionEquality().hash(_routePoints),
    const DeepCollectionEquality().hash(_steps),
    totalDistanceMeters,
    totalDurationSeconds,
    originName,
    destinationName,
    currentStepIndex,
    isNavigating,
    isCompleted,
    startTime,
    remainingDistanceMeters,
    remainingDurationSeconds,
  );

  @override
  String toString() {
    return 'NavigationData(id: $id, origin: $origin, destination: $destination, routePoints: $routePoints, steps: $steps, totalDistanceMeters: $totalDistanceMeters, totalDurationSeconds: $totalDurationSeconds, originName: $originName, destinationName: $destinationName, currentStepIndex: $currentStepIndex, isNavigating: $isNavigating, isCompleted: $isCompleted, startTime: $startTime, remainingDistanceMeters: $remainingDistanceMeters, remainingDurationSeconds: $remainingDurationSeconds)';
  }
}

/// @nodoc
abstract mixin class _$NavigationDataCopyWith<$Res>
    implements $NavigationDataCopyWith<$Res> {
  factory _$NavigationDataCopyWith(
    _NavigationData value,
    $Res Function(_NavigationData) _then,
  ) = __$NavigationDataCopyWithImpl;
  @override
  @useResult
  $Res call({
    String id,
    LatLng origin,
    LatLng destination,
    List<LatLng> routePoints,
    List<NavigationStep> steps,
    double totalDistanceMeters,
    double totalDurationSeconds,
    String originName,
    String destinationName,
    int currentStepIndex,
    bool isNavigating,
    bool isCompleted,
    DateTime? startTime,
    double? remainingDistanceMeters,
    double? remainingDurationSeconds,
  });
}

/// @nodoc
class __$NavigationDataCopyWithImpl<$Res>
    implements _$NavigationDataCopyWith<$Res> {
  __$NavigationDataCopyWithImpl(this._self, this._then);

  final _NavigationData _self;
  final $Res Function(_NavigationData) _then;

  /// Create a copy of NavigationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? origin = null,
    Object? destination = null,
    Object? routePoints = null,
    Object? steps = null,
    Object? totalDistanceMeters = null,
    Object? totalDurationSeconds = null,
    Object? originName = null,
    Object? destinationName = null,
    Object? currentStepIndex = null,
    Object? isNavigating = null,
    Object? isCompleted = null,
    Object? startTime = freezed,
    Object? remainingDistanceMeters = freezed,
    Object? remainingDurationSeconds = freezed,
  }) {
    return _then(
      _NavigationData(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        origin: null == origin
            ? _self.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        destination: null == destination
            ? _self.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        routePoints: null == routePoints
            ? _self._routePoints
            : routePoints // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
        steps: null == steps
            ? _self._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<NavigationStep>,
        totalDistanceMeters: null == totalDistanceMeters
            ? _self.totalDistanceMeters
            : totalDistanceMeters // ignore: cast_nullable_to_non_nullable
                  as double,
        totalDurationSeconds: null == totalDurationSeconds
            ? _self.totalDurationSeconds
            : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        originName: null == originName
            ? _self.originName
            : originName // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationName: null == destinationName
            ? _self.destinationName
            : destinationName // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStepIndex: null == currentStepIndex
            ? _self.currentStepIndex
            : currentStepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isNavigating: null == isNavigating
            ? _self.isNavigating
            : isNavigating // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompleted: null == isCompleted
            ? _self.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        startTime: freezed == startTime
            ? _self.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        remainingDistanceMeters: freezed == remainingDistanceMeters
            ? _self.remainingDistanceMeters
            : remainingDistanceMeters // ignore: cast_nullable_to_non_nullable
                  as double?,
        remainingDurationSeconds: freezed == remainingDurationSeconds
            ? _self.remainingDurationSeconds
            : remainingDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
mixin _$NavigationStep {
  int get index;
  LatLng get location;
  ManeuverType get maneuverType;
  String get instruction;
  double get distanceMeters;
  double get durationSeconds;
  String get streetName;
  int get bearingBefore;
  int get bearingAfter;
  String? get modifier;
  List<LatLng> get stepPoints;

  /// Create a copy of NavigationStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NavigationStepCopyWith<NavigationStep> get copyWith =>
      _$NavigationStepCopyWithImpl<NavigationStep>(
        this as NavigationStep,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NavigationStep &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.maneuverType, maneuverType) ||
                other.maneuverType == maneuverType) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName) &&
            (identical(other.bearingBefore, bearingBefore) ||
                other.bearingBefore == bearingBefore) &&
            (identical(other.bearingAfter, bearingAfter) ||
                other.bearingAfter == bearingAfter) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier) &&
            const DeepCollectionEquality().equals(
              other.stepPoints,
              stepPoints,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    index,
    location,
    maneuverType,
    instruction,
    distanceMeters,
    durationSeconds,
    streetName,
    bearingBefore,
    bearingAfter,
    modifier,
    const DeepCollectionEquality().hash(stepPoints),
  );

  @override
  String toString() {
    return 'NavigationStep(index: $index, location: $location, maneuverType: $maneuverType, instruction: $instruction, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, streetName: $streetName, bearingBefore: $bearingBefore, bearingAfter: $bearingAfter, modifier: $modifier, stepPoints: $stepPoints)';
  }
}

/// @nodoc
abstract mixin class $NavigationStepCopyWith<$Res> {
  factory $NavigationStepCopyWith(
    NavigationStep value,
    $Res Function(NavigationStep) _then,
  ) = _$NavigationStepCopyWithImpl;
  @useResult
  $Res call({
    int index,
    LatLng location,
    ManeuverType maneuverType,
    String instruction,
    double distanceMeters,
    double durationSeconds,
    String streetName,
    int bearingBefore,
    int bearingAfter,
    String? modifier,
    List<LatLng> stepPoints,
  });
}

/// @nodoc
class _$NavigationStepCopyWithImpl<$Res>
    implements $NavigationStepCopyWith<$Res> {
  _$NavigationStepCopyWithImpl(this._self, this._then);

  final NavigationStep _self;
  final $Res Function(NavigationStep) _then;

  /// Create a copy of NavigationStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? location = null,
    Object? maneuverType = null,
    Object? instruction = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? streetName = null,
    Object? bearingBefore = null,
    Object? bearingAfter = null,
    Object? modifier = freezed,
    Object? stepPoints = null,
  }) {
    return _then(
      _self.copyWith(
        index: null == index
            ? _self.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        location: null == location
            ? _self.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        maneuverType: null == maneuverType
            ? _self.maneuverType
            : maneuverType // ignore: cast_nullable_to_non_nullable
                  as ManeuverType,
        instruction: null == instruction
            ? _self.instruction
            : instruction // ignore: cast_nullable_to_non_nullable
                  as String,
        distanceMeters: null == distanceMeters
            ? _self.distanceMeters
            : distanceMeters // ignore: cast_nullable_to_non_nullable
                  as double,
        durationSeconds: null == durationSeconds
            ? _self.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        streetName: null == streetName
            ? _self.streetName
            : streetName // ignore: cast_nullable_to_non_nullable
                  as String,
        bearingBefore: null == bearingBefore
            ? _self.bearingBefore
            : bearingBefore // ignore: cast_nullable_to_non_nullable
                  as int,
        bearingAfter: null == bearingAfter
            ? _self.bearingAfter
            : bearingAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        modifier: freezed == modifier
            ? _self.modifier
            : modifier // ignore: cast_nullable_to_non_nullable
                  as String?,
        stepPoints: null == stepPoints
            ? _self.stepPoints
            : stepPoints // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [NavigationStep].
extension NavigationStepPatterns on NavigationStep {
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
    TResult Function(_NavigationStep value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NavigationStep() when $default != null:
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
    TResult Function(_NavigationStep value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationStep():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_NavigationStep value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationStep() when $default != null:
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
      int index,
      LatLng location,
      ManeuverType maneuverType,
      String instruction,
      double distanceMeters,
      double durationSeconds,
      String streetName,
      int bearingBefore,
      int bearingAfter,
      String? modifier,
      List<LatLng> stepPoints,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NavigationStep() when $default != null:
        return $default(
          _that.index,
          _that.location,
          _that.maneuverType,
          _that.instruction,
          _that.distanceMeters,
          _that.durationSeconds,
          _that.streetName,
          _that.bearingBefore,
          _that.bearingAfter,
          _that.modifier,
          _that.stepPoints,
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
      int index,
      LatLng location,
      ManeuverType maneuverType,
      String instruction,
      double distanceMeters,
      double durationSeconds,
      String streetName,
      int bearingBefore,
      int bearingAfter,
      String? modifier,
      List<LatLng> stepPoints,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationStep():
        return $default(
          _that.index,
          _that.location,
          _that.maneuverType,
          _that.instruction,
          _that.distanceMeters,
          _that.durationSeconds,
          _that.streetName,
          _that.bearingBefore,
          _that.bearingAfter,
          _that.modifier,
          _that.stepPoints,
        );
      case _:
        throw StateError('Unexpected subclass');
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
      int index,
      LatLng location,
      ManeuverType maneuverType,
      String instruction,
      double distanceMeters,
      double durationSeconds,
      String streetName,
      int bearingBefore,
      int bearingAfter,
      String? modifier,
      List<LatLng> stepPoints,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationStep() when $default != null:
        return $default(
          _that.index,
          _that.location,
          _that.maneuverType,
          _that.instruction,
          _that.distanceMeters,
          _that.durationSeconds,
          _that.streetName,
          _that.bearingBefore,
          _that.bearingAfter,
          _that.modifier,
          _that.stepPoints,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NavigationStep extends NavigationStep {
  const _NavigationStep({
    required this.index,
    required this.location,
    required this.maneuverType,
    required this.instruction,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.streetName,
    this.bearingBefore = 0,
    this.bearingAfter = 0,
    this.modifier,
    final List<LatLng> stepPoints = const [],
  }) : _stepPoints = stepPoints,
       super._();

  @override
  final int index;
  @override
  final LatLng location;
  @override
  final ManeuverType maneuverType;
  @override
  final String instruction;
  @override
  final double distanceMeters;
  @override
  final double durationSeconds;
  @override
  final String streetName;
  @override
  @JsonKey()
  final int bearingBefore;
  @override
  @JsonKey()
  final int bearingAfter;
  @override
  final String? modifier;
  final List<LatLng> _stepPoints;
  @override
  @JsonKey()
  List<LatLng> get stepPoints {
    if (_stepPoints is EqualUnmodifiableListView) return _stepPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stepPoints);
  }

  /// Create a copy of NavigationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NavigationStepCopyWith<_NavigationStep> get copyWith =>
      __$NavigationStepCopyWithImpl<_NavigationStep>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigationStep &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.maneuverType, maneuverType) ||
                other.maneuverType == maneuverType) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.distanceMeters, distanceMeters) ||
                other.distanceMeters == distanceMeters) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName) &&
            (identical(other.bearingBefore, bearingBefore) ||
                other.bearingBefore == bearingBefore) &&
            (identical(other.bearingAfter, bearingAfter) ||
                other.bearingAfter == bearingAfter) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier) &&
            const DeepCollectionEquality().equals(
              other._stepPoints,
              _stepPoints,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    index,
    location,
    maneuverType,
    instruction,
    distanceMeters,
    durationSeconds,
    streetName,
    bearingBefore,
    bearingAfter,
    modifier,
    const DeepCollectionEquality().hash(_stepPoints),
  );

  @override
  String toString() {
    return 'NavigationStep(index: $index, location: $location, maneuverType: $maneuverType, instruction: $instruction, distanceMeters: $distanceMeters, durationSeconds: $durationSeconds, streetName: $streetName, bearingBefore: $bearingBefore, bearingAfter: $bearingAfter, modifier: $modifier, stepPoints: $stepPoints)';
  }
}

/// @nodoc
abstract mixin class _$NavigationStepCopyWith<$Res>
    implements $NavigationStepCopyWith<$Res> {
  factory _$NavigationStepCopyWith(
    _NavigationStep value,
    $Res Function(_NavigationStep) _then,
  ) = __$NavigationStepCopyWithImpl;
  @override
  @useResult
  $Res call({
    int index,
    LatLng location,
    ManeuverType maneuverType,
    String instruction,
    double distanceMeters,
    double durationSeconds,
    String streetName,
    int bearingBefore,
    int bearingAfter,
    String? modifier,
    List<LatLng> stepPoints,
  });
}

/// @nodoc
class __$NavigationStepCopyWithImpl<$Res>
    implements _$NavigationStepCopyWith<$Res> {
  __$NavigationStepCopyWithImpl(this._self, this._then);

  final _NavigationStep _self;
  final $Res Function(_NavigationStep) _then;

  /// Create a copy of NavigationStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
    Object? location = null,
    Object? maneuverType = null,
    Object? instruction = null,
    Object? distanceMeters = null,
    Object? durationSeconds = null,
    Object? streetName = null,
    Object? bearingBefore = null,
    Object? bearingAfter = null,
    Object? modifier = freezed,
    Object? stepPoints = null,
  }) {
    return _then(
      _NavigationStep(
        index: null == index
            ? _self.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        location: null == location
            ? _self.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        maneuverType: null == maneuverType
            ? _self.maneuverType
            : maneuverType // ignore: cast_nullable_to_non_nullable
                  as ManeuverType,
        instruction: null == instruction
            ? _self.instruction
            : instruction // ignore: cast_nullable_to_non_nullable
                  as String,
        distanceMeters: null == distanceMeters
            ? _self.distanceMeters
            : distanceMeters // ignore: cast_nullable_to_non_nullable
                  as double,
        durationSeconds: null == durationSeconds
            ? _self.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as double,
        streetName: null == streetName
            ? _self.streetName
            : streetName // ignore: cast_nullable_to_non_nullable
                  as String,
        bearingBefore: null == bearingBefore
            ? _self.bearingBefore
            : bearingBefore // ignore: cast_nullable_to_non_nullable
                  as int,
        bearingAfter: null == bearingAfter
            ? _self.bearingAfter
            : bearingAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        modifier: freezed == modifier
            ? _self.modifier
            : modifier // ignore: cast_nullable_to_non_nullable
                  as String?,
        stepPoints: null == stepPoints
            ? _self._stepPoints
            : stepPoints // ignore: cast_nullable_to_non_nullable
                  as List<LatLng>,
      ),
    );
  }
}
