// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemListState {
  List<ItemModel> get items;
  bool get isLoading;
  bool get isLoadingMore;
  String? get error;
  int get currentPage;
  bool get hasMore;
  String? get searchQuery;

  /// Create a copy of ItemListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ItemListStateCopyWith<ItemListState> get copyWith =>
      _$ItemListStateCopyWithImpl<ItemListState>(
        this as ItemListState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ItemListState &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(items),
    isLoading,
    isLoadingMore,
    error,
    currentPage,
    hasMore,
    searchQuery,
  );

  @override
  String toString() {
    return 'ItemListState(items: $items, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error, currentPage: $currentPage, hasMore: $hasMore, searchQuery: $searchQuery)';
  }
}

/// @nodoc
abstract mixin class $ItemListStateCopyWith<$Res> {
  factory $ItemListStateCopyWith(
    ItemListState value,
    $Res Function(ItemListState) _then,
  ) = _$ItemListStateCopyWithImpl;
  @useResult
  $Res call({
    List<ItemModel> items,
    bool isLoading,
    bool isLoadingMore,
    String? error,
    int currentPage,
    bool hasMore,
    String? searchQuery,
  });
}

/// @nodoc
class _$ItemListStateCopyWithImpl<$Res>
    implements $ItemListStateCopyWith<$Res> {
  _$ItemListStateCopyWithImpl(this._self, this._then);

  final ItemListState _self;
  final $Res Function(ItemListState) _then;

  /// Create a copy of ItemListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _self.copyWith(
        items: null == items
            ? _self.items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ItemModel>,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _self.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPage: null == currentPage
            ? _self.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _self.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: freezed == searchQuery
            ? _self.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [ItemListState].
extension ItemListStatePatterns on ItemListState {
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
    TResult Function(_ItemListState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemListState() when $default != null:
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
    TResult Function(_ItemListState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemListState():
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
    TResult? Function(_ItemListState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemListState() when $default != null:
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
      List<ItemModel> items,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      int currentPage,
      bool hasMore,
      String? searchQuery,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemListState() when $default != null:
        return $default(
          _that.items,
          _that.isLoading,
          _that.isLoadingMore,
          _that.error,
          _that.currentPage,
          _that.hasMore,
          _that.searchQuery,
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
      List<ItemModel> items,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      int currentPage,
      bool hasMore,
      String? searchQuery,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemListState():
        return $default(
          _that.items,
          _that.isLoading,
          _that.isLoadingMore,
          _that.error,
          _that.currentPage,
          _that.hasMore,
          _that.searchQuery,
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
      List<ItemModel> items,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      int currentPage,
      bool hasMore,
      String? searchQuery,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemListState() when $default != null:
        return $default(
          _that.items,
          _that.isLoading,
          _that.isLoadingMore,
          _that.error,
          _that.currentPage,
          _that.hasMore,
          _that.searchQuery,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ItemListState extends ItemListState {
  const _ItemListState({
    final List<ItemModel> items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = false,
    this.searchQuery,
  }) : _items = items,
       super._();

  final List<ItemModel> _items;
  @override
  @JsonKey()
  List<ItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? error;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? searchQuery;

  /// Create a copy of ItemListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ItemListStateCopyWith<_ItemListState> get copyWith =>
      __$ItemListStateCopyWithImpl<_ItemListState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ItemListState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    isLoading,
    isLoadingMore,
    error,
    currentPage,
    hasMore,
    searchQuery,
  );

  @override
  String toString() {
    return 'ItemListState(items: $items, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error, currentPage: $currentPage, hasMore: $hasMore, searchQuery: $searchQuery)';
  }
}

/// @nodoc
abstract mixin class _$ItemListStateCopyWith<$Res>
    implements $ItemListStateCopyWith<$Res> {
  factory _$ItemListStateCopyWith(
    _ItemListState value,
    $Res Function(_ItemListState) _then,
  ) = __$ItemListStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<ItemModel> items,
    bool isLoading,
    bool isLoadingMore,
    String? error,
    int currentPage,
    bool hasMore,
    String? searchQuery,
  });
}

/// @nodoc
class __$ItemListStateCopyWithImpl<$Res>
    implements _$ItemListStateCopyWith<$Res> {
  __$ItemListStateCopyWithImpl(this._self, this._then);

  final _ItemListState _self;
  final $Res Function(_ItemListState) _then;

  /// Create a copy of ItemListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? searchQuery = freezed,
  }) {
    return _then(
      _ItemListState(
        items: null == items
            ? _self._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<ItemModel>,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _self.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentPage: null == currentPage
            ? _self.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _self.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: freezed == searchQuery
            ? _self.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
mixin _$ItemDetailState {
  ItemModel? get item;
  bool get isLoading;
  bool get isSaving;
  bool get isDeleting;
  String? get error;
  String? get successMessage;

  /// Create a copy of ItemDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ItemDetailStateCopyWith<ItemDetailState> get copyWith =>
      _$ItemDetailStateCopyWithImpl<ItemDetailState>(
        this as ItemDetailState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ItemDetailState &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    item,
    isLoading,
    isSaving,
    isDeleting,
    error,
    successMessage,
  );

  @override
  String toString() {
    return 'ItemDetailState(item: $item, isLoading: $isLoading, isSaving: $isSaving, isDeleting: $isDeleting, error: $error, successMessage: $successMessage)';
  }
}

/// @nodoc
abstract mixin class $ItemDetailStateCopyWith<$Res> {
  factory $ItemDetailStateCopyWith(
    ItemDetailState value,
    $Res Function(ItemDetailState) _then,
  ) = _$ItemDetailStateCopyWithImpl;
  @useResult
  $Res call({
    ItemModel? item,
    bool isLoading,
    bool isSaving,
    bool isDeleting,
    String? error,
    String? successMessage,
  });

  $ItemModelCopyWith<$Res>? get item;
}

/// @nodoc
class _$ItemDetailStateCopyWithImpl<$Res>
    implements $ItemDetailStateCopyWith<$Res> {
  _$ItemDetailStateCopyWithImpl(this._self, this._then);

  final ItemDetailState _self;
  final $Res Function(ItemDetailState) _then;

  /// Create a copy of ItemDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = freezed,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isDeleting = null,
    Object? error = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _self.copyWith(
        item: freezed == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as ItemModel?,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _self.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDeleting: null == isDeleting
            ? _self.isDeleting
            : isDeleting // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _self.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of ItemDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $ItemModelCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ItemDetailState].
extension ItemDetailStatePatterns on ItemDetailState {
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
    TResult Function(_ItemDetailState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemDetailState() when $default != null:
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
    TResult Function(_ItemDetailState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemDetailState():
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
    TResult? Function(_ItemDetailState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemDetailState() when $default != null:
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
      ItemModel? item,
      bool isLoading,
      bool isSaving,
      bool isDeleting,
      String? error,
      String? successMessage,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ItemDetailState() when $default != null:
        return $default(
          _that.item,
          _that.isLoading,
          _that.isSaving,
          _that.isDeleting,
          _that.error,
          _that.successMessage,
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
      ItemModel? item,
      bool isLoading,
      bool isSaving,
      bool isDeleting,
      String? error,
      String? successMessage,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemDetailState():
        return $default(
          _that.item,
          _that.isLoading,
          _that.isSaving,
          _that.isDeleting,
          _that.error,
          _that.successMessage,
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
      ItemModel? item,
      bool isLoading,
      bool isSaving,
      bool isDeleting,
      String? error,
      String? successMessage,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ItemDetailState() when $default != null:
        return $default(
          _that.item,
          _that.isLoading,
          _that.isSaving,
          _that.isDeleting,
          _that.error,
          _that.successMessage,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ItemDetailState extends ItemDetailState {
  const _ItemDetailState({
    this.item,
    this.isLoading = false,
    this.isSaving = false,
    this.isDeleting = false,
    this.error,
    this.successMessage,
  }) : super._();

  @override
  final ItemModel? item;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isDeleting;
  @override
  final String? error;
  @override
  final String? successMessage;

  /// Create a copy of ItemDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ItemDetailStateCopyWith<_ItemDetailState> get copyWith =>
      __$ItemDetailStateCopyWithImpl<_ItemDetailState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ItemDetailState &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    item,
    isLoading,
    isSaving,
    isDeleting,
    error,
    successMessage,
  );

  @override
  String toString() {
    return 'ItemDetailState(item: $item, isLoading: $isLoading, isSaving: $isSaving, isDeleting: $isDeleting, error: $error, successMessage: $successMessage)';
  }
}

/// @nodoc
abstract mixin class _$ItemDetailStateCopyWith<$Res>
    implements $ItemDetailStateCopyWith<$Res> {
  factory _$ItemDetailStateCopyWith(
    _ItemDetailState value,
    $Res Function(_ItemDetailState) _then,
  ) = __$ItemDetailStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    ItemModel? item,
    bool isLoading,
    bool isSaving,
    bool isDeleting,
    String? error,
    String? successMessage,
  });

  @override
  $ItemModelCopyWith<$Res>? get item;
}

/// @nodoc
class __$ItemDetailStateCopyWithImpl<$Res>
    implements _$ItemDetailStateCopyWith<$Res> {
  __$ItemDetailStateCopyWithImpl(this._self, this._then);

  final _ItemDetailState _self;
  final $Res Function(_ItemDetailState) _then;

  /// Create a copy of ItemDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? item = freezed,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isDeleting = null,
    Object? error = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(
      _ItemDetailState(
        item: freezed == item
            ? _self.item
            : item // ignore: cast_nullable_to_non_nullable
                  as ItemModel?,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _self.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDeleting: null == isDeleting
            ? _self.isDeleting
            : isDeleting // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _self.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        successMessage: freezed == successMessage
            ? _self.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }

  /// Create a copy of ItemDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ItemModelCopyWith<$Res>? get item {
    if (_self.item == null) {
      return null;
    }

    return $ItemModelCopyWith<$Res>(_self.item!, (value) {
      return _then(_self.copyWith(item: value));
    });
  }
}
