import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/model/user/user.dart';

const keyCurrentUser = "CURRENT_USER_KEY";

class AuthService extends StateNotifier<User> {
  AuthService() : super(const User.loggedOut());

  void logInAs(User user) => state = user;
  void logOut() => state = const User.loggedOut();
  void error(String? errorMsg) => state = User.error(errorMsg);
}
