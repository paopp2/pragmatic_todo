import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/repositories/todo_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';

final homeViewModelProvider = Provider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(
    todoRepository: ref.watch(todoRepositoryProvider),
    authService: ref.watch(authServiceProvider),
  ),
);

class HomeViewModel {
  HomeViewModel({
    required this.todoRepository,
    required this.authService,
  });
  final TodoRepository todoRepository;
  final AuthService authService;

  void initState() {}
  void dispose() {}

  List<Todo> getTodoList() => todoRepository.getTodos();
  void toggleTodo(int index) => todoRepository.toggleTodo(index);
  void createNewTodo() => AppRouter.instance.navigateToTodoView();
  void logOut() => authService.logout();
}
