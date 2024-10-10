import 'package:flutter/material.dart';
import 'package:jokenpo_2/JokenPoModel.dart';
import 'package:jokenpo_2/JokenPoPresenter.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  final JokenPoModel _model = JokenPoModel();
  late JokenPoPresenter _presenter;
  String _mensagem = "";

  //imagens e tamanhos
  String pedra = "images/pedra.png";
  String papel = "images/papel.png";
  String tesoura = "images/tesoura.png";
  String padrao = "images/padrao.png";
  double tamanhoImagem = 90.0;
  double tamanhoTexto = 20.0;
  var _imagemApp = const AssetImage("images/padrao.png");

  
  @override
  void initState() {
    print("initState");
    super.initState();
    _presenter = JokenPoPresenter(_model);
    _presenter.attachView(
      (escolhaApp, resultado) {
        setState(
          () {
            _imagemApp = AssetImage(_getImagemPath(escolhaApp));
            _mensagem = resultado;
          },
        );
      },
    );
  }

  String _getImagemPath(String escolhaApp) {
    switch (escolhaApp) {
      case "pedra":
        return pedra;
      case "papel":
        return papel;
      case "tesoura":
        return tesoura;
      default:
        return padrao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JokenPo",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Computer:",
                style: TextStyle(fontSize: tamanhoTexto),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image(image: _imagemApp),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                _mensagem,
                style: TextStyle(fontSize: tamanhoTexto),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _presenter.opcaoSelecionada("pedra"),
                  child: Image.asset(
                    pedra,
                    width: tamanhoImagem,
                  ),
                ),
                GestureDetector(
                  onTap: () => _presenter.opcaoSelecionada("papel"),
                  child: Image.asset(
                    papel,
                    width: tamanhoImagem,
                  ),
                ),
                GestureDetector(
                  onTap: () => _presenter.opcaoSelecionada("tesoura"),
                  child: Image.asset(
                    tesoura,
                    width: tamanhoImagem,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
