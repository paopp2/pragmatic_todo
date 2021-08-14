import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/model/user/user.dart';

/// Exposes the currentUser to the app
final currentUserProvider =
    StateNotifierProvider.autoDispose<CurrentUserNotifier, User?>(
        (ref) => CurrentUserNotifier(null));

/// Controls the currentUserProvider
class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier(this.currentUser) : super(currentUser);
  final User? currentUser;

  /// Set a new [user]
  void setNew(User user) => state = user;

  /// Remove the currentUser
  void remove() => state = null;
}
