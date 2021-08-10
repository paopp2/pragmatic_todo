import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoViewModel {
  TodoViewModel(this.read);
  final Reader read;
  final todoFormKey = GlobalKey<FormState>();

  void initState() {}

  void saveTodo() {}

  String? todoTitleValidator(String? value) {}
  String? todoContentValidator(String? value) {}

  void dispose() {}
}
