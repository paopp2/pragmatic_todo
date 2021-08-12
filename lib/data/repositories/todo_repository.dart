import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/core_providers/current_user_provider.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final todoRepositoryProvider = Provider.autoDispose<TodoRepository>(
  (ref) {
    return TodoRepository(
      currentUser: ref.watch(currentUserProvider),
      currentUserNotifier: ref.watch(currentUserProvider.notifier),
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);

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
      final updatedUser = currentUser!.copyWith(todos: currentTodos);
      userRepository.updateUser(updatedUser);
      currentUserNotifier.setNew(updatedUser);
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
      userRepository.updateUser(updatedUser);
      currentUserNotifier.setNew(updatedUser);
    }
  }
}
