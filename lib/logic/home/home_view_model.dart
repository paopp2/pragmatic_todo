import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final homeViewModelProvider = Provider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(
    currentUser: ref.watch(currentUserProvider).state,
    authService: ref.read(authServiceProvider),
  ),
);

class HomeViewModel {
  HomeViewModel({
    this.currentUser,
    required this.authService,
  });
  final User? currentUser;
  final AuthService authService;

  void initState() {}
  void dispose() {}

  List<Todo> getTodoList() {
    List<Todo> todos;
    todos = currentUser?.todos ?? [];
    return todos;
  }

  void createNewTodo() => AppRouter.instance.navigateToTodoView();
  void logOut() async => authService.logout();
}
