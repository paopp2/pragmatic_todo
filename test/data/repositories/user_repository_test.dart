import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/model/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import '../fakes/fake_shared_preferences_service.dart';

void main() {
  group('getUserList', () {
    test('Returns a list of users if completes successfully', () async {
      final fakeSharedPreferencesService = FakeSharedPreferencesService();
      final userRepository = UserRepository(fakeSharedPreferencesService);
      expect(await userRepository.getUserList(), isA<List<User>>());
    });
  });
}
