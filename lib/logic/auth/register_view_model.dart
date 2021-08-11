import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

class RegisterViewModel {
  RegisterViewModel(this.read);
  final Reader read;
  final registerFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  final tecPassword = TextEditingController();
  final tecConfirmPass = TextEditingController();
  late UserRepository _userRepository;
  late AuthService _authService;
  User? _userQuery;

  void initState() {
    _userRepository = read(userRepositoryProvider);
    _authService = read(authServiceProvider);
  }

  Future<void> attemptRegisterThenLogin() async {
    _userQuery = await _userRepository.getUser(tecUsername.text);
    if (registerFormKey.currentState!.validate()) {
      final newUser = User(
        username: tecUsername.text,
        password: tecPassword.text,
      );
      bool isSuccess = false;
      isSuccess = await _userRepository.addUserToUserList(newUser);
      if (isSuccess) {
        _authService.loginAs(newUser);
        AppRouter.instance.popView();
      }
    }
  }

  String? registerUsernameValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    } else {
      final User? tmpUser = _userQuery;
      if (tmpUser != null) {
        return "The username '${tmpUser.username}' is taken";
      }
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
