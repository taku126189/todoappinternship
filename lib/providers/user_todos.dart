import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_internship/models/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

// ? Can this be replaced with Notifier?
class UserTodosNotifier extends StateNotifier<List<Todo>> {
  UserTodosNotifier() : super(const []);

  void addTodo(String title, DateTime date) {
    final newTodo = Todo(
      title: title,
      date: date,
      id: _uuid.v4(),
    );
    state = [newTodo, ...state];
  }

  void removeTodo(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            title: todo.title,
            date: todo.date,
            id: todo.id,
            completed: !todo.completed,
          )
        else
          todo,
    ];
  }

  void editTodo({required String id, required String title}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            title: title,
            date: todo.date,
            id: todo.id,
          )
        else
          todo,
    ];
  }
}

final userTodosProvider = StateNotifierProvider<UserTodosNotifier, List<Todo>>(
  (ref) => UserTodosNotifier(),
);
