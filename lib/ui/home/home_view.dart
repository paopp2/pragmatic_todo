import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/home/home_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModelProvider);
    final todoList = model.getTodoList();

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

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
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: model.createNewTodo,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: (todoList.isNotEmpty)
                      ? ListView.builder(
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(todoList[index].title),
                              subtitle: Text(todoList[index].content),
                              leading: Checkbox(
                                value: todoList[index].isDone,
                                onChanged: (_) => model.toggleTodo(index),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text("Empty Todolist"),
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
