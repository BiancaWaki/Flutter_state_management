import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class LoginPresenter extends ChangeNotifier {
  bool loading = false;
  final TodoApi api;

  LoginPresenter({required this.api});

  // Exemplo de uma função que pode ser chamada
  Future<bool> login(String username, String password) async {
    loading = true;
    notifyListeners();
    bool teste = await api.login(username, password);
    loading = false;
    notifyListeners();
    if (teste) {
      return true;
    } else {
      return false;
    }
  }
}
