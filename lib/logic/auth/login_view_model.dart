import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class LoginViewModel {
  LoginViewModel(this.read);
  final Reader read;
  final loginFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  late User _userQuery;

  void initState() {}

  void gotoRegisterScreen() => AppRouter.instance.navigateToRegisterScreen();

  Future<void> attemptLogin() async {
    _userQuery = await read(userRepositoryProvider).getUser(tecUsername.text);
    final returnedUser = _userQuery;
    if (loginFormKey.currentState!.validate()) {
      returnedUser.mapOrNull(
        (user) => read(authStateProvider.notifier).logInAs(user),
      );
    }
  }

  String? loginUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? userCheck = _userQuery;
      final usernameValidation = userCheck?.whenOrNull(
        null,
        error: (errorMsg) => errorMsg,
      );
      return usernameValidation;
    }
  }

  String? loginPasswordValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? userCheck = _userQuery;
      final passwordValidation = userCheck?.whenOrNull(
        (_, password) => (password != value) ? "Incorrect password" : null,
      );
      return passwordValidation;
    }
  }

  void dispose() {
    tecUsername.dispose();
  }
}
