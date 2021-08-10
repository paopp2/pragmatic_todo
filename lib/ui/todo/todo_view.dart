import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/logic/todo/todo_view_model.dart';

class TodoView extends HookConsumerWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = TodoViewModel(ref.read);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () {
              //TODO: Implement TodoView onFabPressed
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Title',
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Content',
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
