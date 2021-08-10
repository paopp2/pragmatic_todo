import 'package:pragmatic_todo/data/db_helpers/shared_preferences_helper.dart';

class FakeSharedPreferencesService implements SharedPreferencesHelper {
  @override
  Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    await Future.delayed(const Duration(microseconds: 5));
    return [
      {
        "username": "Username1",
        "password": "Username2",
      },
      {
        "username": "Username1",
        "password": "Username2",
      },
    ];
  }

  @override
  Future<bool> saveJsonList(String key, List<Map<String, dynamic>> json) async {
    await Future.delayed(const Duration(microseconds: 5));
    return true;
  }

  @override
  Future<String?> getRawString(String key) {
    // TODO: implement getRawString
    throw UnimplementedError();
  }

  @override
  Future<bool> saveRawString(String key, String data) {
    // TODO: implement saveRawString
    throw UnimplementedError();
  }
}
