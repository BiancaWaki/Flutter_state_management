import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class RegisterPresenter extends ChangeNotifier {
  bool loadingRegister = false;
  final TodoApi api;

  RegisterPresenter({required this.api});

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    loadingRegister = true;
    notifyListeners();
    String? teste = await api.register(
      username: name,
      email: email,
      password: password,
    );
    loadingRegister = false;
    notifyListeners();
    if (teste != null) {
      return true;
    } else {
      return false;
    }
  }
}
