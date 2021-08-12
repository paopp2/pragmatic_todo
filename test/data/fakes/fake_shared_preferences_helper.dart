import 'package:flutter_test/flutter_test.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';

class FakeSharedPreferencesHelper implements SharedPreferencesHelper {
  FakeSharedPreferencesHelper({required this.isValid});
  final bool isValid;

  @override
  Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    return await _delay().then((value) {
      if (isValid) {
        return [
          {
            "username": "paolo",
            "password": "paolo",
            "todos": [
              {"title": "Trial 1", "content": "Content 1", "isDone": true},
              {"title": "Trial 2", "content": "Content 2", "isDone": true}
            ]
          },
          {
            "username": "apollo",
            "password": "apollo",
            "todos": [
              {"title": "Apollo 1", "content": "Content A", "isDone": true},
              {"title": "Apollo 2", "content": "Content B", "isDone": true}
            ]
          },
          {"username": "nika", "password": "nika", "todos": []}
        ];
      } else {
        return [
          {
            "Data": "That",
            "Can't": "Be Parsed",
            "Okay?": true,
          }
        ];
      }
    });
  }

  @override
  Future<bool> saveJsonList(
    String key,
    List<Map<String, dynamic>> json,
  ) async =>
      await _delay().then((_) => isValid);

  @override
  Future<String?> getRawString(String key) async =>
      await _delay().then((_) => (isValid) ? "A valid raw string" : null);

  @override
  Future<bool> saveRawString(String key, String data) async =>
      await _delay().then((_) => isValid);

  @override
  Future<bool> delete(String key) async => await _delay().then((_) => isValid);

  Future<void> _delay() async =>
      await Future.delayed(const Duration(microseconds: 5));
}
