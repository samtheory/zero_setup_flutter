// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PoiModel {
  String get id;
  String get name;
  double get latitude;
  double get longitude;
  PoiCategory get category;
  String? get description;
  String? get address;
  String? get phoneNumber;
  String? get imageUrl;
  Map<String, dynamic>? get metadata;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of PoiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PoiModelCopyWith<PoiModel> get copyWith =>
      _$PoiModelCopyWithImpl<PoiModel>(this as PoiModel, _$identity);

  /// Serializes this PoiModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PoiModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other.metadata, metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    latitude,
    longitude,
    category,
    description,
    address,
    phoneNumber,
    imageUrl,
    const DeepCollectionEquality().hash(metadata),
    createdAt,
    updatedAt,
  );

  @override
  String toString() {
    return 'PoiModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, category: $category, description: $description, address: $address, phoneNumber: $phoneNumber, imageUrl: $imageUrl, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $PoiModelCopyWith<$Res> {
  factory $PoiModelCopyWith(PoiModel value, $Res Function(PoiModel) _then) =
      _$PoiModelCopyWithImpl;
  @useResult
  $Res call({
    String id,
    String name,
    double latitude,
    double longitude,
    PoiCategory category,
    String? description,
    String? address,
    String? phoneNumber,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$PoiModelCopyWithImpl<$Res> implements $PoiModelCopyWith<$Res> {
  _$PoiModelCopyWithImpl(this._self, this._then);

  final PoiModel _self;
  final $Res Function(PoiModel) _then;

  /// Create a copy of PoiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? category = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? imageUrl = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _self.copyWith(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        category: null == category
            ? _self.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PoiCategory,
        description: freezed == description
            ? _self.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _self.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _self.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _self.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: freezed == metadata
            ? _self.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: freezed == createdAt
            ? _self.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _self.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [PoiModel].
extension PoiModelPatterns on PoiModel {
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
    TResult Function(_PoiModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PoiModel() when $default != null:
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
    TResult Function(_PoiModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiModel():
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
    TResult? Function(_PoiModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiModel() when $default != null:
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
      String name,
      double latitude,
      double longitude,
      PoiCategory category,
      String? description,
      String? address,
      String? phoneNumber,
      String? imageUrl,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PoiModel() when $default != null:
        return $default(
          _that.id,
          _that.name,
          _that.latitude,
          _that.longitude,
          _that.category,
          _that.description,
          _that.address,
          _that.phoneNumber,
          _that.imageUrl,
          _that.metadata,
          _that.createdAt,
          _that.updatedAt,
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
      String name,
      double latitude,
      double longitude,
      PoiCategory category,
      String? description,
      String? address,
      String? phoneNumber,
      String? imageUrl,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiModel():
        return $default(
          _that.id,
          _that.name,
          _that.latitude,
          _that.longitude,
          _that.category,
          _that.description,
          _that.address,
          _that.phoneNumber,
          _that.imageUrl,
          _that.metadata,
          _that.createdAt,
          _that.updatedAt,
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
      String id,
      String name,
      double latitude,
      double longitude,
      PoiCategory category,
      String? description,
      String? address,
      String? phoneNumber,
      String? imageUrl,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PoiModel() when $default != null:
        return $default(
          _that.id,
          _that.name,
          _that.latitude,
          _that.longitude,
          _that.category,
          _that.description,
          _that.address,
          _that.phoneNumber,
          _that.imageUrl,
          _that.metadata,
          _that.createdAt,
          _that.updatedAt,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PoiModel extends PoiModel {
  const _PoiModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.category = PoiCategory.other,
    this.description,
    this.address,
    this.phoneNumber,
    this.imageUrl,
    final Map<String, dynamic>? metadata,
    this.createdAt,
    this.updatedAt,
  }) : _metadata = metadata,
       super._();
  factory _PoiModel.fromJson(Map<String, dynamic> json) =>
      _$PoiModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final PoiCategory category;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final String? phoneNumber;
  @override
  final String? imageUrl;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of PoiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PoiModelCopyWith<_PoiModel> get copyWith =>
      __$PoiModelCopyWithImpl<_PoiModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PoiModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PoiModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    latitude,
    longitude,
    category,
    description,
    address,
    phoneNumber,
    imageUrl,
    const DeepCollectionEquality().hash(_metadata),
    createdAt,
    updatedAt,
  );

  @override
  String toString() {
    return 'PoiModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, category: $category, description: $description, address: $address, phoneNumber: $phoneNumber, imageUrl: $imageUrl, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PoiModelCopyWith<$Res>
    implements $PoiModelCopyWith<$Res> {
  factory _$PoiModelCopyWith(_PoiModel value, $Res Function(_PoiModel) _then) =
      __$PoiModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double latitude,
    double longitude,
    PoiCategory category,
    String? description,
    String? address,
    String? phoneNumber,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$PoiModelCopyWithImpl<$Res> implements _$PoiModelCopyWith<$Res> {
  __$PoiModelCopyWithImpl(this._self, this._then);

  final _PoiModel _self;
  final $Res Function(_PoiModel) _then;

  /// Create a copy of PoiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? category = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? imageUrl = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _PoiModel(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        category: null == category
            ? _self.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PoiCategory,
        description: freezed == description
            ? _self.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _self.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _self.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _self.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: freezed == metadata
            ? _self._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: freezed == createdAt
            ? _self.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _self.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
mixin _$RouteWaypoint {
  double get latitude;
  double get longitude;
  String? get name;
  int? get order;

  /// Create a copy of RouteWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteWaypointCopyWith<RouteWaypoint> get copyWith =>
      _$RouteWaypointCopyWithImpl<RouteWaypoint>(
        this as RouteWaypoint,
        _$identity,
      );

  /// Serializes this RouteWaypoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteWaypoint &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, name, order);

  @override
  String toString() {
    return 'RouteWaypoint(latitude: $latitude, longitude: $longitude, name: $name, order: $order)';
  }
}

/// @nodoc
abstract mixin class $RouteWaypointCopyWith<$Res> {
  factory $RouteWaypointCopyWith(
    RouteWaypoint value,
    $Res Function(RouteWaypoint) _then,
  ) = _$RouteWaypointCopyWithImpl;
  @useResult
  $Res call({double latitude, double longitude, String? name, int? order});
}

/// @nodoc
class _$RouteWaypointCopyWithImpl<$Res>
    implements $RouteWaypointCopyWith<$Res> {
  _$RouteWaypointCopyWithImpl(this._self, this._then);

  final RouteWaypoint _self;
  final $Res Function(RouteWaypoint) _then;

  /// Create a copy of RouteWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? name = freezed,
    Object? order = freezed,
  }) {
    return _then(
      _self.copyWith(
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        name: freezed == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        order: freezed == order
            ? _self.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RouteWaypoint].
extension RouteWaypointPatterns on RouteWaypoint {
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
    TResult Function(_RouteWaypoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteWaypoint() when $default != null:
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
    TResult Function(_RouteWaypoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteWaypoint():
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
    TResult? Function(_RouteWaypoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteWaypoint() when $default != null:
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
      double latitude,
      double longitude,
      String? name,
      int? order,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteWaypoint() when $default != null:
        return $default(
          _that.latitude,
          _that.longitude,
          _that.name,
          _that.order,
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
      double latitude,
      double longitude,
      String? name,
      int? order,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteWaypoint():
        return $default(
          _that.latitude,
          _that.longitude,
          _that.name,
          _that.order,
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
      double latitude,
      double longitude,
      String? name,
      int? order,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteWaypoint() when $default != null:
        return $default(
          _that.latitude,
          _that.longitude,
          _that.name,
          _that.order,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RouteWaypoint extends RouteWaypoint {
  const _RouteWaypoint({
    required this.latitude,
    required this.longitude,
    this.name,
    this.order,
  }) : super._();
  factory _RouteWaypoint.fromJson(Map<String, dynamic> json) =>
      _$RouteWaypointFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? name;
  @override
  final int? order;

  /// Create a copy of RouteWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteWaypointCopyWith<_RouteWaypoint> get copyWith =>
      __$RouteWaypointCopyWithImpl<_RouteWaypoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RouteWaypointToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteWaypoint &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, name, order);

  @override
  String toString() {
    return 'RouteWaypoint(latitude: $latitude, longitude: $longitude, name: $name, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$RouteWaypointCopyWith<$Res>
    implements $RouteWaypointCopyWith<$Res> {
  factory _$RouteWaypointCopyWith(
    _RouteWaypoint value,
    $Res Function(_RouteWaypoint) _then,
  ) = __$RouteWaypointCopyWithImpl;
  @override
  @useResult
  $Res call({double latitude, double longitude, String? name, int? order});
}

/// @nodoc
class __$RouteWaypointCopyWithImpl<$Res>
    implements _$RouteWaypointCopyWith<$Res> {
  __$RouteWaypointCopyWithImpl(this._self, this._then);

  final _RouteWaypoint _self;
  final $Res Function(_RouteWaypoint) _then;

  /// Create a copy of RouteWaypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? name = freezed,
    Object? order = freezed,
  }) {
    return _then(
      _RouteWaypoint(
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        name: freezed == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        order: freezed == order
            ? _self.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
mixin _$RouteModel {
  String get id;
  String get name;
  List<RouteWaypoint> get waypoints;
  int get color; // Default blue color
  double get strokeWidth;
  String? get description;
  double? get totalDistanceKm;
  int? get estimatedTimeMinutes;
  DateTime? get createdAt;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<RouteModel> get copyWith =>
      _$RouteModelCopyWithImpl<RouteModel>(this as RouteModel, _$identity);

  /// Serializes this RouteModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.waypoints, waypoints) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalDistanceKm, totalDistanceKm) ||
                other.totalDistanceKm == totalDistanceKm) &&
            (identical(other.estimatedTimeMinutes, estimatedTimeMinutes) ||
                other.estimatedTimeMinutes == estimatedTimeMinutes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(waypoints),
    color,
    strokeWidth,
    description,
    totalDistanceKm,
    estimatedTimeMinutes,
    createdAt,
  );

  @override
  String toString() {
    return 'RouteModel(id: $id, name: $name, waypoints: $waypoints, color: $color, strokeWidth: $strokeWidth, description: $description, totalDistanceKm: $totalDistanceKm, estimatedTimeMinutes: $estimatedTimeMinutes, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $RouteModelCopyWith<$Res> {
  factory $RouteModelCopyWith(
    RouteModel value,
    $Res Function(RouteModel) _then,
  ) = _$RouteModelCopyWithImpl;
  @useResult
  $Res call({
    String id,
    String name,
    List<RouteWaypoint> waypoints,
    int color,
    double strokeWidth,
    String? description,
    double? totalDistanceKm,
    int? estimatedTimeMinutes,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$RouteModelCopyWithImpl<$Res> implements $RouteModelCopyWith<$Res> {
  _$RouteModelCopyWithImpl(this._self, this._then);

  final RouteModel _self;
  final $Res Function(RouteModel) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? waypoints = null,
    Object? color = null,
    Object? strokeWidth = null,
    Object? description = freezed,
    Object? totalDistanceKm = freezed,
    Object? estimatedTimeMinutes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _self.copyWith(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        waypoints: null == waypoints
            ? _self.waypoints
            : waypoints // ignore: cast_nullable_to_non_nullable
                  as List<RouteWaypoint>,
        color: null == color
            ? _self.color
            : color // ignore: cast_nullable_to_non_nullable
                  as int,
        strokeWidth: null == strokeWidth
            ? _self.strokeWidth
            : strokeWidth // ignore: cast_nullable_to_non_nullable
                  as double,
        description: freezed == description
            ? _self.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalDistanceKm: freezed == totalDistanceKm
            ? _self.totalDistanceKm
            : totalDistanceKm // ignore: cast_nullable_to_non_nullable
                  as double?,
        estimatedTimeMinutes: freezed == estimatedTimeMinutes
            ? _self.estimatedTimeMinutes
            : estimatedTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _self.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RouteModel].
extension RouteModelPatterns on RouteModel {
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
    TResult Function(_RouteModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteModel() when $default != null:
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
    TResult Function(_RouteModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteModel():
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
    TResult? Function(_RouteModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteModel() when $default != null:
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
      String name,
      List<RouteWaypoint> waypoints,
      int color,
      double strokeWidth,
      String? description,
      double? totalDistanceKm,
      int? estimatedTimeMinutes,
      DateTime? createdAt,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteModel() when $default != null:
        return $default(
          _that.id,
          _that.name,
          _that.waypoints,
          _that.color,
          _that.strokeWidth,
          _that.description,
          _that.totalDistanceKm,
          _that.estimatedTimeMinutes,
          _that.createdAt,
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
      String name,
      List<RouteWaypoint> waypoints,
      int color,
      double strokeWidth,
      String? description,
      double? totalDistanceKm,
      int? estimatedTimeMinutes,
      DateTime? createdAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteModel():
        return $default(
          _that.id,
          _that.name,
          _that.waypoints,
          _that.color,
          _that.strokeWidth,
          _that.description,
          _that.totalDistanceKm,
          _that.estimatedTimeMinutes,
          _that.createdAt,
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
      String id,
      String name,
      List<RouteWaypoint> waypoints,
      int color,
      double strokeWidth,
      String? description,
      double? totalDistanceKm,
      int? estimatedTimeMinutes,
      DateTime? createdAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RouteModel() when $default != null:
        return $default(
          _that.id,
          _that.name,
          _that.waypoints,
          _that.color,
          _that.strokeWidth,
          _that.description,
          _that.totalDistanceKm,
          _that.estimatedTimeMinutes,
          _that.createdAt,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RouteModel extends RouteModel {
  const _RouteModel({
    required this.id,
    required this.name,
    required final List<RouteWaypoint> waypoints,
    this.color = 0xFF2196F3,
    this.strokeWidth = 4.0,
    this.description,
    this.totalDistanceKm,
    this.estimatedTimeMinutes,
    this.createdAt,
  }) : _waypoints = waypoints,
       super._();
  factory _RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<RouteWaypoint> _waypoints;
  @override
  List<RouteWaypoint> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  @JsonKey()
  final int color;
  // Default blue color
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  final String? description;
  @override
  final double? totalDistanceKm;
  @override
  final int? estimatedTimeMinutes;
  @override
  final DateTime? createdAt;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteModelCopyWith<_RouteModel> get copyWith =>
      __$RouteModelCopyWithImpl<_RouteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RouteModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._waypoints,
              _waypoints,
            ) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalDistanceKm, totalDistanceKm) ||
                other.totalDistanceKm == totalDistanceKm) &&
            (identical(other.estimatedTimeMinutes, estimatedTimeMinutes) ||
                other.estimatedTimeMinutes == estimatedTimeMinutes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_waypoints),
    color,
    strokeWidth,
    description,
    totalDistanceKm,
    estimatedTimeMinutes,
    createdAt,
  );

  @override
  String toString() {
    return 'RouteModel(id: $id, name: $name, waypoints: $waypoints, color: $color, strokeWidth: $strokeWidth, description: $description, totalDistanceKm: $totalDistanceKm, estimatedTimeMinutes: $estimatedTimeMinutes, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$RouteModelCopyWith<$Res>
    implements $RouteModelCopyWith<$Res> {
  factory _$RouteModelCopyWith(
    _RouteModel value,
    $Res Function(_RouteModel) _then,
  ) = __$RouteModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<RouteWaypoint> waypoints,
    int color,
    double strokeWidth,
    String? description,
    double? totalDistanceKm,
    int? estimatedTimeMinutes,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$RouteModelCopyWithImpl<$Res> implements _$RouteModelCopyWith<$Res> {
  __$RouteModelCopyWithImpl(this._self, this._then);

  final _RouteModel _self;
  final $Res Function(_RouteModel) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? waypoints = null,
    Object? color = null,
    Object? strokeWidth = null,
    Object? description = freezed,
    Object? totalDistanceKm = freezed,
    Object? estimatedTimeMinutes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _RouteModel(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        waypoints: null == waypoints
            ? _self._waypoints
            : waypoints // ignore: cast_nullable_to_non_nullable
                  as List<RouteWaypoint>,
        color: null == color
            ? _self.color
            : color // ignore: cast_nullable_to_non_nullable
                  as int,
        strokeWidth: null == strokeWidth
            ? _self.strokeWidth
            : strokeWidth // ignore: cast_nullable_to_non_nullable
                  as double,
        description: freezed == description
            ? _self.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalDistanceKm: freezed == totalDistanceKm
            ? _self.totalDistanceKm
            : totalDistanceKm // ignore: cast_nullable_to_non_nullable
                  as double?,
        estimatedTimeMinutes: freezed == estimatedTimeMinutes
            ? _self.estimatedTimeMinutes
            : estimatedTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _self.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
mixin _$VehicleModel {
  String get id;
  String get name;
  double get latitude;
  double get longitude;

  /// Heading angle in degrees (0 = North, 90 = East, 180 = South, 270 = West)
  double get heading;

  /// Speed in km/h
  double get speed;
  VehicleStatus get status;
  String? get driverName;
  String? get plateNumber;
  String? get vehicleType;
  String? get iconUrl;
  String? get currentRouteId;
  DateTime? get lastUpdated;
  Map<String, dynamic>? get metadata;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VehicleModelCopyWith<VehicleModel> get copyWith =>
      _$VehicleModelCopyWithImpl<VehicleModel>(
        this as VehicleModel,
        _$identity,
      );

  /// Serializes this VehicleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VehicleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.heading, heading) || other.heading == heading) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.currentRouteId, currentRouteId) ||
                other.currentRouteId == currentRouteId) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    latitude,
    longitude,
    heading,
    speed,
    status,
    driverName,
    plateNumber,
    vehicleType,
    iconUrl,
    currentRouteId,
    lastUpdated,
    const DeepCollectionEquality().hash(metadata),
  );

  @override
  String toString() {
    return 'VehicleModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, heading: $heading, speed: $speed, status: $status, driverName: $driverName, plateNumber: $plateNumber, vehicleType: $vehicleType, iconUrl: $iconUrl, currentRouteId: $currentRouteId, lastUpdated: $lastUpdated, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $VehicleModelCopyWith<$Res> {
  factory $VehicleModelCopyWith(
    VehicleModel value,
    $Res Function(VehicleModel) _then,
  ) = _$VehicleModelCopyWithImpl;
  @useResult
  $Res call({
    String id,
    String name,
    double latitude,
    double longitude,
    double heading,
    double speed,
    VehicleStatus status,
    String? driverName,
    String? plateNumber,
    String? vehicleType,
    String? iconUrl,
    String? currentRouteId,
    DateTime? lastUpdated,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$VehicleModelCopyWithImpl<$Res> implements $VehicleModelCopyWith<$Res> {
  _$VehicleModelCopyWithImpl(this._self, this._then);

  final VehicleModel _self;
  final $Res Function(VehicleModel) _then;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? heading = null,
    Object? speed = null,
    Object? status = null,
    Object? driverName = freezed,
    Object? plateNumber = freezed,
    Object? vehicleType = freezed,
    Object? iconUrl = freezed,
    Object? currentRouteId = freezed,
    Object? lastUpdated = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _self.copyWith(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        heading: null == heading
            ? _self.heading
            : heading // ignore: cast_nullable_to_non_nullable
                  as double,
        speed: null == speed
            ? _self.speed
            : speed // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as VehicleStatus,
        driverName: freezed == driverName
            ? _self.driverName
            : driverName // ignore: cast_nullable_to_non_nullable
                  as String?,
        plateNumber: freezed == plateNumber
            ? _self.plateNumber
            : plateNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        vehicleType: freezed == vehicleType
            ? _self.vehicleType
            : vehicleType // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconUrl: freezed == iconUrl
            ? _self.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentRouteId: freezed == currentRouteId
            ? _self.currentRouteId
            : currentRouteId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUpdated: freezed == lastUpdated
            ? _self.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: freezed == metadata
            ? _self.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [VehicleModel].
extension VehicleModelPatterns on VehicleModel {
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
    TResult Function(_VehicleModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
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
    TResult Function(_VehicleModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel():
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
    TResult? Function(_VehicleModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
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
      String name,
      double latitude,
      double longitude,
      double heading,
      double speed,
      VehicleStatus status,
      String? driverName,
      String? plateNumber,
      String? vehicleType,
      String? iconUrl,
      String? currentRouteId,
      DateTime? lastUpdated,
      Map<String, dynamic>? metadata,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
        return $default(
          _that.id,
          _that.name,
          _that.latitude,
          _that.longitude,
          _that.heading,
          _that.speed,
          _that.status,
          _that.driverName,
          _that.plateNumber,
          _that.vehicleType,
          _that.iconUrl,
          _that.currentRouteId,
          _that.lastUpdated,
          _that.metadata,
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
      String name,
      double latitude,
      double longitude,
      double heading,
      double speed,
      VehicleStatus status,
      String? driverName,
      String? plateNumber,
      String? vehicleType,
      String? iconUrl,
      String? currentRouteId,
      DateTime? lastUpdated,
      Map<String, dynamic>? metadata,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel():
        return $default(
          _that.id,
          _that.name,
          _that.latitude,
          _that.longitude,
          _that.heading,
          _that.speed,
          _that.status,
          _that.driverName,
          _that.plateNumber,
          _that.vehicleType,
          _that.iconUrl,
          _that.currentRouteId,
          _that.lastUpdated,
          _that.metadata,
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
      String id,
      String name,
      double latitude,
      double longitude,
      double heading,
      double speed,
      VehicleStatus status,
      String? driverName,
      String? plateNumber,
      String? vehicleType,
      String? iconUrl,
      String? currentRouteId,
      DateTime? lastUpdated,
      Map<String, dynamic>? metadata,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VehicleModel() when $default != null:
        return $default(
          _that.id,
          _that.name,
          _that.latitude,
          _that.longitude,
          _that.heading,
          _that.speed,
          _that.status,
          _that.driverName,
          _that.plateNumber,
          _that.vehicleType,
          _that.iconUrl,
          _that.currentRouteId,
          _that.lastUpdated,
          _that.metadata,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VehicleModel extends VehicleModel {
  const _VehicleModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.heading = 0.0,
    this.speed = 0.0,
    this.status = VehicleStatus.available,
    this.driverName,
    this.plateNumber,
    this.vehicleType,
    this.iconUrl,
    this.currentRouteId,
    this.lastUpdated,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata,
       super._();
  factory _VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;

  /// Heading angle in degrees (0 = North, 90 = East, 180 = South, 270 = West)
  @override
  @JsonKey()
  final double heading;

  /// Speed in km/h
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final VehicleStatus status;
  @override
  final String? driverName;
  @override
  final String? plateNumber;
  @override
  final String? vehicleType;
  @override
  final String? iconUrl;
  @override
  final String? currentRouteId;
  @override
  final DateTime? lastUpdated;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VehicleModelCopyWith<_VehicleModel> get copyWith =>
      __$VehicleModelCopyWithImpl<_VehicleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VehicleModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VehicleModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.heading, heading) || other.heading == heading) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.currentRouteId, currentRouteId) ||
                other.currentRouteId == currentRouteId) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    latitude,
    longitude,
    heading,
    speed,
    status,
    driverName,
    plateNumber,
    vehicleType,
    iconUrl,
    currentRouteId,
    lastUpdated,
    const DeepCollectionEquality().hash(_metadata),
  );

  @override
  String toString() {
    return 'VehicleModel(id: $id, name: $name, latitude: $latitude, longitude: $longitude, heading: $heading, speed: $speed, status: $status, driverName: $driverName, plateNumber: $plateNumber, vehicleType: $vehicleType, iconUrl: $iconUrl, currentRouteId: $currentRouteId, lastUpdated: $lastUpdated, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$VehicleModelCopyWith<$Res>
    implements $VehicleModelCopyWith<$Res> {
  factory _$VehicleModelCopyWith(
    _VehicleModel value,
    $Res Function(_VehicleModel) _then,
  ) = __$VehicleModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double latitude,
    double longitude,
    double heading,
    double speed,
    VehicleStatus status,
    String? driverName,
    String? plateNumber,
    String? vehicleType,
    String? iconUrl,
    String? currentRouteId,
    DateTime? lastUpdated,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$VehicleModelCopyWithImpl<$Res>
    implements _$VehicleModelCopyWith<$Res> {
  __$VehicleModelCopyWithImpl(this._self, this._then);

  final _VehicleModel _self;
  final $Res Function(_VehicleModel) _then;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? heading = null,
    Object? speed = null,
    Object? status = null,
    Object? driverName = freezed,
    Object? plateNumber = freezed,
    Object? vehicleType = freezed,
    Object? iconUrl = freezed,
    Object? currentRouteId = freezed,
    Object? lastUpdated = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _VehicleModel(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        heading: null == heading
            ? _self.heading
            : heading // ignore: cast_nullable_to_non_nullable
                  as double,
        speed: null == speed
            ? _self.speed
            : speed // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as VehicleStatus,
        driverName: freezed == driverName
            ? _self.driverName
            : driverName // ignore: cast_nullable_to_non_nullable
                  as String?,
        plateNumber: freezed == plateNumber
            ? _self.plateNumber
            : plateNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        vehicleType: freezed == vehicleType
            ? _self.vehicleType
            : vehicleType // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconUrl: freezed == iconUrl
            ? _self.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentRouteId: freezed == currentRouteId
            ? _self.currentRouteId
            : currentRouteId // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUpdated: freezed == lastUpdated
            ? _self.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        metadata: freezed == metadata
            ? _self._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
mixin _$UserLocationModel {
  double get latitude;
  double get longitude;
  double get heading;
  double get speed;
  double get accuracy;
  double get altitude;
  DateTime? get timestamp;

  /// Create a copy of UserLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserLocationModelCopyWith<UserLocationModel> get copyWith =>
      _$UserLocationModelCopyWithImpl<UserLocationModel>(
        this as UserLocationModel,
        _$identity,
      );

  /// Serializes this UserLocationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserLocationModel &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.heading, heading) || other.heading == heading) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    heading,
    speed,
    accuracy,
    altitude,
    timestamp,
  );

  @override
  String toString() {
    return 'UserLocationModel(latitude: $latitude, longitude: $longitude, heading: $heading, speed: $speed, accuracy: $accuracy, altitude: $altitude, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $UserLocationModelCopyWith<$Res> {
  factory $UserLocationModelCopyWith(
    UserLocationModel value,
    $Res Function(UserLocationModel) _then,
  ) = _$UserLocationModelCopyWithImpl;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double heading,
    double speed,
    double accuracy,
    double altitude,
    DateTime? timestamp,
  });
}

/// @nodoc
class _$UserLocationModelCopyWithImpl<$Res>
    implements $UserLocationModelCopyWith<$Res> {
  _$UserLocationModelCopyWithImpl(this._self, this._then);

  final UserLocationModel _self;
  final $Res Function(UserLocationModel) _then;

  /// Create a copy of UserLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? heading = null,
    Object? speed = null,
    Object? accuracy = null,
    Object? altitude = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _self.copyWith(
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        heading: null == heading
            ? _self.heading
            : heading // ignore: cast_nullable_to_non_nullable
                  as double,
        speed: null == speed
            ? _self.speed
            : speed // ignore: cast_nullable_to_non_nullable
                  as double,
        accuracy: null == accuracy
            ? _self.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        altitude: null == altitude
            ? _self.altitude
            : altitude // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: freezed == timestamp
            ? _self.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [UserLocationModel].
extension UserLocationModelPatterns on UserLocationModel {
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
    TResult Function(_UserLocationModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserLocationModel() when $default != null:
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
    TResult Function(_UserLocationModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLocationModel():
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
    TResult? Function(_UserLocationModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLocationModel() when $default != null:
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
      double latitude,
      double longitude,
      double heading,
      double speed,
      double accuracy,
      double altitude,
      DateTime? timestamp,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserLocationModel() when $default != null:
        return $default(
          _that.latitude,
          _that.longitude,
          _that.heading,
          _that.speed,
          _that.accuracy,
          _that.altitude,
          _that.timestamp,
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
      double latitude,
      double longitude,
      double heading,
      double speed,
      double accuracy,
      double altitude,
      DateTime? timestamp,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLocationModel():
        return $default(
          _that.latitude,
          _that.longitude,
          _that.heading,
          _that.speed,
          _that.accuracy,
          _that.altitude,
          _that.timestamp,
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
      double latitude,
      double longitude,
      double heading,
      double speed,
      double accuracy,
      double altitude,
      DateTime? timestamp,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserLocationModel() when $default != null:
        return $default(
          _that.latitude,
          _that.longitude,
          _that.heading,
          _that.speed,
          _that.accuracy,
          _that.altitude,
          _that.timestamp,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserLocationModel extends UserLocationModel {
  const _UserLocationModel({
    required this.latitude,
    required this.longitude,
    this.heading = 0.0,
    this.speed = 0.0,
    this.accuracy = 0.0,
    this.altitude = 0.0,
    this.timestamp,
  }) : super._();
  factory _UserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocationModelFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final double heading;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final double accuracy;
  @override
  @JsonKey()
  final double altitude;
  @override
  final DateTime? timestamp;

  /// Create a copy of UserLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserLocationModelCopyWith<_UserLocationModel> get copyWith =>
      __$UserLocationModelCopyWithImpl<_UserLocationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserLocationModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserLocationModel &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.heading, heading) || other.heading == heading) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    heading,
    speed,
    accuracy,
    altitude,
    timestamp,
  );

  @override
  String toString() {
    return 'UserLocationModel(latitude: $latitude, longitude: $longitude, heading: $heading, speed: $speed, accuracy: $accuracy, altitude: $altitude, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$UserLocationModelCopyWith<$Res>
    implements $UserLocationModelCopyWith<$Res> {
  factory _$UserLocationModelCopyWith(
    _UserLocationModel value,
    $Res Function(_UserLocationModel) _then,
  ) = __$UserLocationModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double heading,
    double speed,
    double accuracy,
    double altitude,
    DateTime? timestamp,
  });
}

/// @nodoc
class __$UserLocationModelCopyWithImpl<$Res>
    implements _$UserLocationModelCopyWith<$Res> {
  __$UserLocationModelCopyWithImpl(this._self, this._then);

  final _UserLocationModel _self;
  final $Res Function(_UserLocationModel) _then;

  /// Create a copy of UserLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? heading = null,
    Object? speed = null,
    Object? accuracy = null,
    Object? altitude = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _UserLocationModel(
        latitude: null == latitude
            ? _self.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _self.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        heading: null == heading
            ? _self.heading
            : heading // ignore: cast_nullable_to_non_nullable
                  as double,
        speed: null == speed
            ? _self.speed
            : speed // ignore: cast_nullable_to_non_nullable
                  as double,
        accuracy: null == accuracy
            ? _self.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        altitude: null == altitude
            ? _self.altitude
            : altitude // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: freezed == timestamp
            ? _self.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}
