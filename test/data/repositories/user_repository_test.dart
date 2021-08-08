import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/shared_preferences_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'user_repository_test.mocks.dart';

@GenerateMocks([SharedPreferencesService])
void main() {
  group('getUserList', () {
    test('Returns a list of users if completes successfully', () async {
      final mockSharedPrefService = MockSharedPreferencesService();
      final userRepository = UserRepository(mockSharedPrefService);
      when(mockSharedPrefService.getJsonList('USER_LIST_KEY'))
          .thenAnswer((_) async => [
                const User(username: 'username1', password: 'password1')
                    .toJson(),
                const User(username: 'username2', password: 'password2')
                    .toJson(),
              ]);
      expect(await userRepository.getUserList(), isA<List<User>>());
    });
  });
}
