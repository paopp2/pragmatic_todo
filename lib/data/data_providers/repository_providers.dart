import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers/current_user_provider.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/data/repositories/todo_repository.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (ref) => UserRepository(SharedPreferencesHelper.instance),
);

final todoRepositoryProvider = Provider.autoDispose<TodoRepository>(
  (ref) {
    return TodoRepository(
      currentUser: ref.watch(currentUserProvider),
      currentUserNotifier: ref.watch(currentUserProvider.notifier),
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);
