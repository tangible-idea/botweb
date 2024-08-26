

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/data/api/send_message.dart';
import 'package:prayers/screens/base_layout.dart';
import 'package:prayers/screens/homepage.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_sizes.dart';
import '../models/PersonInfo.dart';
import '../riverpod/message_providers.dart';
import '../riverpod/room_name_notifier.dart';
import '../styles/txt_style.dart';
import '../widgets/avatar.dart';


class GroupView extends ConsumerWidget {
  GroupView(this.roomTag, {super.key});

  final String roomTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupNameAsyncValue = ref.watch(groupNameProvider(roomTag));
    final distinctSendersAsyncValue = ref.watch(distinctSendersProvider(roomTag));


    return SingleChildScrollView(
      child: BaseLayout(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            groupNameAsyncValue.when(
              data: (name) => Text(name ?? '.', style: FigmaTextStyles.title30,),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            gapH4,
            const Text("우리방 공지: 샘플",
                style: FigmaTextStyles.content16),
            gapH20,

            //gapH20,
            distinctSendersAsyncValue.when(
              data: (senders) {
                return Column(
                  children: senders.map((person) =>
                      PersonRow(
                        person: person,
                        roomTag: "")).toList(),
                );
            }, loading: () {
                return const CircularProgressIndicator();
              // final fakeUsers = List.filled(7, Sender(sender: "", senderKey: ""));
              //
              // return Skeletonizer(
              //   child: Column(
              //     children: fakeUsers.map((person) =>
              //         PersonRow(
              //             person: person,
              //             roomTag: "")).toList(),
              //     )
              //   );
            },
            error: (error, stackTrace) => const Text('유저 목록을 불러오는 중 오류가 발생했습니다.'))



          ],
        ),
      ),
    );
  }
}

class PersonRow extends StatelessWidget {
  final Sender person;
  final String roomTag;

  const PersonRow({super.key, required this.person, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // TODO:
          Avatar(radius: 30, roomTag: globalRoomTag, senderKey: person.senderKey),
          //const CircleAvatar(backgroundColor: MyColor.kPrimary, radius: 30, child: Icon(Icons.camera_alt)),
          gapW16,
          Expanded(  // Expanded 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),  // 적절한 최대 너비 설정
                  child: Text(person.sender, style: FigmaTextStyles.title26),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),  // 적절한 최대 너비 설정
                  child: Text(person.senderKey.substring(0, 20), style: FigmaTextStyles.content16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}