import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class RegisterPresenter extends ChangeNotifier {
  bool loading = false;
  final TodoApi api;

  RegisterPresenter({required this.api});

  // Exemplo de uma função que pode ser chamada
  Future<bool> register(String name, String email, String password) async {
    loading = true;
    notifyListeners();
    bool teste = await api.register(name, email, password);
    loading = false;
    notifyListeners();
    if (teste) {
      return true;
    } else {
      return false;
    }
  }
}
