import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';

class HomeViewModel {
  HomeViewModel(this.read);
  final Reader read;
  late AuthService _authService;

  void initState() {
    _authService = read(authServiceProvider);
  }

  void logOut() async {
    _authService.logout();
  }

  void dispose() {}
}
