

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/data/api/send_message.dart';
import 'package:prayers/screens/base_layout.dart';
import 'package:prayers/screens/homepage.dart';
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



  final List<PersonInfo> people = [
    PersonInfo(name: "원아영", role: "방장"),
    PersonInfo(name: "하예린", role: "부방장"),
    PersonInfo(name: "강민규", role: "구성원"),
    PersonInfo(name: "김세련", role: "구성원"),
    PersonInfo(name: "이찬경", role: "구성원"),
    PersonInfo(name: "정윤기", role: "구성원"),
    PersonInfo(name: "전하는", role: "구성원"),
    PersonInfo(name: "문예은", role: "구성원"),
    PersonInfo(name: "김도형", role: "구성원"),
    PersonInfo(name: "박재현", role: "구성원"),
    PersonInfo(name: "최준혁", role: "구성원"),
    PersonInfo(name: "허열", role: "구성원"),
    // 추가 인물 정보...
  ];


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
            }, loading: () => const CircularProgressIndicator(),
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

  const PersonRow({Key? key, required this.person, required this.roomTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // TODO:
          //Avatar(radius: 30, roomTag: globalRoomTag, senderKey: person.senderKey),
          Icon(Icons.camera_alt, size: 30),
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