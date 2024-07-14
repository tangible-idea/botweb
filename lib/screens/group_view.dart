

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_sizes.dart';
import '../models/PersonInfo.dart';
import '../riverpod/room_name_notifier.dart';
import '../styles/txt_style.dart';
import '../widgets/avatar.dart';

class GroupView extends ConsumerWidget {
  GroupView(this.roomTag, {super.key});

  final String roomTag;


  final List<PersonInfo> people = [
    PersonInfo(name: "원아영", role: "목자"),
    PersonInfo(name: "하예린", role: "순목자"),
    PersonInfo(name: "강민규", role: "목원"),
    PersonInfo(name: "김세련", role: "목원"),
    PersonInfo(name: "이찬경", role: "목원"),
    PersonInfo(name: "정윤기", role: "목원"),
    PersonInfo(name: "전하는", role: "목원"),
    PersonInfo(name: "문예은", role: "목원"),
    PersonInfo(name: "김도형", role: "목원"),
    PersonInfo(name: "박재현", role: "목원"),
    PersonInfo(name: "최준혁", role: "목원"),
    PersonInfo(name: "허열", role: "목원"),
    // 추가 인물 정보...
  ];


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupNameAsyncValue = ref.watch(groupNameProvider(roomTag));



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        groupNameAsyncValue.when(
          data: (name) => Text(name ?? '.', style: FigmaTextStyles.title30,),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
        gapH4,
        const Text("우리 목장: 매주 주일 14시 모임!\n느헤미야 기도 프로젝트 참석해주세요~",
            style: FigmaTextStyles.content16),
        gapH48,

        /// Button1. TODO🎥

        //gapH20,
        ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Column(
          children: people.map((person) => PersonRow(person: person)).toList(),
          ),
        ),

        /// Button2. get POE bot
        Expanded(
          flex: 1,
          child: Center(
            child: IconButton(
                onPressed: () async {}, icon: const Icon(Icons.golf_course)),
          ),
        ),
      ],
    );
  }
}

class PersonRow extends StatelessWidget {
  final PersonInfo person;

  const PersonRow({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Avatar(radius: 30),
          gapW16,
          Expanded(  // Expanded 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),  // 적절한 최대 너비 설정
                  child: Text(person.name, style: FigmaTextStyles.title26),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),  // 적절한 최대 너비 설정
                  child: Text(person.role, style: FigmaTextStyles.content16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}