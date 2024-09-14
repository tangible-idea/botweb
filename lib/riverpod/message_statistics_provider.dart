// 대화 통계 정보를 담는 SenderModel과 유사한 모델 정의
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/screens/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageStatisticsModel {
  final String sender;
  final int messageCount;
  final int totalWordCount;

  MessageStatisticsModel({
    required this.sender,
    required this.messageCount,
    required this.totalWordCount,
  });

  // Factory method to safely create a MessageStatisticsModel from a Map
  factory MessageStatisticsModel.fromMap(Map<String, dynamic> map) {
    return MessageStatisticsModel(
      sender: map['sender_name'] ?? 'Unknown', // Null safety handling
      messageCount: map['message_count'] ?? 0,
      totalWordCount: map['total_word_count'] ?? 0,
    );
  }
}

// Supabase RPC 함수를 호출하고 데이터를 MessageStatisticsModel로 변환하는 Provider
final messageStatisticsProvider = FutureProvider.family<MessageStatisticsModel?, String>(
      (ref, senderKey) async {
    final supabase = Supabase.instance.client;

    // Supabase의 RPC 함수 호출 ('get_message_statistics' 함수 사용)
    final response = await supabase.rpc('get_message_statistics', params: {
      'p_sender_key': senderKey,
      'p_room_tag': globalRoomTag,
    });
    print(response);

    final List<dynamic> dataList = response as List<dynamic>;

    List<MessageStatisticsModel> statistics = dataList.map((item) {
      final map = item as Map<String, dynamic>;
      return MessageStatisticsModel(
        sender: map['sender_name'] ?? 'Unknown',
        messageCount: map['message_count'] ?? 0,
        totalWordCount: map['total_word_count'] ?? 0,
      );
    }).toList();

    return statistics.isNotEmpty ? statistics.first : null;
  },
);