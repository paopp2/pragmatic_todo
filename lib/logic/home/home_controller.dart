import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class HomeController {
  HomeController(this.read);
  final Reader read;

  void logOut() async {
    read(currentUserProvider).state = const User.loggedOut();
  }
}
