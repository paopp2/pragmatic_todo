import 'package:pragmatic_todo/data/services/shared_preferences_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

const String keyUserList = "USER_LIST_KEY";

class UserRepository {
  UserRepository(this.sharedPrefServices);
  final SharedPreferencesService sharedPrefServices;

  Future<User> getUser(String username) async {
    final List<User> userList = await getUserList();
    User? userOfInterest;
    for (final user in userList) {
      if ((user is Data) && (user.username == username)) {
        userOfInterest = user;
      }
    }
    return userOfInterest ?? const User.error("This username doesn't exist");
  }

  Future<bool> addUserToUserList(User user) async {
    final userList = await getUserList();
    userList.add(user);
    return await saveUserList(userList);
  }

  Future<List<User>> getUserList() async {
    final jsonList = await sharedPrefServices.getJsonList(keyUserList);
    final List<User> userList = [];
    for (final json in jsonList) {
      try {
        userList.add(User.fromJson(json));
      } catch (e) {
        throw ("Implement a proper catch for this Error: ${e.toString()}");
      }
    }
    return userList;
  }

  Future<bool> saveUserList(List<User> userList) async {
    List<Map<String, dynamic>> jsonList = [];
    for (final user in userList) {
      jsonList.add(user.toJson());
    }
    return await sharedPrefServices.saveJsonList(keyUserList, jsonList);
  }
}
