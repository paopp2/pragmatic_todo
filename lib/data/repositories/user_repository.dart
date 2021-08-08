import 'package:pragmatic_todo/data/services/shared_preferences_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

const String keyUserList = "USER_LIST_KEY";

class UserRepository {
  UserRepository(this.sharedPrefServices);
  final SharedPreferencesService sharedPrefServices;

  Future<bool> addUserToUserList(User user) async {
    final userList = await getUserList();
    userList.add(user);
    return await saveUserList(userList);
  }

  Future<List<User>> getUserList() async {
    final jsonList = await sharedPrefServices.getJsonList(keyUserList);
    final List<User> userList = [];
    for (final json in jsonList) {
      userList.add(User.fromJson(json));
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
