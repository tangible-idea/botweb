import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());

class DatabaseService {
  final supabase = Supabase.instance.client;

  Future<String?> getGroupNameById(String id) async {
    try {
      final response = await supabase
          .from('group')
          .select('name')
          .eq('id', id)
          .single();

      return response['name'] as String?;
    } catch (error) {
      print('Error fetching group name: $error');
      return null;
    }
  }
}