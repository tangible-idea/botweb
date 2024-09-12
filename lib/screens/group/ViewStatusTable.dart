
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/message_providers.dart';
import '../../widgets/shimmers/shimmers_people.dart';
import '../group_view.dart';

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
            return Column(
              children: senders.map((person) =>
                  PersonRow(person: person)).toList(),
            );
          }, loading: () => const RepeatedShimmerList(),
          error: (error, stackTrace) => const Text('유저 목록을 불러오는 중 오류가 발생했습니다.')
      )
    );
  }
}
