

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/riverpod/distinct_sender_provider.dart';

import '../../constants/app_sizes.dart';
import '../../styles/txt_style.dart';
import '../../widgets/avatar.dart';
import '../homepage.dart';

class PersonRow extends ConsumerWidget {
  final SenderModel person;

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
                        //Spacer(),a
                        // TODO : ranking icons
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