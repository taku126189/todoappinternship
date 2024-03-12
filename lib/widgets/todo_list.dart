import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_internship/providers/user_todos.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    final userTodos = ref.watch(userTodosProvider);

    return ListView.builder(
      itemCount: userTodos.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(userTodos[index]),
        background: Container(
          color: Colors.red,
          child: const Center(
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        onDismissed: (_) {
          ref.read(userTodosProvider.notifier).removeTodo(userTodos[index]);
        },
        child: Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focused) {
            if (focused) {
              textEditingController.text = userTodos[index].title;
            } else {
              ref.read(userTodosProvider.notifier).editTodo(
                  id: userTodos[index].id, title: textEditingController.text);
            }
          },
          child: ListTile(
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            trailing: Checkbox(
                value: userTodos[index].completed,
                onChanged: (value) => ref
                    .read(userTodosProvider.notifier)
                    .toggleTodo(userTodos[index].id)),
            title: itemIsFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text(userTodos[index].title),
            subtitle: Text(userTodos[index].formattedDate.toString()),
          ),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
    () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );

  return isFocused.value;
}



// * Memo
// Flutter has a Focus Tree that manages the focus state of a widget. The tree mirrors Widget Tree and keeps track of which widget has focus
// Focusable widgets: Buttons, TextField, etc.
// Each focusable widget is associated with a FocusNode instance. FocusNode represents the focus state of a widget