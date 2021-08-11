import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const Todo._();
  const factory Todo({
    required String title,
    required String content,
    required bool isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  void toggleStatus() {
    copyWith(isDone: !isDone);
  }
}
