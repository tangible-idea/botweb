// Providers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final selectedDaysProvider = StateNotifierProvider<SelectedDaysNotifier, List<bool>>((ref) {
  return SelectedDaysNotifier();
});

final timeValueProvider = StateProvider<TimeOfDay>((ref) {
  final now = DateTime.now().add(const Duration(minutes: 30));
  return TimeOfDay(hour: now.hour, minute: now.minute);
});

final messageTextProvider = StateProvider<String>((ref) => '');

final sendersTextProvider = StateProvider<String>((ref) => '');


class SelectedDaysNotifier extends StateNotifier<List<bool>> {
  SelectedDaysNotifier() : super(List.generate(7, (_) => false));

  void toggle(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) !state[i] else state[i]
    ];
  }
}
