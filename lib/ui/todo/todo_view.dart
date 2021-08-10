import 'package:flutter/material.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
