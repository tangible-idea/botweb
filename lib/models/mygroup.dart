import 'package:freezed_annotation/freezed_annotation.dart';

part 'mygroup.freezed.dart';

@freezed
class MyGroup with _$MyGroup {
  const factory MyGroup({
    required String id,
    required String name,
    required String postfix,
    required String churchId,
  })= _MyGroup;
}