import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class LoginPresenter extends ChangeNotifier {
  bool loadingLogin = false;
  final TodoApi api;

  LoginPresenter({required this.api});

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    loadingLogin = true;
    notifyListeners();
    String? teste = await api.login(
      identifier: username,
      password: password,
    );
    loadingLogin = false;
    notifyListeners();
    if (teste != null) {
      updateToken(teste);
      return true;
    } else {
      return false;
    }
  }

  void updateToken(String? newToken) {
    api.saveToken(newToken!);
  }
}
