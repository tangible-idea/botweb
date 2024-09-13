
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod/distinct_sender_provider.dart';
import '../../widgets/shimmers/shimmers_people.dart';
import '../group_view.dart';
import 'PersonRow.dart';

/// 그룹뷰 -> 상태보기 페이지
class ViewStatusTable extends ConsumerWidget {
  final String roomTag;
  const ViewStatusTable({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final distinctSendersAsyncValue = ref.watch(distinctSendersProvider(roomTag));

    return Container(child:
      //gapH20,
      distinctSendersAsyncValue.when(
          data: (senders) {

            var listOfPeople= senders.map((person) => PersonRow(person: person)).toList();

            // 메시지 개수로 비교
            listOfPeople.sort((a,b) => (b.person.messageCount ?? 0).compareTo(a.person.messageCount ?? 0));

            return Column(
              children: listOfPeople
            );
          }, loading: () => const RepeatedShimmerList(),
          error: (error, stackTrace) => const Text('유저 목록을 불러오는 중 오류가 발생했습니다.')
      )
    );
  }
}
