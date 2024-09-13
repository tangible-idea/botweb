import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_sizes.dart';
import '../riverpod/distinct_sender_provider.dart';
import '../riverpod/message_providers.dart';
import '../styles/txt_style.dart';
import 'base_layout.dart';


// UI
class TargetMessageScreen extends ConsumerWidget {
  TargetMessageScreen(this.roomTag, {super.key});

  final String roomTag;

  final List<String> days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedDays = ref.watch(selectedDaysProvider);
    final timeValue = ref.watch(timeValueProvider);
    final messageText = ref.watch(messageTextProvider);
    final sendersText = ref.watch(sendersTextProvider);

    //try {
    final distinctSendersAsyncValue = ref.watch(distinctSendersProvider(roomTag));


    final supabase = Supabase.instance.client;
    Future<void> saveAnnouncement(WidgetRef ref) async {
      final selectedDays = ref.read(selectedDaysProvider);
      final timeValue = ref.read(timeValueProvider);
      final messageText = ref.read(messageTextProvider);
      final sendersText = ref.read(sendersTextProvider);

      // 선택된 요일 중 가장 빠른 날짜 계산
      final now = DateTime.now();
      final selectedDayIndex = selectedDays.indexWhere((selected) => selected);
      if (selectedDayIndex == -1) {
        // 요일이 선택되지 않았을 경우 에러 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('요일을 선택해주세요.')),
        );
        return;
      }

      // weekday : 요일
      int daysUntilTarget = ((selectedDayIndex+1) - now.weekday + 7) % 7;
      if (daysUntilTarget == 0 && (now.hour > timeValue.hour || (now.hour == timeValue.hour && now.minute > timeValue.minute))) {
        daysUntilTarget = 7;  // 이미 지난 시간이면 다음 주로
      }

      final targetDate = now.add(Duration(days: daysUntilTarget));
      const kstOffset = Duration(hours: 9); // KST는 UTC+9
      final targetTime = DateTime(
        targetDate.year,
        targetDate.month,
        targetDate.day,
        timeValue.hour,
        timeValue.minute,
      ).subtract(kstOffset);

      try {
        await supabase.from('target_announce').insert({
          'room_tag': roomTag,  // 실제 room_tag 값으로 교체 필요
          'message': messageText,
          'target_time': targetTime.toIso8601String(),
          'target_senders': sendersText.split(','),
          'sent': false,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('공지가 성공적으로 저장되었습니다.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')),
        );
      }
    }

    return BaseLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('미션 공지', style: FigmaTextStyles.title30,),
          gapH20,
          Wrap(
            spacing: 5,
            children: List.generate(7, (index) {
              return ChoiceChip(
                label: Text(days[index]),
                selected: selectedDays[index],
                onSelected: (_) {
                  ref.read(selectedDaysProvider.notifier).toggle(index);
                },
              );
            }),
          ),
          gapH20,

          Row(children: [
            Text(timeValue.format(context), style: FigmaTextStyles.title20),
            gapW12,
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: timeValue,
                );
                if (pickedTime != null && pickedTime != timeValue) {
                  ref.read(timeValueProvider.notifier).state = pickedTime;
                }
              },
              child: const Text('시간 선택'),
            ),
          ],),

          gapH20,

          distinctSendersAsyncValue.when(
            data: (senders) {
              return Wrap(
                spacing: 10,
                children: senders.map((sender) {
                  return ChoiceChip(
                    label: Text(sender.sender),
                    selected: sendersText.split(',').contains(sender.sender),
                    onSelected: (isSelected) {
                      final currentSenders = sendersText.split(',').where((s) => s.isNotEmpty).toList();
                      if (isSelected) {
                        currentSenders.add(sender.sender);
                      } else {
                        currentSenders.remove(sender.sender);
                      }
                      ref.read(sendersTextProvider.notifier).state = currentSenders.join(',');
                    },
                  );
                }).toList(),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => const Text('유저 목록을 불러오는 중 오류가 발생했습니다.'),
          ),

          gapH20,
          Expanded(
            child: TextField(
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '공지를 강조할 대상 목록 (콤마로 구분)',
              ),
              onChanged: (value) {
                ref.read(sendersTextProvider.notifier).state = value;
              },
              controller: TextEditingController(text: sendersText),
            ),
          ),
          Expanded(
            child: TextField(
              maxLines: 20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '메시지를 입력하세요...',
              ),
              onChanged: (value) {
                ref.read(messageTextProvider.notifier).state = value;
              },
            ),
          ),
          gapH20,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text('예약 저장'),
              onPressed: () async {
                await saveAnnouncement(ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}