import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/data/models/task_model.dart';
import 'package:task_manager/src/features/task/data/supabase_task_repository.dart';
import 'package:task_manager/src/features/task/data/task_repository.dart';
import 'package:task_manager/src/infra/supabase_provider.dart';


final taskRepoProvider = Provider<TaskRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return SupabaseTaskRepository(client);
});

final taskListProvider = FutureProvider<List<TaskModel>>((ref) {
  return ref.watch(taskRepoProvider).fetchTasks();
});

final taskControllerProvider = Provider<TaskController>((ref) {
  final repo = ref.watch(taskRepoProvider);
  return TaskController(ref, repo);
});

class TaskController {
  final Ref ref;
  final TaskRepository _repo;

  TaskController(this.ref, this._repo);

  Future<void> addTask(String title) async {
    await _repo.addTask(title);
    ref.invalidate(taskListProvider);
  }

  Future<void> deleteTask(String id) async {
    await _repo.deleteTask(id);
    ref.invalidate(taskListProvider);
  }
}
