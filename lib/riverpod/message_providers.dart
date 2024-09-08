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

final distinctSendersProvider = FutureProvider.family.autoDispose<List<Sender>, String>((ref, roomTag) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .rpc('get_room_user_stats', params: {'p_room_tag': roomTag});
  print("$response");

  List<Sender> senders = response.map<Sender>((item) => Sender(
      sender: item['sender']!,
      senderKey: item['sender_key']!,
      messageCount: item['message_count']!,
      score: item['quiz_score']!
  )).toList();

  for (var sender in senders) {
    print('Sender: ${sender.sender}, Sender Key: ${sender.senderKey}, count: ${sender.messageCount}, score: ${sender.score}}');
  }

  return senders;
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
  final int messageCount;
  final int score;

  Sender({required this.sender, required this.senderKey, required this.messageCount, required this.score});

}