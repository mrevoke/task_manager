import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager/src/constants/table_names.dart';
import '../../../data/models/task_model.dart';
import 'task_repository.dart';

class SupabaseTaskRepository implements TaskRepository {
  final SupabaseClient client;

  SupabaseTaskRepository(this.client);

  @override
  Future<List<TaskModel>> fetchTasks() async {
    final userId = client.auth.currentUser?.id;
    final response = await client
        .from(TableNames.tasks)
        .select()
        .eq('user_id', userId!)
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addTask(String title) async {
    final userId = client.auth.currentUser?.id;
    await client.from(TableNames.tasks).insert({
      'title': title,
      'user_id': userId,
    });
  }

  @override
  Future<void> deleteTask(String id) async {
    await client.from(TableNames.tasks).delete().eq('id', id);
  }
}
