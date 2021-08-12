import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('getJsonList', () {
    test(
      "Returns empty list when key doesn't exist",
      () async {
        final sharedPrefService = SharedPreferencesHelper.instance;
        SharedPreferences.setMockInitialValues({});
        final jsonList =
            await sharedPrefService.getJsonList("NON_EXISTENT_KEY");
        expect(jsonList, []);
      },
    );

    test(
      "Returns the appropriate jsonData",
      () async {
        final sharedPrefService = SharedPreferencesHelper.instance;
        final sharedPref = await SharedPreferences.getInstance();
        List<Map<String, dynamic>> data = [
          {"KA1": "VA1", "KA2": "VA2"},
          {"KB1": "VB1", "KB2": "VB2"},
        ];
        await sharedPref.setString("key", jsonEncode(data));
        final jsonList = await sharedPrefService.getJsonList("key");
        expect(jsonList, data);
      },
    );
  });
}
