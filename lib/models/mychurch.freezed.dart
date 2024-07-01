// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mychurch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyChurch _$MyChurchFromJson(Map<String, dynamic> json) {
  return _MyChurch.fromJson(json);
}

/// @nodoc
mixin _$MyChurch {
  String get name => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get paster => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyChurchCopyWith<MyChurch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyChurchCopyWith<$Res> {
  factory $MyChurchCopyWith(MyChurch value, $Res Function(MyChurch) then) =
      _$MyChurchCopyWithImpl<$Res, MyChurch>;
  @useResult
  $Res call({String name, String city, String paster});
}

/// @nodoc
class _$MyChurchCopyWithImpl<$Res, $Val extends MyChurch>
    implements $MyChurchCopyWith<$Res> {
  _$MyChurchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? city = null,
    Object? paster = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      paster: null == paster
          ? _value.paster
          : paster // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyChurchImplCopyWith<$Res>
    implements $MyChurchCopyWith<$Res> {
  factory _$$MyChurchImplCopyWith(
          _$MyChurchImpl value, $Res Function(_$MyChurchImpl) then) =
      __$$MyChurchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String city, String paster});
}

/// @nodoc
class __$$MyChurchImplCopyWithImpl<$Res>
    extends _$MyChurchCopyWithImpl<$Res, _$MyChurchImpl>
    implements _$$MyChurchImplCopyWith<$Res> {
  __$$MyChurchImplCopyWithImpl(
      _$MyChurchImpl _value, $Res Function(_$MyChurchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? city = null,
    Object? paster = null,
  }) {
    return _then(_$MyChurchImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      paster: null == paster
          ? _value.paster
          : paster // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyChurchImpl implements _MyChurch {
  const _$MyChurchImpl(
      {required this.name, required this.city, required this.paster});

  factory _$MyChurchImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyChurchImplFromJson(json);

  @override
  final String name;
  @override
  final String city;
  @override
  final String paster;

  @override
  String toString() {
    return 'MyChurch(name: $name, city: $city, paster: $paster)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyChurchImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.paster, paster) || other.paster == paster));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, city, paster);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyChurchImplCopyWith<_$MyChurchImpl> get copyWith =>
      __$$MyChurchImplCopyWithImpl<_$MyChurchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyChurchImplToJson(
      this,
    );
  }
}

abstract class _MyChurch implements MyChurch {
  const factory _MyChurch(
      {required final String name,
      required final String city,
      required final String paster}) = _$MyChurchImpl;

  factory _MyChurch.fromJson(Map<String, dynamic> json) =
      _$MyChurchImpl.fromJson;

  @override
  String get name;
  @override
  String get city;
  @override
  String get paster;
  @override
  @JsonKey(ignore: true)
  _$$MyChurchImplCopyWith<_$MyChurchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
