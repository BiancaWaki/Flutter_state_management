import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class AppPresenter extends ChangeNotifier {
  bool loadingRegister = false;
  bool loadingLogin = false;
  bool loadingTodos = false;
  final TodoApi api;
  List<dynamic> todos = [];

  AppPresenter({required this.api});

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    loadingRegister = true;
    notifyListeners();
    bool teste = await api.register(name, email, password);
    loadingRegister = false;
    notifyListeners();
    if (teste) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    loadingLogin = true;
    notifyListeners();
    bool teste = await api.login(username, password);
    loadingLogin = false;
    notifyListeners();
    if (teste) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<dynamic>> createTodo({
    required String title,
    required String description,
    required String color,
  }) async {
    loadingTodos = true;
    notifyListeners();
    await api.createTodo(title, description, color);
    List<dynamic> todos = await getTodos();
    this.todos = todos;
    loadingTodos = false;
    notifyListeners();
    return todos;
  }

  Future<void> deleteTodo(int todoId) async {
    loadingTodos = true;
    notifyListeners();
    await api.deleteTodo(todoId);
    List<dynamic> todos = await getTodos();
    this.todos = todos;
    loadingTodos = false;
    notifyListeners();
  }

  Future<List<dynamic>> getTodos() async {
    loadingTodos = true;
    notifyListeners();
    List<dynamic> todos = await api.getTodos();
    this.todos = todos;
    loadingTodos = false;
    notifyListeners();
    return todos;
  }
}