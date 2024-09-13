
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Supabase 클라이언트 인스턴스 가져오기
final supabase = Supabase.instance.client;

// FutureProvider 정의
final lastMessagesProvider = FutureProvider.family<List<LastMessageModel>, String>((ref, roomTag) async {
  // Supabase에서 PostgreSQL 함수 (RPC) 호출
  final response = await supabase
      .rpc('get_last_messages_by_room', params: {'p_room_tag': roomTag});

  print("$response");

  List<LastMessageModel> lastMessages = response.map<LastMessageModel>((item) => LastMessageModel(
    senderKey: item['sender_key'],
    sender: item['sender'],
    text: item['text'],
    createdAt: DateTime.parse(item['created_at']),
  )).toList();

  for (var message in lastMessages) {
    print('Sender: ${message.sender}, Sender Key: ${message.senderKey}, Text: ${message.text}, Created At: ${message.createdAt}');
  }

  return lastMessages;
});

/// LastMessage 객체 정의
class LastMessageModel {
  final String senderKey;
  final String sender;
  final String text;
  final DateTime createdAt;

  LastMessageModel({
    required this.senderKey,
    required this.sender,
    required this.text,
    required this.createdAt,
  });
}