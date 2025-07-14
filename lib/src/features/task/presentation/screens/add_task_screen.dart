import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/features/task/presentation/controllers/task_controller.dart';

class AddTaskScreen extends HookConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isLoading = useState(false);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: Card(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "What's on your mind?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        if (controller.text.trim().isEmpty) {
                          messenger.showSnackBar(
                            const SnackBar(content: Text("Please enter a task title.")),
                          );
                          return;
                        }

                        isLoading.value = true;
                        try {
                          await ref
                              .read(taskControllerProvider)
                              .addTask(controller.text.trim());

                          navigator.pop();
                        } catch (e) {
                          messenger.showSnackBar(SnackBar(content: Text(e.toString())));
                        } finally {
                          isLoading.value = false;
                        }
                      },
                      child: isLoading.value
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Add Task'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
      ),
    );
  }
}
