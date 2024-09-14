// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'myuser.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get signedWith => throw _privateConstructorUsedError;
  String get churchId => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyUserCopyWith<MyUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyUserCopyWith<$Res> {
  factory $MyUserCopyWith(MyUser value, $Res Function(MyUser) then) =
      _$MyUserCopyWithImpl<$Res, MyUser>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String signedWith,
      String churchId,
      String groupId,
      String profileImage});
}

/// @nodoc
class _$MyUserCopyWithImpl<$Res, $Val extends MyUser>
    implements $MyUserCopyWith<$Res> {
  _$MyUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? signedWith = null,
    Object? churchId = null,
    Object? groupId = null,
    Object? profileImage = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      signedWith: null == signedWith
          ? _value.signedWith
          : signedWith // ignore: cast_nullable_to_non_nullable
              as String,
      churchId: null == churchId
          ? _value.churchId
          : churchId // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyUserImplCopyWith<$Res> implements $MyUserCopyWith<$Res> {
  factory _$$MyUserImplCopyWith(
          _$MyUserImpl value, $Res Function(_$MyUserImpl) then) =
      __$$MyUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String signedWith,
      String churchId,
      String groupId,
      String profileImage});
}

/// @nodoc
class __$$MyUserImplCopyWithImpl<$Res>
    extends _$MyUserCopyWithImpl<$Res, _$MyUserImpl>
    implements _$$MyUserImplCopyWith<$Res> {
  __$$MyUserImplCopyWithImpl(
      _$MyUserImpl _value, $Res Function(_$MyUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? signedWith = null,
    Object? churchId = null,
    Object? groupId = null,
    Object? profileImage = null,
  }) {
    return _then(_$MyUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      signedWith: null == signedWith
          ? _value.signedWith
          : signedWith // ignore: cast_nullable_to_non_nullable
              as String,
      churchId: null == churchId
          ? _value.churchId
          : churchId // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MyUserImpl implements _MyUser {
  const _$MyUserImpl(
      {required this.id,
      required this.name,
      required this.email,
      required this.signedWith,
      required this.churchId,
      required this.groupId,
      required this.profileImage});

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String signedWith;
  @override
  final String churchId;
  @override
  final String groupId;
  @override
  final String profileImage;

  @override
  String toString() {
    return 'MyUser(id: $id, name: $name, email: $email, signedWith: $signedWith, churchId: $churchId, groupId: $groupId, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.signedWith, signedWith) ||
                other.signedWith == signedWith) &&
            (identical(other.churchId, churchId) ||
                other.churchId == churchId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, signedWith,
      churchId, groupId, profileImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyUserImplCopyWith<_$MyUserImpl> get copyWith =>
      __$$MyUserImplCopyWithImpl<_$MyUserImpl>(this, _$identity);
}

abstract class _MyUser implements MyUser {
  const factory _MyUser(
      {required final String id,
      required final String name,
      required final String email,
      required final String signedWith,
      required final String churchId,
      required final String groupId,
      required final String profileImage}) = _$MyUserImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get signedWith;
  @override
  String get churchId;
  @override
  String get groupId;
  @override
  String get profileImage;
  @override
  @JsonKey(ignore: true)
  _$$MyUserImplCopyWith<_$MyUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
