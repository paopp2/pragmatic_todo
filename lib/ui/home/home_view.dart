import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/home/home_view_model.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = HomeViewModel(ref.read);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: model.logOut,
                icon: const Icon(Icons.logout_outlined),
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const Text("TODO LIST"),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("ListTile $index"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
