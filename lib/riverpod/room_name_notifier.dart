import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/models/mygroup.dart';

import '../services/DatabaseService.dart';



final groupNameProvider = StateNotifierProvider.family<GroupNameNotifier, AsyncValue<GroupAndAnnounce?>, String>(
      (ref, id) => GroupNameNotifier(ref.read(databaseServiceProvider), id),
);

class GroupNameNotifier extends StateNotifier<AsyncValue<GroupAndAnnounce?>> {
  final DatabaseService _databaseService;
  final String _id;

  GroupNameNotifier(this._databaseService, this._id) : super(const AsyncValue.loading()) {
    _fetchGroupName();
  }

  Future<void> _fetchGroupName() async {
    state = const AsyncValue.loading();
    try {
      final result = await _databaseService.getGroupNameAndAnnounceById(_id);
      state = AsyncValue.data(result);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void refresh() {
    _fetchGroupName();
  }
}