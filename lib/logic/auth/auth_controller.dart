import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/logic/auth/auth_providers.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class AuthController {
  AuthController(this.read);
  final Reader read;
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  var tecUsername = TextEditingController();
  var tecPassword = TextEditingController();

  void initState() {}
  void dispose() {
    tecUsername.dispose();
    tecPassword.dispose();
  }

  void login() async {
    read(someUserProvider).state =
        await read(userRepositoryProvider).getUser(tecUsername.text);
    if (loginFormKey.currentState!.validate()) {}
  }

  String? loginUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? userCheck = read(someUserProvider).state;
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
      final User? userCheck = read(someUserProvider).state;
      final passwordValidation = userCheck?.whenOrNull(
        (username, password) =>
            (password != value) ? "Incorrect password" : null,
        error: (String? errorMsg) => "",
      );
      return passwordValidation;
    }
  }

  // String? registerUsernameValidator(String? value) {
  //   final User? userCheck = read(someUserProvider).state;
  // }
}
