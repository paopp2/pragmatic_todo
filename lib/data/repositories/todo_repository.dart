import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class TodoRepository {
  TodoRepository(this.read);
  final Reader read;

  List<Todo> getTodoList() {
    final User currentUser = read(currentUserProvider).state;
    return (currentUser is Data) ? currentUser.todos : [];
  }

  void addTodo(Todo newTodo) {
    final User currentUser = read(currentUserProvider).state;
    if (currentUser is Data) {
      var currentTodos = currentUser.todos;
      currentTodos.add(newTodo);
      currentUser.copyWith(todos: currentTodos);
      read(currentUserProvider).state = currentUser;
    }
  }
}
