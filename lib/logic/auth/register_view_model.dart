import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers/repository_providers.dart';
import 'package:pragmatic_todo/data/data_providers/service_providers.dart';
import 'package:pragmatic_todo/data/repositories/user_repository.dart';
import 'package:pragmatic_todo/data/services/auth_service.dart';
import 'package:pragmatic_todo/model/user/user.dart';

final registerViewModelProvider = Provider.autoDispose<RegisterViewModel>(
  (ref) => RegisterViewModel(
    userRepository: ref.watch(userRepositoryProvider),
    authService: ref.watch(authServiceProvider),
  ),
);

class RegisterViewModel {
  RegisterViewModel({required this.userRepository, required this.authService});
  final UserRepository userRepository;
  final AuthService authService;
  final registerFormKey = GlobalKey<FormState>();
  final tecUsername = TextEditingController();
  final tecPassword = TextEditingController();
  final tecConfirmPass = TextEditingController();
  User? _userQuery;

  void initState() {}

  Future<void> attemptRegisterThenLogin() async {
    _userQuery = await userRepository.getUser(tecUsername.text);
    assert(registerFormKey.currentState != null);
    if (registerFormKey.currentState!.validate()) {
      final newUser = User(
        username: tecUsername.text,
        password: tecPassword.text,
      );
      bool isSuccess = false;
      isSuccess = await userRepository.addUserToUserList(newUser);
      if (isSuccess) {
        authService.loginAs(newUser);
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
