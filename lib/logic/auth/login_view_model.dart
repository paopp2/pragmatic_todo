import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers/repository_providers.dart';
import 'package:pragmatic_todo/data/data_providers/service_providers.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final loginViewModelProvider = Provider.autoDispose(
  (ref) => LoginViewModel(
    authService: ref.watch(authServiceProvider),
    userRepository: ref.watch(userRepositoryProvider),
  ),
);

class LoginViewModel {
  LoginViewModel({required this.userRepository, required this.authService});
  final UserRepository userRepository;
  final AuthService authService;
  final loginFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  User? _userQuery;

  void initState() {}

  void gotoRegisterScreen() => AppRouter.instance.navigateToRegisterView();

  Future<void> attemptLogin() async {
    _userQuery = await userRepository.getUser(tecUsername.text);
    assert(loginFormKey.currentState != null);
    if (loginFormKey.currentState!.validate()) {
      authService.loginAs(_userQuery);
    }
  }

  String? loginUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? tmpUser = _userQuery;
      return (tmpUser == null) ? "This user doesn't exist" : null;
    }
  }

  String? loginPasswordValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? tmpUser = _userQuery;
      return (tmpUser != null && tmpUser.password != value)
          ? "Incorrect password"
          : null;
    }
  }

  void dispose() {
    tecUsername.dispose();
  }
}
