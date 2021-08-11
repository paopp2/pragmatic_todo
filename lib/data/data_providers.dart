import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/repositories/todo_repository.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

import 'helpers/shared_preferences_helper.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (ref) => UserRepository(SharedPreferencesHelper.instance),
);

final todoRepositoryProvider = Provider.autoDispose<TodoRepository>(
  (ref) {
    return TodoRepository(
      currentUser: ref.watch(currentUserProvider).state,
      read: ref.read,
    );
  },
);

final authServiceProvider =
    Provider.autoDispose<AuthService>((ref) => AuthService(ref.read));

final currentUserProvider = StateProvider.autoDispose<User?>((ref) => null);
