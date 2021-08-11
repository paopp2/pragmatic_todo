import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/app_router.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/data/repositories/todo_repository.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';

final todoViewModelProvider = Provider.autoDispose<TodoViewModel>(
  (ref) => TodoViewModel(
    todoRepository: ref.watch(todoRepositoryProvider),
  ),
);

class TodoViewModel {
  TodoViewModel({required this.todoRepository});
  final TodoRepository todoRepository;
  final todoFormKey = GlobalKey<FormState>();
  final tecTodoTitle = TextEditingController();
  final tecTodoContent = TextEditingController();

  void initState() {}

  String? todoTitleValidator(String? value) {}

  String? todoContentValidator(String? value) {
    if (value == '') {
      return "Can't save an empty Todo";
    }
  }

  void saveTodo() {
    if (todoFormKey.currentState!.validate()) {
      var title = tecTodoTitle.text;
      todoRepository.addTodo(
        Todo(
          title: (title.isNotEmpty) ? title : "Untitled",
          content: tecTodoContent.text,
          isCompleted: false,
        ),
      );
      AppRouter.instance.popView();
    }
  }

  void dispose() {
    tecTodoTitle.dispose();
    tecTodoContent.dispose();
  }
}
