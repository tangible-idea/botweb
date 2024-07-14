// Providers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final selectedDaysProvider = StateNotifierProvider<SelectedDaysNotifier, List<bool>>((ref) {
  return SelectedDaysNotifier();
});

final timeValueProvider = StateProvider<TimeOfDay>((ref) {
  final now = DateTime.now().add(const Duration(minutes: 30));
  return TimeOfDay(hour: now.hour, minute: now.minute);
});

final messageTextProvider = StateProvider<String>((ref) => '');

final sendersTextProvider = StateProvider<String>((ref) => '');

final distinctSendersProvider = FutureProvider.autoDispose.family<List<Sender>, String>((ref, roomTag) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .rpc('get_distinct_senders_in_this_room', params: {'p_room_tag': roomTag});

  // 응답의 에러 핸들링
  if (response.error != null) {
    throw Exception('Failed to load senders: ${response.error!.message}');
  }

  // 응답 데이터가 null인지 확인
  if (response.data == null) {
    throw Exception('No data received');
  }

  // 응답 데이터가 List 형태인지 확인하고 변환
  final dynamic data = response.data;
  if (data is! List) {
    throw Exception('Unexpected data format: ${data.runtimeType}');
  }

  // 데이터 변환 및 예외 처리
  try {
    return data.map((item) {
      if (item is! Map<String, dynamic>) {
        throw Exception('Unexpected item format: ${item.runtimeType}');
      }
      return Sender.fromMap(item);
    }).toList();
  } catch (e) {
    throw Exception('Data processing error: $e');
  }
});

class SelectedDaysNotifier extends StateNotifier<List<bool>> {
  SelectedDaysNotifier() : super(List.generate(7, (_) => false));

  void toggle(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) !state[i] else state[i]
    ];
  }
}

// Sender 객체 정의
class Sender {
  final String sender;
  final String senderKey;

  Sender({required this.sender, required this.senderKey});

  factory Sender.fromMap(Map<String, dynamic> map) {
    return Sender(
      sender: map['sender'] as String,
      senderKey: map['sender_key'] as String,
    );
  }
}