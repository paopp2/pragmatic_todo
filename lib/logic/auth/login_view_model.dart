import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/logic/auth/auth_providers.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class LoginViewModel {
  LoginViewModel(this.read);
  final Reader read;
  final loginFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();

  void initState() {}

  void gotoRegisterScreen() => AppRouter.instance.navigateToRegisterScreen();

  Future<void> attemptLogin() async {
    read(tempUserProvider).state =
        await read(userRepositoryProvider).getUser(tecUsername.text);
    final someUser = read(tempUserProvider).state;
    if (loginFormKey.currentState!.validate()) {
      read(currentUserProvider).state =
          someUser ?? const User.error("Error logging in");
    }
  }

  String? loginUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? userCheck = read(tempUserProvider).state;
      final usernameValidation = userCheck?.whenOrNull(
        null,
        error: (String? errorMsg) => errorMsg,
      );
      return usernameValidation;
    }
  }

  String? loginPasswordValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? userCheck = read(tempUserProvider).state;
      final passwordValidation = userCheck?.whenOrNull(
        (_, password) => (password != value) ? "Incorrect password" : null,
        error: (String? errorMsg) => "",
      );
      return passwordValidation;
    }
  }

  void dispose() {
    tecUsername.dispose();
  }
}
