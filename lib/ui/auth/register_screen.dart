import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/auth/auth_providers.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider);

    useEffect(() {
      controller.initState();
      return controller.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: controller.registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controller.tecUsername,
                      validator: controller.registerUsernameValidator,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: controller.tecPassword,
                      validator: controller.registerPasswordValidator,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: controller.tecConfirmPass,
                      validator: controller.registerPasswordValidator,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Confirm password',
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: controller.register,
                      child: const Text("Register"),
                    )
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
