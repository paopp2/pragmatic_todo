import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class LoginViewModel {
  LoginViewModel(this.read);
  final Reader read;
  final loginFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  late UserRepository _userRepository;
  late User _userQuery;
  late AuthService _authService;

  void initState() {
    _userQuery = const User.error("Not yet used");
    _userRepository = read(userRepositoryProvider);
    _authService = read(authServiceProvider);
  }

  void gotoRegisterScreen() => AppRouter.instance.navigateToRegisterView();

  Future<void> attemptLogin() async {
    _userQuery = await _userRepository.getUser(tecUsername.text);
    final returnedUser = _userQuery;
    if (loginFormKey.currentState!.validate()) {
      returnedUser.mapOrNull(
        (user) => _authService.loginAs(user),
      );
    }
  }

  String? loginUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? tmpUser = _userQuery;
      return (tmpUser is Error) ? tmpUser.errorMsg : null;
    }
  }

  String? loginPasswordValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? tmpUser = _userQuery;
      if (tmpUser is Data) {
        if (tmpUser.password != value) return "Incorrect password";
      }
    }
  }

  void dispose() {
    tecUsername.dispose();
  }
}
