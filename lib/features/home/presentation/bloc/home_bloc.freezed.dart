// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllLocations,
    required TResult Function(String title) fetchSearchLocations,
    required TResult Function() getCurrentLocation,
    required TResult Function() getVehicleList,
    required TResult Function(VehicleModel vehicleModel) createVehicle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllLocations,
    TResult? Function(String title)? fetchSearchLocations,
    TResult? Function()? getCurrentLocation,
    TResult? Function()? getVehicleList,
    TResult? Function(VehicleModel vehicleModel)? createVehicle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllLocations,
    TResult Function(String title)? fetchSearchLocations,
    TResult Function()? getCurrentLocation,
    TResult Function()? getVehicleList,
    TResult Function(VehicleModel vehicleModel)? createVehicle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_fetchAllLocations value) fetchAllLocations,
    required TResult Function(_fetchSearchAllLocations value)
        fetchSearchLocations,
    required TResult Function(_getCurrentLocation value) getCurrentLocation,
    required TResult Function(_getVehicleList value) getVehicleList,
    required TResult Function(_createVehicle value) createVehicle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_fetchAllLocations value)? fetchAllLocations,
    TResult? Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult? Function(_getCurrentLocation value)? getCurrentLocation,
    TResult? Function(_getVehicleList value)? getVehicleList,
    TResult? Function(_createVehicle value)? createVehicle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_fetchAllLocations value)? fetchAllLocations,
    TResult Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult Function(_getCurrentLocation value)? getCurrentLocation,
    TResult Function(_getVehicleList value)? getVehicleList,
    TResult Function(_createVehicle value)? createVehicle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<$Res> {
  factory $HomeEventCopyWith(HomeEvent value, $Res Function(HomeEvent) then) =
      _$HomeEventCopyWithImpl<$Res, HomeEvent>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<$Res, $Val extends HomeEvent>
    implements $HomeEventCopyWith<$Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$fetchAllLocationsImplCopyWith<$Res> {
  factory _$$fetchAllLocationsImplCopyWith(_$fetchAllLocationsImpl value,
          $Res Function(_$fetchAllLocationsImpl) then) =
      __$$fetchAllLocationsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$fetchAllLocationsImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$fetchAllLocationsImpl>
    implements _$$fetchAllLocationsImplCopyWith<$Res> {
  __$$fetchAllLocationsImplCopyWithImpl(_$fetchAllLocationsImpl _value,
      $Res Function(_$fetchAllLocationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$fetchAllLocationsImpl implements _fetchAllLocations {
  const _$fetchAllLocationsImpl();

  @override
  String toString() {
    return 'HomeEvent.fetchAllLocations()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$fetchAllLocationsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllLocations,
    required TResult Function(String title) fetchSearchLocations,
    required TResult Function() getCurrentLocation,
    required TResult Function() getVehicleList,
    required TResult Function(VehicleModel vehicleModel) createVehicle,
  }) {
    return fetchAllLocations();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllLocations,
    TResult? Function(String title)? fetchSearchLocations,
    TResult? Function()? getCurrentLocation,
    TResult? Function()? getVehicleList,
    TResult? Function(VehicleModel vehicleModel)? createVehicle,
  }) {
    return fetchAllLocations?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllLocations,
    TResult Function(String title)? fetchSearchLocations,
    TResult Function()? getCurrentLocation,
    TResult Function()? getVehicleList,
    TResult Function(VehicleModel vehicleModel)? createVehicle,
    required TResult orElse(),
  }) {
    if (fetchAllLocations != null) {
      return fetchAllLocations();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_fetchAllLocations value) fetchAllLocations,
    required TResult Function(_fetchSearchAllLocations value)
        fetchSearchLocations,
    required TResult Function(_getCurrentLocation value) getCurrentLocation,
    required TResult Function(_getVehicleList value) getVehicleList,
    required TResult Function(_createVehicle value) createVehicle,
  }) {
    return fetchAllLocations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_fetchAllLocations value)? fetchAllLocations,
    TResult? Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult? Function(_getCurrentLocation value)? getCurrentLocation,
    TResult? Function(_getVehicleList value)? getVehicleList,
    TResult? Function(_createVehicle value)? createVehicle,
  }) {
    return fetchAllLocations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_fetchAllLocations value)? fetchAllLocations,
    TResult Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult Function(_getCurrentLocation value)? getCurrentLocation,
    TResult Function(_getVehicleList value)? getVehicleList,
    TResult Function(_createVehicle value)? createVehicle,
    required TResult orElse(),
  }) {
    if (fetchAllLocations != null) {
      return fetchAllLocations(this);
    }
    return orElse();
  }
}

abstract class _fetchAllLocations implements HomeEvent {
  const factory _fetchAllLocations() = _$fetchAllLocationsImpl;
}

/// @nodoc
abstract class _$$fetchSearchAllLocationsImplCopyWith<$Res> {
  factory _$$fetchSearchAllLocationsImplCopyWith(
          _$fetchSearchAllLocationsImpl value,
          $Res Function(_$fetchSearchAllLocationsImpl) then) =
      __$$fetchSearchAllLocationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$fetchSearchAllLocationsImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$fetchSearchAllLocationsImpl>
    implements _$$fetchSearchAllLocationsImplCopyWith<$Res> {
  __$$fetchSearchAllLocationsImplCopyWithImpl(
      _$fetchSearchAllLocationsImpl _value,
      $Res Function(_$fetchSearchAllLocationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$fetchSearchAllLocationsImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$fetchSearchAllLocationsImpl implements _fetchSearchAllLocations {
  const _$fetchSearchAllLocationsImpl(this.title);

  @override
  final String title;

  @override
  String toString() {
    return 'HomeEvent.fetchSearchLocations(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$fetchSearchAllLocationsImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$fetchSearchAllLocationsImplCopyWith<_$fetchSearchAllLocationsImpl>
      get copyWith => __$$fetchSearchAllLocationsImplCopyWithImpl<
          _$fetchSearchAllLocationsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllLocations,
    required TResult Function(String title) fetchSearchLocations,
    required TResult Function() getCurrentLocation,
    required TResult Function() getVehicleList,
    required TResult Function(VehicleModel vehicleModel) createVehicle,
  }) {
    return fetchSearchLocations(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllLocations,
    TResult? Function(String title)? fetchSearchLocations,
    TResult? Function()? getCurrentLocation,
    TResult? Function()? getVehicleList,
    TResult? Function(VehicleModel vehicleModel)? createVehicle,
  }) {
    return fetchSearchLocations?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllLocations,
    TResult Function(String title)? fetchSearchLocations,
    TResult Function()? getCurrentLocation,
    TResult Function()? getVehicleList,
    TResult Function(VehicleModel vehicleModel)? createVehicle,
    required TResult orElse(),
  }) {
    if (fetchSearchLocations != null) {
      return fetchSearchLocations(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_fetchAllLocations value) fetchAllLocations,
    required TResult Function(_fetchSearchAllLocations value)
        fetchSearchLocations,
    required TResult Function(_getCurrentLocation value) getCurrentLocation,
    required TResult Function(_getVehicleList value) getVehicleList,
    required TResult Function(_createVehicle value) createVehicle,
  }) {
    return fetchSearchLocations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_fetchAllLocations value)? fetchAllLocations,
    TResult? Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult? Function(_getCurrentLocation value)? getCurrentLocation,
    TResult? Function(_getVehicleList value)? getVehicleList,
    TResult? Function(_createVehicle value)? createVehicle,
  }) {
    return fetchSearchLocations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_fetchAllLocations value)? fetchAllLocations,
    TResult Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult Function(_getCurrentLocation value)? getCurrentLocation,
    TResult Function(_getVehicleList value)? getVehicleList,
    TResult Function(_createVehicle value)? createVehicle,
    required TResult orElse(),
  }) {
    if (fetchSearchLocations != null) {
      return fetchSearchLocations(this);
    }
    return orElse();
  }
}

abstract class _fetchSearchAllLocations implements HomeEvent {
  const factory _fetchSearchAllLocations(final String title) =
      _$fetchSearchAllLocationsImpl;

  String get title;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$fetchSearchAllLocationsImplCopyWith<_$fetchSearchAllLocationsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$getCurrentLocationImplCopyWith<$Res> {
  factory _$$getCurrentLocationImplCopyWith(_$getCurrentLocationImpl value,
          $Res Function(_$getCurrentLocationImpl) then) =
      __$$getCurrentLocationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$getCurrentLocationImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$getCurrentLocationImpl>
    implements _$$getCurrentLocationImplCopyWith<$Res> {
  __$$getCurrentLocationImplCopyWithImpl(_$getCurrentLocationImpl _value,
      $Res Function(_$getCurrentLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$getCurrentLocationImpl implements _getCurrentLocation {
  const _$getCurrentLocationImpl();

  @override
  String toString() {
    return 'HomeEvent.getCurrentLocation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$getCurrentLocationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllLocations,
    required TResult Function(String title) fetchSearchLocations,
    required TResult Function() getCurrentLocation,
    required TResult Function() getVehicleList,
    required TResult Function(VehicleModel vehicleModel) createVehicle,
  }) {
    return getCurrentLocation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllLocations,
    TResult? Function(String title)? fetchSearchLocations,
    TResult? Function()? getCurrentLocation,
    TResult? Function()? getVehicleList,
    TResult? Function(VehicleModel vehicleModel)? createVehicle,
  }) {
    return getCurrentLocation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllLocations,
    TResult Function(String title)? fetchSearchLocations,
    TResult Function()? getCurrentLocation,
    TResult Function()? getVehicleList,
    TResult Function(VehicleModel vehicleModel)? createVehicle,
    required TResult orElse(),
  }) {
    if (getCurrentLocation != null) {
      return getCurrentLocation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_fetchAllLocations value) fetchAllLocations,
    required TResult Function(_fetchSearchAllLocations value)
        fetchSearchLocations,
    required TResult Function(_getCurrentLocation value) getCurrentLocation,
    required TResult Function(_getVehicleList value) getVehicleList,
    required TResult Function(_createVehicle value) createVehicle,
  }) {
    return getCurrentLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_fetchAllLocations value)? fetchAllLocations,
    TResult? Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult? Function(_getCurrentLocation value)? getCurrentLocation,
    TResult? Function(_getVehicleList value)? getVehicleList,
    TResult? Function(_createVehicle value)? createVehicle,
  }) {
    return getCurrentLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_fetchAllLocations value)? fetchAllLocations,
    TResult Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult Function(_getCurrentLocation value)? getCurrentLocation,
    TResult Function(_getVehicleList value)? getVehicleList,
    TResult Function(_createVehicle value)? createVehicle,
    required TResult orElse(),
  }) {
    if (getCurrentLocation != null) {
      return getCurrentLocation(this);
    }
    return orElse();
  }
}

abstract class _getCurrentLocation implements HomeEvent {
  const factory _getCurrentLocation() = _$getCurrentLocationImpl;
}

/// @nodoc
abstract class _$$getVehicleListImplCopyWith<$Res> {
  factory _$$getVehicleListImplCopyWith(_$getVehicleListImpl value,
          $Res Function(_$getVehicleListImpl) then) =
      __$$getVehicleListImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$getVehicleListImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$getVehicleListImpl>
    implements _$$getVehicleListImplCopyWith<$Res> {
  __$$getVehicleListImplCopyWithImpl(
      _$getVehicleListImpl _value, $Res Function(_$getVehicleListImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$getVehicleListImpl implements _getVehicleList {
  const _$getVehicleListImpl();

  @override
  String toString() {
    return 'HomeEvent.getVehicleList()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$getVehicleListImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllLocations,
    required TResult Function(String title) fetchSearchLocations,
    required TResult Function() getCurrentLocation,
    required TResult Function() getVehicleList,
    required TResult Function(VehicleModel vehicleModel) createVehicle,
  }) {
    return getVehicleList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllLocations,
    TResult? Function(String title)? fetchSearchLocations,
    TResult? Function()? getCurrentLocation,
    TResult? Function()? getVehicleList,
    TResult? Function(VehicleModel vehicleModel)? createVehicle,
  }) {
    return getVehicleList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllLocations,
    TResult Function(String title)? fetchSearchLocations,
    TResult Function()? getCurrentLocation,
    TResult Function()? getVehicleList,
    TResult Function(VehicleModel vehicleModel)? createVehicle,
    required TResult orElse(),
  }) {
    if (getVehicleList != null) {
      return getVehicleList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_fetchAllLocations value) fetchAllLocations,
    required TResult Function(_fetchSearchAllLocations value)
        fetchSearchLocations,
    required TResult Function(_getCurrentLocation value) getCurrentLocation,
    required TResult Function(_getVehicleList value) getVehicleList,
    required TResult Function(_createVehicle value) createVehicle,
  }) {
    return getVehicleList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_fetchAllLocations value)? fetchAllLocations,
    TResult? Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult? Function(_getCurrentLocation value)? getCurrentLocation,
    TResult? Function(_getVehicleList value)? getVehicleList,
    TResult? Function(_createVehicle value)? createVehicle,
  }) {
    return getVehicleList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_fetchAllLocations value)? fetchAllLocations,
    TResult Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult Function(_getCurrentLocation value)? getCurrentLocation,
    TResult Function(_getVehicleList value)? getVehicleList,
    TResult Function(_createVehicle value)? createVehicle,
    required TResult orElse(),
  }) {
    if (getVehicleList != null) {
      return getVehicleList(this);
    }
    return orElse();
  }
}

abstract class _getVehicleList implements HomeEvent {
  const factory _getVehicleList() = _$getVehicleListImpl;
}

/// @nodoc
abstract class _$$createVehicleImplCopyWith<$Res> {
  factory _$$createVehicleImplCopyWith(
          _$createVehicleImpl value, $Res Function(_$createVehicleImpl) then) =
      __$$createVehicleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({VehicleModel vehicleModel});
}

/// @nodoc
class __$$createVehicleImplCopyWithImpl<$Res>
    extends _$HomeEventCopyWithImpl<$Res, _$createVehicleImpl>
    implements _$$createVehicleImplCopyWith<$Res> {
  __$$createVehicleImplCopyWithImpl(
      _$createVehicleImpl _value, $Res Function(_$createVehicleImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleModel = null,
  }) {
    return _then(_$createVehicleImpl(
      null == vehicleModel
          ? _value.vehicleModel
          : vehicleModel // ignore: cast_nullable_to_non_nullable
              as VehicleModel,
    ));
  }
}

/// @nodoc

class _$createVehicleImpl implements _createVehicle {
  const _$createVehicleImpl(this.vehicleModel);

  @override
  final VehicleModel vehicleModel;

  @override
  String toString() {
    return 'HomeEvent.createVehicle(vehicleModel: $vehicleModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$createVehicleImpl &&
            (identical(other.vehicleModel, vehicleModel) ||
                other.vehicleModel == vehicleModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, vehicleModel);

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$createVehicleImplCopyWith<_$createVehicleImpl> get copyWith =>
      __$$createVehicleImplCopyWithImpl<_$createVehicleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetchAllLocations,
    required TResult Function(String title) fetchSearchLocations,
    required TResult Function() getCurrentLocation,
    required TResult Function() getVehicleList,
    required TResult Function(VehicleModel vehicleModel) createVehicle,
  }) {
    return createVehicle(vehicleModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetchAllLocations,
    TResult? Function(String title)? fetchSearchLocations,
    TResult? Function()? getCurrentLocation,
    TResult? Function()? getVehicleList,
    TResult? Function(VehicleModel vehicleModel)? createVehicle,
  }) {
    return createVehicle?.call(vehicleModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetchAllLocations,
    TResult Function(String title)? fetchSearchLocations,
    TResult Function()? getCurrentLocation,
    TResult Function()? getVehicleList,
    TResult Function(VehicleModel vehicleModel)? createVehicle,
    required TResult orElse(),
  }) {
    if (createVehicle != null) {
      return createVehicle(vehicleModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_fetchAllLocations value) fetchAllLocations,
    required TResult Function(_fetchSearchAllLocations value)
        fetchSearchLocations,
    required TResult Function(_getCurrentLocation value) getCurrentLocation,
    required TResult Function(_getVehicleList value) getVehicleList,
    required TResult Function(_createVehicle value) createVehicle,
  }) {
    return createVehicle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_fetchAllLocations value)? fetchAllLocations,
    TResult? Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult? Function(_getCurrentLocation value)? getCurrentLocation,
    TResult? Function(_getVehicleList value)? getVehicleList,
    TResult? Function(_createVehicle value)? createVehicle,
  }) {
    return createVehicle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_fetchAllLocations value)? fetchAllLocations,
    TResult Function(_fetchSearchAllLocations value)? fetchSearchLocations,
    TResult Function(_getCurrentLocation value)? getCurrentLocation,
    TResult Function(_getVehicleList value)? getVehicleList,
    TResult Function(_createVehicle value)? createVehicle,
    required TResult orElse(),
  }) {
    if (createVehicle != null) {
      return createVehicle(this);
    }
    return orElse();
  }
}

abstract class _createVehicle implements HomeEvent {
  const factory _createVehicle(final VehicleModel vehicleModel) =
      _$createVehicleImpl;

  VehicleModel get vehicleModel;

  /// Create a copy of HomeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$createVehicleImplCopyWith<_$createVehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HomeState {
  Status get status => throw _privateConstructorUsedError;
  LatLng? get currentLocation => throw _privateConstructorUsedError;
  List<LocationModel>? get locations => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  ServicePreferences get servicePreferences =>
      throw _privateConstructorUsedError;
  List<VehicleModel>? get vehicleList => throw _privateConstructorUsedError;
  VehicleModel? get createdVehicle => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {Status status,
      LatLng? currentLocation,
      List<LocationModel>? locations,
      String? errorMessage,
      String? searchQuery,
      ServicePreferences servicePreferences,
      List<VehicleModel>? vehicleList,
      VehicleModel? createdVehicle});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentLocation = freezed,
    Object? locations = freezed,
    Object? errorMessage = freezed,
    Object? searchQuery = freezed,
    Object? servicePreferences = null,
    Object? vehicleList = freezed,
    Object? createdVehicle = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      locations: freezed == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      servicePreferences: null == servicePreferences
          ? _value.servicePreferences
          : servicePreferences // ignore: cast_nullable_to_non_nullable
              as ServicePreferences,
      vehicleList: freezed == vehicleList
          ? _value.vehicleList
          : vehicleList // ignore: cast_nullable_to_non_nullable
              as List<VehicleModel>?,
      createdVehicle: freezed == createdVehicle
          ? _value.createdVehicle
          : createdVehicle // ignore: cast_nullable_to_non_nullable
              as VehicleModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      LatLng? currentLocation,
      List<LocationModel>? locations,
      String? errorMessage,
      String? searchQuery,
      ServicePreferences servicePreferences,
      List<VehicleModel>? vehicleList,
      VehicleModel? createdVehicle});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentLocation = freezed,
    Object? locations = freezed,
    Object? errorMessage = freezed,
    Object? searchQuery = freezed,
    Object? servicePreferences = null,
    Object? vehicleList = freezed,
    Object? createdVehicle = freezed,
  }) {
    return _then(_$HomeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      locations: freezed == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<LocationModel>?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      servicePreferences: null == servicePreferences
          ? _value.servicePreferences
          : servicePreferences // ignore: cast_nullable_to_non_nullable
              as ServicePreferences,
      vehicleList: freezed == vehicleList
          ? _value._vehicleList
          : vehicleList // ignore: cast_nullable_to_non_nullable
              as List<VehicleModel>?,
      createdVehicle: freezed == createdVehicle
          ? _value.createdVehicle
          : createdVehicle // ignore: cast_nullable_to_non_nullable
              as VehicleModel?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {this.status = Status.initial,
      this.currentLocation,
      final List<LocationModel>? locations,
      this.errorMessage,
      this.searchQuery,
      this.servicePreferences = const ServicePreferences(),
      final List<VehicleModel>? vehicleList,
      this.createdVehicle})
      : _locations = locations,
        _vehicleList = vehicleList;

  @override
  @JsonKey()
  final Status status;
  @override
  final LatLng? currentLocation;
  final List<LocationModel>? _locations;
  @override
  List<LocationModel>? get locations {
    final value = _locations;
    if (value == null) return null;
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? errorMessage;
  @override
  final String? searchQuery;
  @override
  @JsonKey()
  final ServicePreferences servicePreferences;
  final List<VehicleModel>? _vehicleList;
  @override
  List<VehicleModel>? get vehicleList {
    final value = _vehicleList;
    if (value == null) return null;
    if (_vehicleList is EqualUnmodifiableListView) return _vehicleList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final VehicleModel? createdVehicle;

  @override
  String toString() {
    return 'HomeState(status: $status, currentLocation: $currentLocation, locations: $locations, errorMessage: $errorMessage, searchQuery: $searchQuery, servicePreferences: $servicePreferences, vehicleList: $vehicleList, createdVehicle: $createdVehicle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.servicePreferences, servicePreferences) ||
                other.servicePreferences == servicePreferences) &&
            const DeepCollectionEquality()
                .equals(other._vehicleList, _vehicleList) &&
            (identical(other.createdVehicle, createdVehicle) ||
                other.createdVehicle == createdVehicle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      currentLocation,
      const DeepCollectionEquality().hash(_locations),
      errorMessage,
      searchQuery,
      servicePreferences,
      const DeepCollectionEquality().hash(_vehicleList),
      createdVehicle);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final Status status,
      final LatLng? currentLocation,
      final List<LocationModel>? locations,
      final String? errorMessage,
      final String? searchQuery,
      final ServicePreferences servicePreferences,
      final List<VehicleModel>? vehicleList,
      final VehicleModel? createdVehicle}) = _$HomeStateImpl;

  @override
  Status get status;
  @override
  LatLng? get currentLocation;
  @override
  List<LocationModel>? get locations;
  @override
  String? get errorMessage;
  @override
  String? get searchQuery;
  @override
  ServicePreferences get servicePreferences;
  @override
  List<VehicleModel>? get vehicleList;
  @override
  VehicleModel? get createdVehicle;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
