import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_internship/providers/user_todos.dart';
import 'package:todo_app_internship/widgets/todo_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();

    void addItem() {
      final enteredText = textEditingController.text;

      if (enteredText.trim().isEmpty) {
        return;
      }

      ref.read(userTodosProvider.notifier).addTodo(
            enteredText,
            DateTime.now(),
          );

      textEditingController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: addItem,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}
