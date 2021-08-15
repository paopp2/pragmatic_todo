import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/auth/register_view_model.dart';

import 'components/auth_text_field.dart';

class RegisterView extends HookConsumerWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(registerViewModelProvider);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: model.registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthTextField(
                      tec: model.tecUsername,
                      validator: model.registerUsernameValidator,
                      hint: 'Username',
                    ),
                    const SizedBox(height: 15),
                    AuthTextField(
                      tec: model.tecPassword,
                      validator: model.registerPasswordValidator,
                      hint: "Password",
                      obscure: true,
                    ),
                    const SizedBox(height: 15),
                    AuthTextField(
                      tec: model.tecConfirmPass,
                      validator: model.registerPasswordValidator,
                      hint: "Confirm password",
                      obscure: true,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: model.attemptRegisterThenLogin,
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
