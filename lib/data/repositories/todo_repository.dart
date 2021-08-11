import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class TodoRepository {
  TodoRepository({this.currentUser, required this.read});
  final Reader read;
  final User? currentUser;

  List<Todo> getTodos() => currentUser?.todos ?? [];

  void addTodo(Todo newTodo) {
    if (currentUser != null) {
      assert(currentUser != null);
      var currentTodos = currentUser!.todos;
      currentTodos.add(newTodo);
      currentUser!.copyWith(todos: currentTodos);
      read(currentUserProvider).state = currentUser;
    }
  }

  void toggleTodo(int index) {
    if (currentUser != null) {
      assert(currentUser != null);
      var currentTodos = currentUser!.todos;
      final Todo todoToToggle = currentTodos[index];
      final bool toggledStatus = !todoToToggle.isDone;
      final Todo toggledTodo = todoToToggle.copyWith(isDone: toggledStatus);
      currentTodos[index] = toggledTodo;
      currentUser!.copyWith(todos: currentTodos);
      read(currentUserProvider).state = currentUser;
    }
  }
}
