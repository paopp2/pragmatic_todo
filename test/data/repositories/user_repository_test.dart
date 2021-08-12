import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/model/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fakes/fake_shared_preferences_helper.dart';

void main() {
  final _goodFakePrefsHelper = FakeSharedPreferencesHelper(isValid: true);
  final _badFakePrefsHelper = FakeSharedPreferencesHelper(isValid: false);

  group('addNewUser:', () {
    const User testUser = User(username: "u", password: "p");
    group('Given SharedPreferencesHelper returns valid results,', () {
      final userRepository = UserRepository(_goodFakePrefsHelper);
      test('the methods returns normally (no Exception)', () {
        expect(userRepository.addNewUser(testUser), isNot(Exception));
      });

      test('returns true', () async {
        expect(await userRepository.addNewUser(testUser), true);
      });
    });
    group('Given SharedPreferencesHelper returns invalid results,', () {
      final userRepository = UserRepository(_badFakePrefsHelper);

      test('the method returns normally (no Exception)', () {
        expect(userRepository.addNewUser(testUser), isNot(Exception));
      });

      test('returns false', () async {
        expect(await userRepository.addNewUser(testUser), false);
      });
    });
  });

  group('updateUser:', () {
    const User testUser = User(username: "u", password: "p");
    group('Given SharedPreferencesHelper returns valid results,', () {
      final userRepository = UserRepository(_goodFakePrefsHelper);
      test('the methods returns normally (no Exception)', () {
        expect(userRepository.updateUser(testUser), isNot(Exception));
      });

      test('returns false if user is not found', () async {
        expect(await userRepository.updateUser(testUser), false);
      });

      final existingUser = User.fromJson(goodTestJsonUserList[0]);

      test('returns true if user is found and updated', () async {
        expect(await userRepository.updateUser(existingUser), true);
      });
    });
    group('Given SharedPreferencesHelper returns invalid results,', () {
      final userRepository = UserRepository(_badFakePrefsHelper);

      test('the method returns normally (no Exception)', () {
        expect(userRepository.updateUser(testUser), isNot(Exception));
      });

      test('returns false', () async {
        expect(await userRepository.updateUser(testUser), false);
      });
    });
  });

  group('getUser:', () {
    group('Given SharedPreferencesHelper returns valid results,', () {
      final userRepository = UserRepository(_goodFakePrefsHelper);
      test('the methods returns normally', () {
        expect(userRepository.getUser("someuser"), isNot(Exception));
      });

      test('returns correct data when user exists', () async {
        final userA = User.fromJson(goodTestJsonUserList[0]);
        final userB = User.fromJson(goodTestJsonUserList[1]);
        expect(await userRepository.getUser("userA"), userA);
        expect(await userRepository.getUser("userB"), userB);
      });

      test('returns null when user doesn\'t exist', () async {
        expect(await userRepository.getUser("nonexistent"), null);
      });
    });

    group('Given SharedPreferencesHelper returns invalid results,', () {
      final userRepository = UserRepository(_badFakePrefsHelper);

      test('the method returns normally (no Exception)', () {
        expect(userRepository.getUser("nonexistent"), isNot(Exception));
      });

      test('returns null', () async {
        expect(await userRepository.getUser("random"), null);
      });
    });
  });

  group('getAllUsers:', () {
    final userRepository = UserRepository(_goodFakePrefsHelper);

    group('Given SharedPreferencesHelper returns valid results,', () {
      test('the method returns normally', () {
        expect(userRepository.getAllUsers, returnsNormally);
      });

      test('returned list has the expected length', () async {
        final userList = await userRepository.getAllUsers();
        expect(userList.length, goodTestJsonUserList.length);
      });

      test('returned list contains the expected data', () async {
        expect(
          await userRepository.getAllUsers(),
          isA<List<User>>()
              .having((l) => l[0].username, "username", contains("userA"))
              .having((l) => l[0].password, "password", contains("passA"))
              .having((l) => l[1].username, "username", contains("userB"))
              .having((l) => l[1].password, "password", contains("passB")),
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
