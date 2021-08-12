import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final currentUserProvider =
    StateNotifierProvider.autoDispose<CurrentUserNotifier, User?>(
        (ref) => CurrentUserNotifier(null));

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier(this.currentUser) : super(currentUser);
  final User? currentUser;
  void setNew(User user) => state = user;
  void remove() => state = null;
}
