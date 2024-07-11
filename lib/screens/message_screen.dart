import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_sizes.dart';
import '../styles/txt_style.dart';

// Providers
final selectedDaysProvider = StateNotifierProvider<SelectedDaysNotifier, List<bool>>((ref) {
  return SelectedDaysNotifier();
});

final timeValueProvider = StateProvider<double>((ref) => 12 * 60 + 20); // 12:20 PM in minutes

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
class MessageScreen extends ConsumerWidget {
  MessageScreen({Key? key}) : super(key: key);

  final List<String> days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDays = ref.watch(selectedDaysProvider);
    final timeValue = ref.watch(timeValueProvider);
    final messageType = ref.watch(messageTypeProvider);
    final messageText = ref.watch(messageTextProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('공지 메시지', style: FigmaTextStyles.title30,),
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
        //const Text('[시간]', style: FigmaTextStyles.title20),
        //gapH8,
        Text(_formatTime(timeValue), style: FigmaTextStyles.title20),
        Slider(
          value: timeValue,
          min: 0,
          max: 24 * 60 - 1,
          onChanged: (value) {
            ref.read(timeValueProvider.notifier).state = value;
          },
        ),
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
            onPressed: () {
              // Handle next button press
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