// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mygroup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyGroup {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get postfix => throw _privateConstructorUsedError;
  String get churchId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyGroupCopyWith<MyGroup> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyGroupCopyWith<$Res> {
  factory $MyGroupCopyWith(MyGroup value, $Res Function(MyGroup) then) =
      _$MyGroupCopyWithImpl<$Res, MyGroup>;
  @useResult
  $Res call({String id, String name, String postfix, String churchId});
}

/// @nodoc
class _$MyGroupCopyWithImpl<$Res, $Val extends MyGroup>
    implements $MyGroupCopyWith<$Res> {
  _$MyGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? postfix = null,
    Object? churchId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      postfix: null == postfix
          ? _value.postfix
          : postfix // ignore: cast_nullable_to_non_nullable
              as String,
      churchId: null == churchId
          ? _value.churchId
          : churchId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyGroupImplCopyWith<$Res> implements $MyGroupCopyWith<$Res> {
  factory _$$MyGroupImplCopyWith(
          _$MyGroupImpl value, $Res Function(_$MyGroupImpl) then) =
      __$$MyGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String postfix, String churchId});
}

/// @nodoc
class __$$MyGroupImplCopyWithImpl<$Res>
    extends _$MyGroupCopyWithImpl<$Res, _$MyGroupImpl>
    implements _$$MyGroupImplCopyWith<$Res> {
  __$$MyGroupImplCopyWithImpl(
      _$MyGroupImpl _value, $Res Function(_$MyGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? postfix = null,
    Object? churchId = null,
  }) {
    return _then(_$MyGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      postfix: null == postfix
          ? _value.postfix
          : postfix // ignore: cast_nullable_to_non_nullable
              as String,
      churchId: null == churchId
          ? _value.churchId
          : churchId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyGroupImpl implements _MyGroup {
  const _$MyGroupImpl(
      {required this.id,
      required this.name,
      required this.postfix,
      required this.churchId});

  @override
  final String id;
  @override
  final String name;
  @override
  final String postfix;
  @override
  final String churchId;

  @override
  String toString() {
    return 'MyGroup(id: $id, name: $name, postfix: $postfix, churchId: $churchId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.postfix, postfix) || other.postfix == postfix) &&
            (identical(other.churchId, churchId) ||
                other.churchId == churchId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, postfix, churchId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyGroupImplCopyWith<_$MyGroupImpl> get copyWith =>
      __$$MyGroupImplCopyWithImpl<_$MyGroupImpl>(this, _$identity);
}

abstract class _MyGroup implements MyGroup {
  const factory _MyGroup(
      {required final String id,
      required final String name,
      required final String postfix,
      required final String churchId}) = _$MyGroupImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get postfix;
  @override
  String get churchId;
  @override
  @JsonKey(ignore: true)
  _$$MyGroupImplCopyWith<_$MyGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
