

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_sizes.dart';
import '../riverpod/room_name_notifier.dart';
import '../styles/txt_style.dart';
import '../widgets/avatar.dart';

class GroupView extends ConsumerWidget {
  const GroupView(this.roomTag, {super.key});

  final String roomTag;

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
        const Row(children: [
          Avatar(radius: 30,),
          gapW16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("김아영", style: FigmaTextStyles.title26),
              Text("목자", style: FigmaTextStyles.content16)
            ],
          ),
        ],
        ),
        gapH20,
        const Row(children: [
          Avatar(radius: 30,),
          gapW16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("왕단비", style: FigmaTextStyles.title26),
              Text("부목자", style: FigmaTextStyles.content16)
            ],
          ),
        ],
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