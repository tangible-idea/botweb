import 'package:freezed_annotation/freezed_annotation.dart';

part 'myuser.freezed.dart';

@freezed
class MyUser with _$MyUser {
  const factory MyUser({
    required String id,
    required String name,
    required String email,
    required String signedWith,
    required String churchId,
    required String groupId,
    required String profileImage
  })= _MyUser;
}