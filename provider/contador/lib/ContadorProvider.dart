import 'package:flutter/material.dart';

class ContadorProvider with ChangeNotifier {
  int _contador = 0;
  int get cont => _contador;

  void soma_um(){
    _contador += 1 ;

    //precisa notificar para redesenhar a tela
    notifyListeners();
  }

  void subtrai_um(){
    _contador -= 1 ;

    //precisa notificar para redesenhar a tela
    notifyListeners();
  }
}