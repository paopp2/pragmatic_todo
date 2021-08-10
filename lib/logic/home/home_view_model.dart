import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';

class HomeViewModel {
  HomeViewModel(this.read);
  final Reader read;

  void logOut() async {
    read(authStateProvider.notifier).logOut();
  }
}
