import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class TodoPresenter extends ChangeNotifier {
  final TodoApi api;

  TodoPresenter({required this.api});

  bool loadingTodo = false;

  Future<void> createTodo({
    required String title,
    required String description,
    required String color,
  }) async {
    loadingTodo = true;
    notifyListeners();
    await api.createTodo(
      title: title,
      description: description,
      color: color,
    );
    loadingTodo = false;
    notifyListeners();
  }
}
