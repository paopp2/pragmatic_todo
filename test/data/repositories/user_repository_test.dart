import 'package:pragmatic_todo/data/helpers/shared_preferences_helper.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/model/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fakes/fake_shared_preferences_helper.dart';

void main() {
  final _goodFakePrefsHelper = FakeSharedPreferencesHelper(isValid: true);
  final _badFakePrefsHelper = FakeSharedPreferencesHelper(isValid: false);

  group('addNewUser', () {
    const User testUser = User(username: "u", password: "p");
    group('Given SharedPreferencesHelper returns valid results, ', () {
      final userRepository = UserRepository(_goodFakePrefsHelper);
      test('the methods returns normally (no Exception)', () {
        expect(userRepository.addNewUser(testUser), isNot(Exception));
      });

      test('returns true', () async {
        expect(await userRepository.addNewUser(testUser), true);
      });
    });
    group('Given SharedPreferencesHelper returns invalid results, ', () {
      final userRepository = UserRepository(_badFakePrefsHelper);

      test('the method returns normally (no Exception)', () {
        expect(userRepository.addNewUser(testUser), isNot(Exception));
      });

      test('returns false', () async {
        expect(await userRepository.addNewUser(testUser), false);
      });
    });
  });

  group('getAllUsers: ', () {
    final userRepository = UserRepository(_goodFakePrefsHelper);

    group('Given SharedPreferencesHelper returns valid results, ', () {
      test('the method returns normally', () {
        expect(userRepository.getAllUsers, returnsNormally);
      });

      test('correct data is returned', () async {
        final userRepository = UserRepository(_goodFakePrefsHelper);
        expect(
          await userRepository.getAllUsers(),
          isA<List<User>>()
              .having((l) => l[0].username, "username", contains("paolo"))
              .having((l) => l[0].password, "password", contains("paolo")),
        );
      });
    });

    group('Given SharedPreferencesHelper returns invalid results,', () {
      final userRepository = UserRepository(_badFakePrefsHelper);

      test('the method returns normally', () async {
        expect(userRepository.getAllUsers, returnsNormally);
      });

      test('an empty list is returned', () async {
        expect(await userRepository.getAllUsers(),
            isA<List<User>>().having((l) => l, "empty", isEmpty));
      });
    });
  });
}
