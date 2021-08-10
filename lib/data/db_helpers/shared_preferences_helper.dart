import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();
  static final instance = SharedPreferencesHelper._();

  Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return List<Map<String, dynamic>>.from(
        jsonDecode(prefs.getString(key) ?? '[]'));
  }

  Future<bool> saveJsonList(String key, List<Map<String, dynamic>> json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, jsonEncode(json));
  }

  Future<String?> getRawString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> saveRawString(String key, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, data);
  }
}
