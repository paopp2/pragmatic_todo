import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/db_helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/model/user/user.dart';

const keyCurrentUser = "CURRENT_USER_KEY";

class AuthService {
  AuthService(this.read);
  final Reader read;

  static Future<String?> getCurrentUser() async {
    final prefs = SharedPreferencesHelper.instance;
    return await prefs.getRawString(keyCurrentUser);
  }

  void loginAs(User? user) {
    if (user is User) {
      final prefs = SharedPreferencesHelper.instance;
      prefs.saveRawString(keyCurrentUser, user.username);
      read(currentUserProvider).state = user;
    }
  }

  void logout() {
    final prefs = SharedPreferencesHelper.instance;
    prefs.delete(keyCurrentUser);
    read(currentUserProvider).state = null;
  }
}
