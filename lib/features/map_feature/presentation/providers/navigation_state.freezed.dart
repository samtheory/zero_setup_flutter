// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NavigationState {
  /// Current navigation data (route, steps, etc.)
  NavigationData? get navigationData;

  /// Current navigation status
  NavigationStatus get status;

  /// Origin point for navigation
  LatLng? get origin;

  /// Destination point for navigation
  LatLng? get destination;

  /// Origin name/address
  String? get originName;

  /// Destination name/address
  String? get destinationName;

  /// Whether navigation panel is expanded
  bool get isPanelExpanded;

  /// Whether navigation mode is active
  bool get isNavigating;

  /// Current step being highlighted in the list
  int get highlightedStepIndex;

  /// Error message if any
  String? get errorMessage;

  /// Last calculated route timestamp
  DateTime? get lastUpdated;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NavigationStateCopyWith<NavigationState> get copyWith =>
      _$NavigationStateCopyWithImpl<NavigationState>(
        this as NavigationState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NavigationState &&
            (identical(other.navigationData, navigationData) ||
                other.navigationData == navigationData) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.originName, originName) ||
                other.originName == originName) &&
            (identical(other.destinationName, destinationName) ||
                other.destinationName == destinationName) &&
            (identical(other.isPanelExpanded, isPanelExpanded) ||
                other.isPanelExpanded == isPanelExpanded) &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating) &&
            (identical(other.highlightedStepIndex, highlightedStepIndex) ||
                other.highlightedStepIndex == highlightedStepIndex) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    navigationData,
    status,
    origin,
    destination,
    originName,
    destinationName,
    isPanelExpanded,
    isNavigating,
    highlightedStepIndex,
    errorMessage,
    lastUpdated,
  );

  @override
  String toString() {
    return 'NavigationState(navigationData: $navigationData, status: $status, origin: $origin, destination: $destination, originName: $originName, destinationName: $destinationName, isPanelExpanded: $isPanelExpanded, isNavigating: $isNavigating, highlightedStepIndex: $highlightedStepIndex, errorMessage: $errorMessage, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class $NavigationStateCopyWith<$Res> {
  factory $NavigationStateCopyWith(
    NavigationState value,
    $Res Function(NavigationState) _then,
  ) = _$NavigationStateCopyWithImpl;
  @useResult
  $Res call({
    NavigationData? navigationData,
    NavigationStatus status,
    LatLng? origin,
    LatLng? destination,
    String? originName,
    String? destinationName,
    bool isPanelExpanded,
    bool isNavigating,
    int highlightedStepIndex,
    String? errorMessage,
    DateTime? lastUpdated,
  });

  $NavigationDataCopyWith<$Res>? get navigationData;
}

/// @nodoc
class _$NavigationStateCopyWithImpl<$Res>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._self, this._then);

  final NavigationState _self;
  final $Res Function(NavigationState) _then;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? navigationData = freezed,
    Object? status = null,
    Object? origin = freezed,
    Object? destination = freezed,
    Object? originName = freezed,
    Object? destinationName = freezed,
    Object? isPanelExpanded = null,
    Object? isNavigating = null,
    Object? highlightedStepIndex = null,
    Object? errorMessage = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _self.copyWith(
        navigationData: freezed == navigationData
            ? _self.navigationData
            : navigationData // ignore: cast_nullable_to_non_nullable
                  as NavigationData?,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as NavigationStatus,
        origin: freezed == origin
            ? _self.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        destination: freezed == destination
            ? _self.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        originName: freezed == originName
            ? _self.originName
            : originName // ignore: cast_nullable_to_non_nullable
                  as String?,
        destinationName: freezed == destinationName
            ? _self.destinationName
            : destinationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPanelExpanded: null == isPanelExpanded
            ? _self.isPanelExpanded
            : isPanelExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isNavigating: null == isNavigating
            ? _self.isNavigating
            : isNavigating // ignore: cast_nullable_to_non_nullable
                  as bool,
        highlightedStepIndex: null == highlightedStepIndex
            ? _self.highlightedStepIndex
            : highlightedStepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        errorMessage: freezed == errorMessage
            ? _self.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUpdated: freezed == lastUpdated
            ? _self.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NavigationDataCopyWith<$Res>? get navigationData {
    if (_self.navigationData == null) {
      return null;
    }

    return $NavigationDataCopyWith<$Res>(_self.navigationData!, (value) {
      return _then(_self.copyWith(navigationData: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NavigationState].
extension NavigationStatePatterns on NavigationState {
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
    TResult Function(_NavigationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NavigationState() when $default != null:
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
    TResult Function(_NavigationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationState():
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
    TResult? Function(_NavigationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationState() when $default != null:
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
      NavigationData? navigationData,
      NavigationStatus status,
      LatLng? origin,
      LatLng? destination,
      String? originName,
      String? destinationName,
      bool isPanelExpanded,
      bool isNavigating,
      int highlightedStepIndex,
      String? errorMessage,
      DateTime? lastUpdated,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NavigationState() when $default != null:
        return $default(
          _that.navigationData,
          _that.status,
          _that.origin,
          _that.destination,
          _that.originName,
          _that.destinationName,
          _that.isPanelExpanded,
          _that.isNavigating,
          _that.highlightedStepIndex,
          _that.errorMessage,
          _that.lastUpdated,
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
      NavigationData? navigationData,
      NavigationStatus status,
      LatLng? origin,
      LatLng? destination,
      String? originName,
      String? destinationName,
      bool isPanelExpanded,
      bool isNavigating,
      int highlightedStepIndex,
      String? errorMessage,
      DateTime? lastUpdated,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationState():
        return $default(
          _that.navigationData,
          _that.status,
          _that.origin,
          _that.destination,
          _that.originName,
          _that.destinationName,
          _that.isPanelExpanded,
          _that.isNavigating,
          _that.highlightedStepIndex,
          _that.errorMessage,
          _that.lastUpdated,
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
      NavigationData? navigationData,
      NavigationStatus status,
      LatLng? origin,
      LatLng? destination,
      String? originName,
      String? destinationName,
      bool isPanelExpanded,
      bool isNavigating,
      int highlightedStepIndex,
      String? errorMessage,
      DateTime? lastUpdated,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NavigationState() when $default != null:
        return $default(
          _that.navigationData,
          _that.status,
          _that.origin,
          _that.destination,
          _that.originName,
          _that.destinationName,
          _that.isPanelExpanded,
          _that.isNavigating,
          _that.highlightedStepIndex,
          _that.errorMessage,
          _that.lastUpdated,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NavigationState extends NavigationState {
  const _NavigationState({
    this.navigationData,
    this.status = NavigationStatus.idle,
    this.origin,
    this.destination,
    this.originName,
    this.destinationName,
    this.isPanelExpanded = false,
    this.isNavigating = false,
    this.highlightedStepIndex = 0,
    this.errorMessage,
    this.lastUpdated,
  }) : super._();

  /// Current navigation data (route, steps, etc.)
  @override
  final NavigationData? navigationData;

  /// Current navigation status
  @override
  @JsonKey()
  final NavigationStatus status;

  /// Origin point for navigation
  @override
  final LatLng? origin;

  /// Destination point for navigation
  @override
  final LatLng? destination;

  /// Origin name/address
  @override
  final String? originName;

  /// Destination name/address
  @override
  final String? destinationName;

  /// Whether navigation panel is expanded
  @override
  @JsonKey()
  final bool isPanelExpanded;

  /// Whether navigation mode is active
  @override
  @JsonKey()
  final bool isNavigating;

  /// Current step being highlighted in the list
  @override
  @JsonKey()
  final int highlightedStepIndex;

  /// Error message if any
  @override
  final String? errorMessage;

  /// Last calculated route timestamp
  @override
  final DateTime? lastUpdated;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NavigationStateCopyWith<_NavigationState> get copyWith =>
      __$NavigationStateCopyWithImpl<_NavigationState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigationState &&
            (identical(other.navigationData, navigationData) ||
                other.navigationData == navigationData) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.originName, originName) ||
                other.originName == originName) &&
            (identical(other.destinationName, destinationName) ||
                other.destinationName == destinationName) &&
            (identical(other.isPanelExpanded, isPanelExpanded) ||
                other.isPanelExpanded == isPanelExpanded) &&
            (identical(other.isNavigating, isNavigating) ||
                other.isNavigating == isNavigating) &&
            (identical(other.highlightedStepIndex, highlightedStepIndex) ||
                other.highlightedStepIndex == highlightedStepIndex) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    navigationData,
    status,
    origin,
    destination,
    originName,
    destinationName,
    isPanelExpanded,
    isNavigating,
    highlightedStepIndex,
    errorMessage,
    lastUpdated,
  );

  @override
  String toString() {
    return 'NavigationState(navigationData: $navigationData, status: $status, origin: $origin, destination: $destination, originName: $originName, destinationName: $destinationName, isPanelExpanded: $isPanelExpanded, isNavigating: $isNavigating, highlightedStepIndex: $highlightedStepIndex, errorMessage: $errorMessage, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class _$NavigationStateCopyWith<$Res>
    implements $NavigationStateCopyWith<$Res> {
  factory _$NavigationStateCopyWith(
    _NavigationState value,
    $Res Function(_NavigationState) _then,
  ) = __$NavigationStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    NavigationData? navigationData,
    NavigationStatus status,
    LatLng? origin,
    LatLng? destination,
    String? originName,
    String? destinationName,
    bool isPanelExpanded,
    bool isNavigating,
    int highlightedStepIndex,
    String? errorMessage,
    DateTime? lastUpdated,
  });

  @override
  $NavigationDataCopyWith<$Res>? get navigationData;
}

/// @nodoc
class __$NavigationStateCopyWithImpl<$Res>
    implements _$NavigationStateCopyWith<$Res> {
  __$NavigationStateCopyWithImpl(this._self, this._then);

  final _NavigationState _self;
  final $Res Function(_NavigationState) _then;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? navigationData = freezed,
    Object? status = null,
    Object? origin = freezed,
    Object? destination = freezed,
    Object? originName = freezed,
    Object? destinationName = freezed,
    Object? isPanelExpanded = null,
    Object? isNavigating = null,
    Object? highlightedStepIndex = null,
    Object? errorMessage = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _NavigationState(
        navigationData: freezed == navigationData
            ? _self.navigationData
            : navigationData // ignore: cast_nullable_to_non_nullable
                  as NavigationData?,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as NavigationStatus,
        origin: freezed == origin
            ? _self.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        destination: freezed == destination
            ? _self.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as LatLng?,
        originName: freezed == originName
            ? _self.originName
            : originName // ignore: cast_nullable_to_non_nullable
                  as String?,
        destinationName: freezed == destinationName
            ? _self.destinationName
            : destinationName // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPanelExpanded: null == isPanelExpanded
            ? _self.isPanelExpanded
            : isPanelExpanded // ignore: cast_nullable_to_non_nullable
                  as bool,
        isNavigating: null == isNavigating
            ? _self.isNavigating
            : isNavigating // ignore: cast_nullable_to_non_nullable
                  as bool,
        highlightedStepIndex: null == highlightedStepIndex
            ? _self.highlightedStepIndex
            : highlightedStepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        errorMessage: freezed == errorMessage
            ? _self.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastUpdated: freezed == lastUpdated
            ? _self.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NavigationDataCopyWith<$Res>? get navigationData {
    if (_self.navigationData == null) {
      return null;
    }

    return $NavigationDataCopyWith<$Res>(_self.navigationData!, (value) {
      return _then(_self.copyWith(navigationData: value));
    });
  }
}
