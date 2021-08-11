import 'package:pragmatic_todo/data/data_providers/current_user_provider.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class TodoRepository {
  TodoRepository({
    required this.currentUser,
    required this.userRepository,
    required this.currentUserNotifier,
  });
  final UserRepository userRepository;
  final User? currentUser;
  final CurrentUserNotifier currentUserNotifier;

  List<Todo> getTodos() => currentUser?.todos ?? [];

  void addTodo(Todo newTodo) {
    if (currentUser != null) {
      assert(currentUser != null);
      var currentTodos = currentUser!.todos;
      currentTodos.add(newTodo);
      currentUser!.copyWith(todos: currentTodos);
      currentUserNotifier.setNew(currentUser!);
    }
  }

  void toggleTodo(int index) {
    if (currentUser != null) {
      assert(currentUser != null);
      final currentTodos = currentUser!.todos;
      final Todo todoToToggle = currentTodos[index];
      final bool toggledStatus = !todoToToggle.isDone;
      final Todo toggledTodo = todoToToggle.copyWith(isDone: toggledStatus);
      currentTodos[index] = toggledTodo;
      final updatedUser = currentUser!.copyWith(todos: currentTodos);
      currentUserNotifier.setNew(updatedUser);
    }
  }
}
