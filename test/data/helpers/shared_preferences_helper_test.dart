import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_shared_preferences_data.dart';

void main() {
  final prefsHelper = SharedPreferencesHelper.instance;
  group('getJsonList:', () {
    group('Given SharedPrefs has data', () {
      SharedPreferences.setMockInitialValues(goodPrefsJsonList);

      test("method doesn't throw an exception", () async {
        expect(await prefsHelper.getJsonList("key"), isNot(Exception));
      });

      test('returns the correct JSON data when key exists', () async {
        final userList = jsonDecode(goodPrefsJsonList["users"] as String);
        expect(
          await prefsHelper.getJsonList("users"),
          isA<List<Map<String, dynamic>>>()
              .having((l) => l.length, "List length", userList?.length)
              .having((l) => l[0]["username"], "1st username", "userA")
              .having((l) => l[0]["password"], "1st username", "passA")
              .having((l) => l[1]["username"], "2nd username", "userB")
              .having((l) => l[1]["password"], "2nd username", "passB"),
        );
      });

      test("returns empty list when key doesn't exist", () async {
        expect(await prefsHelper.getJsonList("nonexistent"), isEmpty);
      });
    });
  });

  group('saveJsonList:', () {
    test("method doesn't throw an exception", () async {
      expect(await prefsHelper.saveJsonList("key", []), isNot(Exception));
    });

    test("returns true if data saved successfully", () async {
      expect(
        await prefsHelper.saveJsonList("users", goodTestJsonUserList),
        true,
      );
    });
  });

  group("getRawString:", () {
    test("method doesn't throw an exception", () async {
      expect(await prefsHelper.getRawString("rand_key"), isNot(Exception));
    });

    test("returns correct RawStringData if key exists", () async {
      SharedPreferences.setMockInitialValues(goodPrefsRawString);
      expect(
        await prefsHelper.getRawString(goodPrefsRawString.keys.first),
        isA<String>().having((s) => s, "data", goodPrefsRawString.values.first),
      );
    });

    test("returns null if key doesn't exist", () async {
      expect(await prefsHelper.getRawString("nonexistent"), null);
    });
  });

  group("saveRawString:", () {
    test("method doesn't throw an exception", () async {
      expect(await prefsHelper.saveRawString("rand_key", "rand_data"),
          isNot(Exception));
    });

    test("returns true if data saved successfully", () async {
      expect(await prefsHelper.saveRawString("rand_key", "rand_data"), true);
    });
  });

  group("delete:", () {
    test("method doesn't throw an exception", () async {
      expect(await prefsHelper.delete("rand_key"), isNot(Exception));
    });

    test("returns true if key exists", () async {
      SharedPreferences.setMockInitialValues(goodPrefsJsonList);
      expect(await prefsHelper.delete("users"), true);
    });
  });
}
