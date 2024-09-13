
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/extensions/extension.dart';
import 'package:prayers/screens/group/PersonRow.dart';

import '../../riverpod/distinct_sender_provider.dart';
import '../../riverpod/last_message_provider.dart';
import '../../riverpod/message_providers.dart';
import '../../widgets/shimmers/shimmers_people.dart';
import '../group_view.dart';
import 'MessageRow.dart';

/// 그룹뷰 -> 상태보기 페이지
class LastMessageTable extends ConsumerWidget {
  final String roomTag;
  const LastMessageTable({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lastMessagesAsyncValue = ref.watch(lastMessagesProvider(roomTag));

    return Container(child:
    //gapH20,
    lastMessagesAsyncValue.when(
        data: (senders) {

          // 유저별 메시지 모델을 ClientModel로 전환.
          var listOfPeople= senders.map((fromServer)
            => MessageRow(person: SenderModel(
              sender: fromServer.sender,
              senderKey: fromServer.senderKey,
              lastMessage: fromServer.text,
              lastMessageDate: fromServer.createdAt.timeAgo(),
            ))).toList();

          // 메시지 개수로 비교
          //listOfPeople.sort((a,b) => (b.person.messageCount ?? 0).compareTo(a.person.messageCount ?? 0));

          return Column(
              children: listOfPeople
          );
        }, loading: () => const RepeatedShimmerList(),
        error: (error, stackTrace) => const Text('유저 목록을 불러오는 중 오류가 발생했습니다.')
    )
    );


  }
}
