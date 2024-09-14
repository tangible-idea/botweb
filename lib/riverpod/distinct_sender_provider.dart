
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'message_providers.dart';

/// 유저의 그룹명과
final distinctSendersProvider = FutureProvider.family<List<SenderModel>, String>((ref, roomTag) async {
  final supabase = Supabase.instance.client;
  final response = await supabase
      .rpc('get_room_user_stats', params: {'p_room_tag': roomTag});
  print("$response");

  List<SenderModel> senders = response.map<SenderModel>((item) => SenderModel(
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


/// Sender 객체 정의
class SenderModel {
  final String sender;
  final String senderKey;
  final int? messageCount;
  final int? score;
  final String? lastMessage;
  final String? lastMessageDate;

  SenderModel({required this.sender, required this.senderKey, this.messageCount, this.score, this.lastMessage, this.lastMessageDate});

}