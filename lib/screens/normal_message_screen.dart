import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_sizes.dart';
import '../riverpod/message_providers.dart';
import '../styles/txt_style.dart';

// Providers
final selectedDaysProvider = StateNotifierProvider<SelectedDaysNotifier, List<bool>>((ref) {
  return SelectedDaysNotifier();
});

final messageTypeProvider = StateProvider<String>((ref) => '나눠서');

final messageTextProvider = StateProvider<String>((ref) => '');

class SelectedDaysNotifier extends StateNotifier<List<bool>> {
  SelectedDaysNotifier() : super(List.generate(7, (_) => false));

  void toggle(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) !state[i] else state[i]
    ];
  }
}

// UI
class NormalMessageScreen extends ConsumerWidget {
  NormalMessageScreen(this.roomTag, {super.key});

  final String roomTag;

  final List<String> days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDays = ref.watch(selectedDaysProvider);
    final timeValue = ref.watch(timeValueProvider);
    final messageType = ref.watch(messageTypeProvider);
    final messageText = ref.watch(messageTextProvider);

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
        await supabase.from('announce').insert({
          'room_tag': roomTag,  // 실제 room_tag 값으로 교체 필요
          'message': messageText,
          'target_time': targetTime.toIso8601String(),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('일반 공지', style: FigmaTextStyles.title30,),
        gapH20,
        //const Text('[요일]', style: FigmaTextStyles.title20),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
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
        //const Text('[분할]', style: FigmaTextStyles.title20),
        DropdownButton<String>(
          value: messageType,
          items: ['나눠서', '한꺼번에'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            ref.read(messageTypeProvider.notifier).state = newValue!;
          },
        ),
        gapH20,
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
            child: const Text('방에서 기도제목 불러오기'),
            onPressed: () {

            },
          ),
        ),
        gapH4,
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
    );
  }

  String _formatTime(double minutes) {
    int hours = (minutes ~/ 60) % 24;
    int mins = (minutes % 60).toInt();
    return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
  }


}