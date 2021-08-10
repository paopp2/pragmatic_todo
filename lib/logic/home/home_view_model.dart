import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class HomeViewModel {
  HomeViewModel(this.ref);
  final WidgetRef ref;
  late AuthService _authService;

  void initState() {
    _authService = ref.read(authServiceProvider);
  }

  void createNewTodo() => AppRouter.instance.navigateToTodoView();

  List<Todo> getTodoList() {
    final currentUser = ref.watch(currentUserProvider).state;
    return (currentUser is Data) ? currentUser.todos : [];
  }

  void logOut() async {
    _authService.logout();
  }

  void dispose() {}
}
