import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();
  static final instance = SharedPreferencesService._();

  Future<List<Map<String, dynamic>>> getJsonList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return List<Map<String, dynamic>>.from(
        jsonDecode(prefs.getString(key) ?? '[]'));
  }

  Future<bool> saveJsonList(String key, List<Map<String, dynamic>> json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, jsonEncode(json));
  }

  Future<Map<String, dynamic>> getJson(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString(key);
    return (rawJson != null) ? jsonDecode(rawJson) : {};
  }

  Future<bool> saveJson(String key, Map<String, dynamic> json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, jsonEncode(json));
  }
}
