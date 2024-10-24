import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class HomePresenter extends ChangeNotifier {
  bool loadingHome = false;
  final TodoApi api;
  List<dynamic> todos = [];

  HomePresenter({required this.api});

  Future<List<dynamic>> createTodo({
    required String title,
    required String description,
    required String color,
  }) async {
    loadingHome = true;
    notifyListeners();
    await api.createTodo(
      title: title,
      description: description,
      color: color,
    );
    List<dynamic> todos = await getTodos();
    this.todos = todos;
    loadingHome = false;
    notifyListeners();
    return todos;
  }

  Future<void> deleteTodo(int todoId) async {
    loadingHome = true;
    notifyListeners();
    await api.deleteTodo(todoId: todoId);
    List<dynamic> todos = await getTodos();
    this.todos = todos;
    loadingHome = false;
    notifyListeners();
  }

  Future<List<dynamic>> getTodos() async {
    loadingHome = true;
    notifyListeners();
    List<dynamic> todos = await api.getTodos();
    this.todos = todos;
    loadingHome = false;
    notifyListeners();
    return todos;
  }

  Future<void> logout() async {
    await api.deleteToken();
  }
}
