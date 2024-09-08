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

class GroupAndAnnounce {
  final String? name;
  final String? announce;

  GroupAndAnnounce({this.name, this.announce});

  // Factory method to create an instance from a map (response from the database)
  factory GroupAndAnnounce.fromMap(Map<String, dynamic> map) {
    return GroupAndAnnounce(
      name: map['name'] as String?,
      announce: map['announce'] as String?,
    );
  }
}