import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/model/user/user.dart';

/// The key for userList data stored in SharedPreferences
const String _keyUserList = "USER_LIST_KEY";

/// A provider that exposes the UserRepository
final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (ref) => UserRepository(SharedPreferencesHelper.instance),
);

/// A repository of users exposing methods for adding,
/// retrieving, updating and deleting them
class UserRepository {
  UserRepository(this.sharedPrefHelper);
  final SharedPreferencesHelper sharedPrefHelper;

  /// Adds [user] to local storage
  Future<bool> addNewUser(User user) async {
    final userList = await getAllUsers();
    userList.add(user);
    return await _updateUserList(userList);
  }

  /// Updates [user] then saves to local storage
  Future<bool> updateUser(User user) async {
    List<User> userList = await getAllUsers();
    final index = userList.indexWhere((u) => (u.username == user.username));
    if (index.isNegative) {
      return false;
    } else {
      userList[index] = user;
      return await _updateUserList(userList);
    }
  }

  /// Gets the user of [username], returns null if not found
  Future<User?> getUser(String username) async {
    final List<User> userList = await getAllUsers();
    User? userOfInterest;
    for (var user in userList) {
      if (user.username == username) {
        userOfInterest = user;
      }
    }
    return userOfInterest;
  }

  /// Gets all the users stored in local storage
  Future<List<User>> getAllUsers() async {
    final jsonList = await sharedPrefHelper.getJsonList(_keyUserList);
    final List<User> userList = [];
    for (final json in jsonList) {
      try {
        userList.add(User.fromJson(json));
      } catch (e) {
        continue;
      }
    }
    return userList;
  }

  /// Updates the userList in localStorage with new [userList]
  Future<bool> _updateUserList(List<User> userList) async {
    List<Map<String, dynamic>> jsonList = [];
    for (final user in userList) {
      jsonList.add(user.toJson());
    }
    return await sharedPrefHelper.saveJsonList(_keyUserList, jsonList);
  }

  // TODO: deletUser(User user) method
}
