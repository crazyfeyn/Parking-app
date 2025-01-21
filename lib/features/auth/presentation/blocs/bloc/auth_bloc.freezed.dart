// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$logImplCopyWith<$Res> {
  factory _$$logImplCopyWith(_$logImpl value, $Res Function(_$logImpl) then) =
      __$$logImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password, String email});
}

/// @nodoc
class __$$logImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$logImpl>
    implements _$$logImplCopyWith<$Res> {
  __$$logImplCopyWithImpl(_$logImpl _value, $Res Function(_$logImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? email = null,
  }) {
    return _then(_$logImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$logImpl implements _log {
  const _$logImpl(this.password, this.email);

  @override
  final String password;
  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.logIn(password: $password, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$logImpl &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$logImplCopyWith<_$logImpl> get copyWith =>
      __$$logImplCopyWithImpl<_$logImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return logIn(password, email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return logIn?.call(password, email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(password, email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return logIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return logIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(this);
    }
    return orElse();
  }
}

abstract class _log implements AuthEvent {
  const factory _log(final String password, final String email) = _$logImpl;

  String get password;
  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$logImplCopyWith<_$logImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$regImplCopyWith<$Res> {
  factory _$$regImplCopyWith(_$regImpl value, $Res Function(_$regImpl) then) =
      __$$regImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password, String email, String name, String surname});
}

/// @nodoc
class __$$regImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$regImpl>
    implements _$$regImplCopyWith<$Res> {
  __$$regImplCopyWithImpl(_$regImpl _value, $Res Function(_$regImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? email = null,
    Object? name = null,
    Object? surname = null,
  }) {
    return _then(_$regImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$regImpl implements _reg {
  const _$regImpl(this.password, this.email, this.name, this.surname);

  @override
  final String password;
  @override
  final String email;
  @override
  final String name;
  @override
  final String surname;

  @override
  String toString() {
    return 'AuthEvent.register(password: $password, email: $email, name: $name, surname: $surname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$regImpl &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password, email, name, surname);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$regImplCopyWith<_$regImpl> get copyWith =>
      __$$regImplCopyWithImpl<_$regImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return register(password, email, name, surname);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return register?.call(password, email, name, surname);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(password, email, name, surname);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }
}

abstract class _reg implements AuthEvent {
  const factory _reg(final String password, final String email,
      final String name, final String surname) = _$regImpl;

  String get password;
  String get email;
  String get name;
  String get surname;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$regImplCopyWith<_$regImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$changePassImplCopyWith<$Res> {
  factory _$$changePassImplCopyWith(
          _$changePassImpl value, $Res Function(_$changePassImpl) then) =
      __$$changePassImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String oldPass, String newPass});
}

/// @nodoc
class __$$changePassImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$changePassImpl>
    implements _$$changePassImplCopyWith<$Res> {
  __$$changePassImplCopyWithImpl(
      _$changePassImpl _value, $Res Function(_$changePassImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPass = null,
    Object? newPass = null,
  }) {
    return _then(_$changePassImpl(
      null == oldPass
          ? _value.oldPass
          : oldPass // ignore: cast_nullable_to_non_nullable
              as String,
      null == newPass
          ? _value.newPass
          : newPass // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$changePassImpl implements _changePass {
  const _$changePassImpl(this.oldPass, this.newPass);

  @override
  final String oldPass;
  @override
  final String newPass;

  @override
  String toString() {
    return 'AuthEvent.change(oldPass: $oldPass, newPass: $newPass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$changePassImpl &&
            (identical(other.oldPass, oldPass) || other.oldPass == oldPass) &&
            (identical(other.newPass, newPass) || other.newPass == newPass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldPass, newPass);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$changePassImplCopyWith<_$changePassImpl> get copyWith =>
      __$$changePassImplCopyWithImpl<_$changePassImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return change(oldPass, newPass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return change?.call(oldPass, newPass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (change != null) {
      return change(oldPass, newPass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return change(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return change?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (change != null) {
      return change(this);
    }
    return orElse();
  }
}

abstract class _changePass implements AuthEvent {
  const factory _changePass(final String oldPass, final String newPass) =
      _$changePassImpl;

  String get oldPass;
  String get newPass;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$changePassImplCopyWith<_$changePassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$resetPassImplCopyWith<$Res> {
  factory _$$resetPassImplCopyWith(
          _$resetPassImpl value, $Res Function(_$resetPassImpl) then) =
      __$$resetPassImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$resetPassImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$resetPassImpl>
    implements _$$resetPassImplCopyWith<$Res> {
  __$$resetPassImplCopyWithImpl(
      _$resetPassImpl _value, $Res Function(_$resetPassImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$resetPassImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$resetPassImpl implements _resetPass {
  const _$resetPassImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.reset(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$resetPassImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$resetPassImplCopyWith<_$resetPassImpl> get copyWith =>
      __$$resetPassImplCopyWithImpl<_$resetPassImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return reset(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return reset?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _resetPass implements AuthEvent {
  const factory _resetPass(final String email) = _$resetPassImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$resetPassImplCopyWith<_$resetPassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$logOutImplCopyWith<$Res> {
  factory _$$logOutImplCopyWith(
          _$logOutImpl value, $Res Function(_$logOutImpl) then) =
      __$$logOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$logOutImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$logOutImpl>
    implements _$$logOutImplCopyWith<$Res> {
  __$$logOutImplCopyWithImpl(
      _$logOutImpl _value, $Res Function(_$logOutImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$logOutImpl implements _logOut {
  const _$logOutImpl();

  @override
  String toString() {
    return 'AuthEvent.logOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$logOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return logOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return logOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return logOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return logOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut(this);
    }
    return orElse();
  }
}

abstract class _logOut implements AuthEvent {
  const factory _logOut() = _$logOutImpl;
}

/// @nodoc
abstract class _$$refreshTokenImplCopyWith<$Res> {
  factory _$$refreshTokenImplCopyWith(
          _$refreshTokenImpl value, $Res Function(_$refreshTokenImpl) then) =
      __$$refreshTokenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$refreshTokenImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$refreshTokenImpl>
    implements _$$refreshTokenImplCopyWith<$Res> {
  __$$refreshTokenImplCopyWithImpl(
      _$refreshTokenImpl _value, $Res Function(_$refreshTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$refreshTokenImpl implements _refreshToken {
  const _$refreshTokenImpl();

  @override
  String toString() {
    return 'AuthEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$refreshTokenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class _refreshToken implements AuthEvent {
  const factory _refreshToken() = _$refreshTokenImpl;
}

/// @nodoc
abstract class _$$stopTokenImplCopyWith<$Res> {
  factory _$$stopTokenImplCopyWith(
          _$stopTokenImpl value, $Res Function(_$stopTokenImpl) then) =
      __$$stopTokenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$stopTokenImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$stopTokenImpl>
    implements _$$stopTokenImplCopyWith<$Res> {
  __$$stopTokenImplCopyWithImpl(
      _$stopTokenImpl _value, $Res Function(_$stopTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$stopTokenImpl implements _stopToken {
  const _$stopTokenImpl();

  @override
  String toString() {
    return 'AuthEvent.stop()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$stopTokenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return stop();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return stop?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return stop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return stop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop(this);
    }
    return orElse();
  }
}

abstract class _stopToken implements AuthEvent {
  const factory _stopToken() = _$stopTokenImpl;
}

/// @nodoc
abstract class _$$authicatedImplCopyWith<$Res> {
  factory _$$authicatedImplCopyWith(
          _$authicatedImpl value, $Res Function(_$authicatedImpl) then) =
      __$$authicatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$authicatedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$authicatedImpl>
    implements _$$authicatedImplCopyWith<$Res> {
  __$$authicatedImplCopyWithImpl(
      _$authicatedImpl _value, $Res Function(_$authicatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$authicatedImpl implements _authicated {
  const _$authicatedImpl();

  @override
  String toString() {
    return 'AuthEvent.authicated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$authicatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return authicated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return authicated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (authicated != null) {
      return authicated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return authicated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return authicated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (authicated != null) {
      return authicated(this);
    }
    return orElse();
  }
}

abstract class _authicated implements AuthEvent {
  const factory _authicated() = _$authicatedImpl;
}

/// @nodoc
abstract class _$$initialImplCopyWith<$Res> {
  factory _$$initialImplCopyWith(
          _$initialImpl value, $Res Function(_$initialImpl) then) =
      __$$initialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$initialImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$initialImpl>
    implements _$$initialImplCopyWith<$Res> {
  __$$initialImplCopyWithImpl(
      _$initialImpl _value, $Res Function(_$initialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$initialImpl implements _initial {
  const _$initialImpl();

  @override
  String toString() {
    return 'AuthEvent.doInitial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$initialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String password, String email) logIn,
    required TResult Function(
            String password, String email, String name, String surname)
        register,
    required TResult Function(String oldPass, String newPass) change,
    required TResult Function(String email) reset,
    required TResult Function() logOut,
    required TResult Function() refresh,
    required TResult Function() stop,
    required TResult Function() authicated,
    required TResult Function() doInitial,
  }) {
    return doInitial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String password, String email)? logIn,
    TResult? Function(
            String password, String email, String name, String surname)?
        register,
    TResult? Function(String oldPass, String newPass)? change,
    TResult? Function(String email)? reset,
    TResult? Function()? logOut,
    TResult? Function()? refresh,
    TResult? Function()? stop,
    TResult? Function()? authicated,
    TResult? Function()? doInitial,
  }) {
    return doInitial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String password, String email)? logIn,
    TResult Function(
            String password, String email, String name, String surname)?
        register,
    TResult Function(String oldPass, String newPass)? change,
    TResult Function(String email)? reset,
    TResult Function()? logOut,
    TResult Function()? refresh,
    TResult Function()? stop,
    TResult Function()? authicated,
    TResult Function()? doInitial,
    required TResult orElse(),
  }) {
    if (doInitial != null) {
      return doInitial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_log value) logIn,
    required TResult Function(_reg value) register,
    required TResult Function(_changePass value) change,
    required TResult Function(_resetPass value) reset,
    required TResult Function(_logOut value) logOut,
    required TResult Function(_refreshToken value) refresh,
    required TResult Function(_stopToken value) stop,
    required TResult Function(_authicated value) authicated,
    required TResult Function(_initial value) doInitial,
  }) {
    return doInitial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_log value)? logIn,
    TResult? Function(_reg value)? register,
    TResult? Function(_changePass value)? change,
    TResult? Function(_resetPass value)? reset,
    TResult? Function(_logOut value)? logOut,
    TResult? Function(_refreshToken value)? refresh,
    TResult? Function(_stopToken value)? stop,
    TResult? Function(_authicated value)? authicated,
    TResult? Function(_initial value)? doInitial,
  }) {
    return doInitial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_log value)? logIn,
    TResult Function(_reg value)? register,
    TResult Function(_changePass value)? change,
    TResult Function(_resetPass value)? reset,
    TResult Function(_logOut value)? logOut,
    TResult Function(_refreshToken value)? refresh,
    TResult Function(_stopToken value)? stop,
    TResult Function(_authicated value)? authicated,
    TResult Function(_initial value)? doInitial,
    required TResult orElse(),
  }) {
    if (doInitial != null) {
      return doInitial(this);
    }
    return orElse();
  }
}

abstract class _initial implements AuthEvent {
  const factory _initial() = _$initialImpl;
}

/// @nodoc
mixin _$AuthState {
  Status get status => throw _privateConstructorUsedError;
  Status2 get status2 => throw _privateConstructorUsedError;
  Status3 get status3 => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({Status status, Status2 status2, Status3 status3});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? status2 = null,
    Object? status3 = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      status2: null == status2
          ? _value.status2
          : status2 // ignore: cast_nullable_to_non_nullable
              as Status2,
      status3: null == status3
          ? _value.status3
          : status3 // ignore: cast_nullable_to_non_nullable
              as Status3,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Status status, Status2 status2, Status3 status3});
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? status2 = null,
    Object? status3 = null,
  }) {
    return _then(_$AuthStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      status2: null == status2
          ? _value.status2
          : status2 // ignore: cast_nullable_to_non_nullable
              as Status2,
      status3: null == status3
          ? _value.status3
          : status3 // ignore: cast_nullable_to_non_nullable
              as Status3,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  _$AuthStateImpl(
      {this.status = Status.initial,
      this.status2 = Status2.initial,
      this.status3 = Status3.initial});

  @override
  @JsonKey()
  final Status status;
  @override
  @JsonKey()
  final Status2 status2;
  @override
  @JsonKey()
  final Status3 status3;

  @override
  String toString() {
    return 'AuthState(status: $status, status2: $status2, status3: $status3)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.status2, status2) || other.status2 == status2) &&
            (identical(other.status3, status3) || other.status3 == status3));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, status2, status3);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  factory _AuthState(
      {final Status status,
      final Status2 status2,
      final Status3 status3}) = _$AuthStateImpl;

  @override
  Status get status;
  @override
  Status2 get status2;
  @override
  Status3 get status3;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
