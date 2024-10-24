import 'package:flutter/material.dart';
import 'package:todo/model/todo_api.dart';

class SplashPresenter extends ChangeNotifier {
  bool loadingLogin = false;
  String? jwtToken;
  final TodoApi api;

  SplashPresenter({required this.api});

  Future<bool> checkAuth() async {
    loadingLogin = true;
    notifyListeners();
    String? teste = await api.getToken();
    loadingLogin = false;
    notifyListeners();
    if (teste != null) {
      jwtToken = teste;
      return true;
    } else {
      return false;
    }
  }

  //recuperar token do dispositivo
  Future<String?> getToken() async {
    return await api.getToken();
  }
}
