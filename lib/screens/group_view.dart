

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/constants/fab_actions.dart';
import 'package:prayers/screens/base_layout.dart';
import 'package:prayers/screens/homepage.dart';

import '../constants/app_sizes.dart';
import '../riverpod/message_providers.dart';
import '../riverpod/room_name_notifier.dart';
import '../styles/txt_style.dart';
import '../widgets/RoundedPeopleIndicator.dart';
import '../widgets/avatar.dart';
import '../widgets/fab_group.dart';
import '../widgets/shimmers.dart';


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
        content = LastConversationWidget();
        break;
      case FABAction.viewStatus:
        content = ViewStatusWidget();
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
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              ),


              //gapH20,
              distinctSendersAsyncValue.when(
                data: (senders) {
                  return Column(
                    children: senders.map((person) =>
                        PersonRow(person: person)).toList(),
                  );
              }, loading: () {
                  return const CircularProgressIndicator();
              },
              error: (error, stackTrace) => const Text('유저 목록을 불러오는 중 오류가 발생했습니다.')
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget ViewStatusWidget() {
    return ViewStatusTable(roomTag: roomTag);
  }

  Widget LastConversationWidget() {
    return Placeholder();
  }

  Widget ViewContentWidget() {
    return Placeholder();
  }

  Widget ActivityRankWidget() {
    return Placeholder();
  }
}


class ViewStatusTable extends ConsumerWidget {
  final String roomTag;
  const ViewStatusTable({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return const Placeholder();
  }
}



class PersonRow extends ConsumerWidget {
  final Sender person;

  const PersonRow({super.key, required this.person});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Avatar(radius: 30, roomTag: globalRoomTag, senderKey: person.senderKey),
          gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person.sender, style: FigmaTextStyles.title26),
                gapH4, // 아이템 사이 간격 추가
                  Row(
                      children: [
                      Row(
                      children: [
                          const Icon(Icons.energy_savings_leaf_outlined, size: 16, color: Colors.grey), // 메시지 아이콘
                      gapW4, // 아이콘과 텍스트 사이 간격
                      Text("${person.score}", style: FigmaTextStyles.content16), // 메시지 개수
                    ],
                  ),
                  gapW16, // 아이템 사이 간격 추가
                  Row(
                    children: [
                      const Icon(Icons.message_outlined, size: 16, color: Colors.grey), // 메시지 아이콘
                      gapW4, // 아이콘과 텍스트 사이 간격
                      Text("${person.messageCount}", style: FigmaTextStyles.content16), // 메시지 개수
                    ],
                  ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}