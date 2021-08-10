import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/shared_preferences_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
    (ref) => UserRepository(SharedPreferencesService.instance));

final authStateProvider =
    StateNotifierProvider.autoDispose<AuthStateNotifier, User>(
        (ref) => AuthStateNotifier());

class AuthStateNotifier extends StateNotifier<User> {
  AuthStateNotifier() : super(const User.loggedOut());
  void logInAs(User user) => state = user;
  void logOut() => state = const User.loggedOut();
  void error(String? errorMsg) => state = User.error(errorMsg);
}
