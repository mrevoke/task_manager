import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/features/auth/presentation/controllers/auth_controller.dart';
import 'package:task_manager/src/features/task/presentation/controllers/task_controller.dart';

class TaskListScreen extends HookConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authControllerProvider).signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: tasksAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (tasks) {
            if (tasks.isEmpty) {
              return const Center(
                child: Text(
                  "📝 No tasks yet!\nTap + to add your first task.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.separated(
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: IconButton(
                      tooltip: "Delete Task",
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await ref
                            .read(taskControllerProvider)
                            .deleteTask(task.id);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-task'),
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
      ),
    );
  }
}
