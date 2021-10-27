// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'unifedi_api_client_application_model_pleroma_adapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnifediApiClientApplicationPleromaAdapter
    _$UnifediApiClientApplicationPleromaAdapterFromJson(
        Map<String, dynamic> json) {
  return _UnifediApiClientApplicationPleromaAdapter.fromJson(json);
}

/// @nodoc
class _$UnifediApiClientApplicationPleromaAdapterTearOff {
  const _$UnifediApiClientApplicationPleromaAdapterTearOff();

  _UnifediApiClientApplicationPleromaAdapter call(
      @HiveField(0) PleromaApiClientApplication value) {
    return _UnifediApiClientApplicationPleromaAdapter(
      value,
    );
  }

  UnifediApiClientApplicationPleromaAdapter fromJson(
      Map<String, Object?> json) {
    return UnifediApiClientApplicationPleromaAdapter.fromJson(json);
  }
}

/// @nodoc
const $UnifediApiClientApplicationPleromaAdapter =
    _$UnifediApiClientApplicationPleromaAdapterTearOff();

/// @nodoc
mixin _$UnifediApiClientApplicationPleromaAdapter {
  @HiveField(0)
  PleromaApiClientApplication get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnifediApiClientApplicationPleromaAdapterCopyWith<
          UnifediApiClientApplicationPleromaAdapter>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnifediApiClientApplicationPleromaAdapterCopyWith<$Res> {
  factory $UnifediApiClientApplicationPleromaAdapterCopyWith(
          UnifediApiClientApplicationPleromaAdapter value,
          $Res Function(UnifediApiClientApplicationPleromaAdapter) then) =
      _$UnifediApiClientApplicationPleromaAdapterCopyWithImpl<$Res>;
  $Res call({@HiveField(0) PleromaApiClientApplication value});

  $PleromaApiClientApplicationCopyWith<$Res> get value;
}

/// @nodoc
class _$UnifediApiClientApplicationPleromaAdapterCopyWithImpl<$Res>
    implements $UnifediApiClientApplicationPleromaAdapterCopyWith<$Res> {
  _$UnifediApiClientApplicationPleromaAdapterCopyWithImpl(
      this._value, this._then);

  final UnifediApiClientApplicationPleromaAdapter _value;
  // ignore: unused_field
  final $Res Function(UnifediApiClientApplicationPleromaAdapter) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as PleromaApiClientApplication,
    ));
  }

  @override
  $PleromaApiClientApplicationCopyWith<$Res> get value {
    return $PleromaApiClientApplicationCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
abstract class _$UnifediApiClientApplicationPleromaAdapterCopyWith<$Res>
    implements $UnifediApiClientApplicationPleromaAdapterCopyWith<$Res> {
  factory _$UnifediApiClientApplicationPleromaAdapterCopyWith(
          _UnifediApiClientApplicationPleromaAdapter value,
          $Res Function(_UnifediApiClientApplicationPleromaAdapter) then) =
      __$UnifediApiClientApplicationPleromaAdapterCopyWithImpl<$Res>;
  @override
  $Res call({@HiveField(0) PleromaApiClientApplication value});

  @override
  $PleromaApiClientApplicationCopyWith<$Res> get value;
}

/// @nodoc
class __$UnifediApiClientApplicationPleromaAdapterCopyWithImpl<$Res>
    extends _$UnifediApiClientApplicationPleromaAdapterCopyWithImpl<$Res>
    implements _$UnifediApiClientApplicationPleromaAdapterCopyWith<$Res> {
  __$UnifediApiClientApplicationPleromaAdapterCopyWithImpl(
      _UnifediApiClientApplicationPleromaAdapter _value,
      $Res Function(_UnifediApiClientApplicationPleromaAdapter) _then)
      : super(_value,
            (v) => _then(v as _UnifediApiClientApplicationPleromaAdapter));

  @override
  _UnifediApiClientApplicationPleromaAdapter get _value =>
      super._value as _UnifediApiClientApplicationPleromaAdapter;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_UnifediApiClientApplicationPleromaAdapter(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as PleromaApiClientApplication,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnifediApiClientApplicationPleromaAdapter
    extends _UnifediApiClientApplicationPleromaAdapter {
  const _$_UnifediApiClientApplicationPleromaAdapter(@HiveField(0) this.value)
      : super._();

  factory _$_UnifediApiClientApplicationPleromaAdapter.fromJson(
          Map<String, dynamic> json) =>
      _$$_UnifediApiClientApplicationPleromaAdapterFromJson(json);

  @override
  @HiveField(0)
  final PleromaApiClientApplication value;

  @override
  String toString() {
    return 'UnifediApiClientApplicationPleromaAdapter(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnifediApiClientApplicationPleromaAdapter &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  _$UnifediApiClientApplicationPleromaAdapterCopyWith<
          _UnifediApiClientApplicationPleromaAdapter>
      get copyWith => __$UnifediApiClientApplicationPleromaAdapterCopyWithImpl<
          _UnifediApiClientApplicationPleromaAdapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnifediApiClientApplicationPleromaAdapterToJson(this);
  }
}

abstract class _UnifediApiClientApplicationPleromaAdapter
    extends UnifediApiClientApplicationPleromaAdapter {
  const factory _UnifediApiClientApplicationPleromaAdapter(
          @HiveField(0) PleromaApiClientApplication value) =
      _$_UnifediApiClientApplicationPleromaAdapter;
  const _UnifediApiClientApplicationPleromaAdapter._() : super._();

  factory _UnifediApiClientApplicationPleromaAdapter.fromJson(
          Map<String, dynamic> json) =
      _$_UnifediApiClientApplicationPleromaAdapter.fromJson;

  @override
  @HiveField(0)
  PleromaApiClientApplication get value;
  @override
  @JsonKey(ignore: true)
  _$UnifediApiClientApplicationPleromaAdapterCopyWith<
          _UnifediApiClientApplicationPleromaAdapter>
      get copyWith => throw _privateConstructorUsedError;
}
