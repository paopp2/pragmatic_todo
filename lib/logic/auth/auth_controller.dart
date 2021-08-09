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
  final tecUsername = TextEditingController();
  final tecPassword = TextEditingController();
  final tecConfirmPass = TextEditingController();

  void initState() {}

  void dispose() {
    tecUsername.dispose();
    tecPassword.dispose();
    tecConfirmPass.dispose();
  }

  void attemptLogin() async {
    read(someUserProvider).state =
        await read(userRepositoryProvider).getUser(tecUsername.text);
    final someUser = read(someUserProvider).state;
    if (loginFormKey.currentState!.validate()) {
      read(currentUserProvider).state =
          someUser ?? const User.error("Error logging in");
    }
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
        (_, password) => (password != value) ? "Incorrect password" : null,
        error: (String? errorMsg) => "",
      );
      return passwordValidation;
    }
  }

  Future<bool> attemptRegisterThenLogin() async {
    bool isSuccess = false;
    read(someUserProvider).state =
        await read(userRepositoryProvider).getUser(tecUsername.text);
    if (registerFormKey.currentState!.validate()) {
      final newUser = User(
        username: tecUsername.text,
        password: tecPassword.text,
      );
      isSuccess = await read(userRepositoryProvider).addUserToUserList(newUser);
      read(currentUserProvider).state =
          (isSuccess) ? newUser : const User.error("Register unsuccessful");
    }
    return isSuccess;
  }

  String? registerUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? userCheck = read(someUserProvider).state;
      final usernameValidation = userCheck?.whenOrNull(
        (username, _) => "The username '$username' is taken",
      );
      return usernameValidation;
    }
  }

  String? registerPasswordValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final passwordsEqual = (tecPassword.text == tecConfirmPass.text);
      return (!passwordsEqual) ? "Passwords do not match" : null;
    }
  }
}
