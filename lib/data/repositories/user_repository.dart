import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/model/user/user.dart';

const String keyUserList = "USER_LIST_KEY";

class UserRepository {
  UserRepository(this.sharedPrefHelper);
  final SharedPreferencesHelper sharedPrefHelper;

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

  Future<bool> addNewUser(User user) async {
    final userList = await getAllUsers();
    userList.add(user);
    return await _updateUserList(userList);
  }

  Future<List<User>> getAllUsers() async {
    final jsonList = await sharedPrefHelper.getJsonList(keyUserList);
    final List<User> userList = [];
    for (final json in jsonList) {
      try {
        userList.add(User.fromJson(json));
      } catch (e) {
        // TODO: Implement a proper catch for this Error
        throw ("Implement a proper catch for this Error: ${e.toString()}");
      }
    }
    return userList;
  }

  Future<bool> _updateUserList(List<User> userList) async {
    List<Map<String, dynamic>> jsonList = [];
    for (final user in userList) {
      jsonList.add(user.toJson());
    }
    return await sharedPrefHelper.saveJsonList(keyUserList, jsonList);
  }
}
