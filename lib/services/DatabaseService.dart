import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/mygroup.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());

class DatabaseService {
  final supabase = Supabase.instance.client;

  Future<GroupAndAnnounce?> getGroupNameAndAnnounceById(String id) async {
    try {
      final response = await supabase
          .from('group')
          .select('name, announce')
          .eq('id', id)
          .single();

      // Return an instance of GroupAndAnnounce
      return GroupAndAnnounce.fromMap(response);
    } catch (error) {
      print('Error fetching group data: $error');
      return null;
    }
  }
}