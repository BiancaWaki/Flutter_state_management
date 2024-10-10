import 'package:jokenpo_2/JokenPoModel.dart';

class JokenPoPresenter {
  final JokenPoModel _model;
  late Function(String, String) _viewUpdateCallback;

  JokenPoPresenter(this._model);

  void attachView(Function(String, String) updateCallback) {
    _viewUpdateCallback = updateCallback;
  }

  void opcaoSelecionada(String escolhaUsuario) {
    String escolhaApp = _model.escolhaComputador();
    String resultado = _model.resultado(escolhaUsuario, escolhaApp);
    _viewUpdateCallback(escolhaApp, resultado);
  }
}
