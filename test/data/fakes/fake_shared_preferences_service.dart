import 'package:pragmatic_todo/data/services/shared_preferences_service.dart';

class FakeSharedPreferencesService implements SharedPreferencesService {
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
}
