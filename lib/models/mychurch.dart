import 'package:freezed_annotation/freezed_annotation.dart';

part 'mychurch.freezed.dart';
part 'mychurch.g.dart';

@freezed
class MyChurch with _$MyChurch {
  const factory MyChurch({
    required String name,
    required String city,
    required String paster,
  })= _MyChurch;

  factory MyChurch.fromJson(Map<String, dynamic> json) => _$MyChurchFromJson(json);
}