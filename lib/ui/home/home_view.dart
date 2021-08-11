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
                          itemBuilder: (context, idx) {
                            return ListTile(
                              title: Text(todoList[idx].title),
                              subtitle: Text(todoList[idx].content),
                              leading: Checkbox(
                                value: todoList[idx].isCompleted,
                                onChanged: (_) {
                                  //TODO: Implement onTodoCheckBoxTicked
                                },
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
