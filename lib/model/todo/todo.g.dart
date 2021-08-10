// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      title: json['title'] as String,
      content: json['content'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'isCompleted': instance.isCompleted,
    };
