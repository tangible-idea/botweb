

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/constants/fab_actions.dart';
import 'package:prayers/screens/base_layout.dart';
import 'package:prayers/screens/homepage.dart';

import '../constants/app_sizes.dart';
import '../riverpod/distinct_sender_provider.dart';
import '../riverpod/message_providers.dart';
import '../riverpod/room_name_notifier.dart';
import '../styles/txt_style.dart';
import '../widgets/RoundedPeopleIndicator.dart';
import '../widgets/avatar.dart';
import '../widgets/fab_group.dart';
import '../widgets/shimmers/shimmers.dart';
import '../widgets/shimmers/shimmers_people.dart';
import 'group/LastMessageTable.dart';
import 'group/ViewStatusTable.dart';

class GroupView extends ConsumerWidget {
  const GroupView(this.roomTag, {super.key});

  final String roomTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupNameAsyncValue = ref.watch(groupNameProvider(roomTag));
    final distinctSendersAsyncValue = ref.watch(distinctSendersProvider(roomTag));
    final selectedAction = ref.watch(clickedFabProvider); // 선택한 FAB

    // Decide what widget to show based on the selected action
    Widget content;
    switch (selectedAction) {
      case FABAction.lastConversation:
        content = LastMessageTable(roomTag: roomTag);
        break;
      case FABAction.viewStatus:
        content = ViewStatusTable(roomTag: roomTag);
        break;
      case FABAction.viewContent:
        content = ViewContentWidget();
        break;
      case FABAction.activityRank:
        content = ActivityRankWidget();
        break;
      default:
        content = const Text('No action selected yet.');
    }


    return SingleChildScrollView(
      child: BaseLayout(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 그룹 이름과 공지사항 가져옴.
              groupNameAsyncValue.when(
                data: (pair) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                      children: [
                        Text(pair?.name ?? '.', style: FigmaTextStyles.title34),
                        const Spacer(),
                        distinctSendersAsyncValue.when(
                        data: (senders) =>
                          RoundedPeopleIndicator(peopleCount: senders.length),
                        error: (Object error, StackTrace stackTrace)
                            => const CustomWidget.rectangular(width: 70, height: 30),
                        loading: ()
                            => const CustomWidget.rectangular(width: 70, height: 30),
                        )
                      ],
                    ),

                    const Divider(),
                    gapH4,
                    pair?.announce?.isNotEmpty == true
                        ? Text(pair?.announce?.toString() ?? "", style: FigmaTextStyles.content16)
                        : Text(selectedAction?.label ?? "", style: FigmaTextStyles.content16),
                    gapH20,
                  ]);
                },
                loading: () => CustomWidget.rectangular(width: 100, height: 50)
                 ,
                error: (error, stack) => Text('Error: $error'),
              ),

              content // FAB로 선택된 위젯
            ],
          ),
        ),
      ),
    );
  }

  Widget ViewContentWidget() {
    return Placeholder();
  }

  Widget ActivityRankWidget() {
    return Placeholder();
  }
}


