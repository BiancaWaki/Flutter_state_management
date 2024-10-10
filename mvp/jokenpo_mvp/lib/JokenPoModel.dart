import 'dart:math';

class JokenPoModel {
  final List<String> opcoes = ["pedra", "papel", "tesoura"];

  String escolhaComputador() {
    return opcoes[Random().nextInt(opcoes.length)];
  }

  String resultado(String escolhaUsuario, String escolhaApp) {
    if (escolhaUsuario == "pedra" && escolhaApp == "tesoura" ||
        escolhaUsuario == "papel" && escolhaApp == "pedra" ||
        escolhaUsuario == "tesoura" && escolhaApp == "papel") {
      return "ganhou";
    } else if (escolhaUsuario == escolhaApp) {
      return "empate";
    } else {
      return "perdeu";
    }
  }
}
