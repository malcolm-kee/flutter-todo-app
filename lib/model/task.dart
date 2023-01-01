import 'package:flutter/material.dart';

@immutable
class Task {
  final String title;
  final bool done;

  const Task({required this.title, this.done = false});

  Task copyWith({String? title, bool? done}) =>
      Task(title: title ?? this.title, done: done ?? this.done);
}
