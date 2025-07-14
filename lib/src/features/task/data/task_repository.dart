import '../../../data/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> fetchTasks();
  Future<void> addTask(String title);
  Future<void> deleteTask(String id);
}
