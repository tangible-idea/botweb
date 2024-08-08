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
  print("$response");

  if (response.error != null) {
    print('Failed to load senders: ${response.error!.message}');
    throw Exception('Failed to load senders: ${response.error!.message}');
  }

  if (response.data == null) {
    print('No data received');
    throw Exception('No data received');
  }

  // Ensure data is treated as a List
  final List<dynamic> data = response.data as List<dynamic>;

  try {
    return data.map<Sender>((item) {
      if (item is! Map<String, dynamic>) {
        print('Unexpected item format: ${item.runtimeType}');
        throw Exception('Unexpected item format: ${item.runtimeType}');
      }
      return Sender.fromMap(item);
    }).toList();
  } catch (e) {
    print('Data processing error: $e');
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