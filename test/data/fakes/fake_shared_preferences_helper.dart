import 'package:flutter_test/flutter_test.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';

class FakeSharedPreferencesHelper implements SharedPreferencesHelper {
  FakeSharedPreferencesHelper({required this.isValid});
  final bool isValid;

  @override
  Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    return await _delay().then((value) {
      return (isValid) ? goodTestJsonUserList : badTestUserJsonList;
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

const List<Map<String, dynamic>> goodTestJsonUserList = [
  {
    "username": "userA",
    "password": "passA",
    "todos": [
      {"title": "titleAA", "content": "contentAA", "isDone": true},
      {"title": "titleAB", "content": "contentAB", "isDone": true}
    ]
  },
  {
    "username": "userB",
    "password": "passB",
    "todos": [
      {"title": "titleBA", "content": "contentBA", "isDone": false},
      {"title": "titleBB", "content": "contentBB", "isDone": false}
    ]
  },
];

const List<Map<String, dynamic>> badTestUserJsonList = [
  {
    "Data": "That",
    "Can't": "Be Parsed",
    "Okay?": true,
  }
];
