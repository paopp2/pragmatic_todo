import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/auth/login_view_model.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(loginViewModelProvider);

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
                key: model.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: model.tecUsername,
                      validator: model.loginUsernameValidator,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: model.loginPasswordValidator,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: model.attemptLogin,
                      child: const Text("Login"),
                    ),
                    TextButton(
                      child: const Text("No account?"),
                      onPressed: model.gotoRegisterScreen,
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
