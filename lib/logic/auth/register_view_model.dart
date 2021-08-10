import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/model/user/user.dart';

import 'auth_providers.dart';

class RegisterViewModel {
  RegisterViewModel(this.read);
  final Reader read;
  final registerFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  final tecPassword = TextEditingController();
  final tecConfirmPass = TextEditingController();

  void initState() {}

  Future<void> attemptRegisterThenLogin() async {
    bool isSuccess = false;
    read(someUserProvider).state =
        await read(userRepositoryProvider).getUser(tecUsername.text);
    if (registerFormKey.currentState!.validate()) {
      final newUser = User(
        username: tecUsername.text,
        password: tecPassword.text,
      );
      isSuccess = await read(userRepositoryProvider).addUserToUserList(newUser);
      if (isSuccess) {
        read(currentUserProvider).state = newUser;
        AppRouter.instance.popScreen();
      } else {
        read(currentUserProvider).state =
            const User.error("Register unsuccesful");
      }
    }
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

  void dispose() {
    tecUsername.dispose();
    tecPassword.dispose();
    tecConfirmPass.dispose();
  }
}
