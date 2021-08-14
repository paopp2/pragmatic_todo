import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:pragmatic_todo/data/core_providers/current_user_provider.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class Listener extends Mock {
  void call(User? user);
}

void main() {
  group('currentUseProvider: ', () {
    test(
      "currentUserProvider listeners are listening with a default value of null",
      () {
        final container = ProviderContainer();
        final listener = Listener();
        listener(container.read(currentUserProvider));
        verify(listener(null)).called(1);
        addTearDown(container.dispose);
      },
    );

    group("updating currentUserProvider:", () {
      const testUser = User(username: "u", password: "p");
      test(
        "From null to User",
        () {
          final container = ProviderContainer();
          final listener = Listener();
          container.listen(currentUserProvider, (User? user) => listener(user));
          verifyNever(listener(null));
          container.read(currentUserProvider.notifier).setNew(testUser);
          verify(listener(testUser)).called(1);
          addTearDown(container.dispose);
        },
      );

      test("From user to null", () {
        final container = ProviderContainer(overrides: [
          currentUserProvider.overrideWithValue(CurrentUserNotifier(testUser)),
        ]);
        final listener = Listener();
        container.listen(currentUserProvider, (User? user) => listener(user));
        verifyNever(listener(testUser));
        container.read(currentUserProvider.notifier).remove();
        verify(listener(null)).called(1);
      });
    });
  });
}
