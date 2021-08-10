import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pragmatic_todo/data/data_providers.dart';
import 'package:pragmatic_todo/model/todo/todo.dart';

class TodoViewModel {
  TodoViewModel(this.read);
  final Reader read;
  final todoFormKey = GlobalKey<FormState>();

  void initState() {}

  String? todoTitleValidator(String? value) {}

  String? todoContentValidator(String? value) {
    if (value == '') {
      return "Can't save an empty Todo";
    }
  }

  void saveTodo() {
    if (todoFormKey.currentState!.validate()) {
      read(todoRepositoryProvider).addTodo(
        const Todo(
          title: "Hello",
          content: "World",
          isCompleted: false,
        ),
      );
    }
  }

  void dispose() {}
}
