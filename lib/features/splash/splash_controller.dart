import 'package:flutter/foundation.dart';
import 'package:minha_estante/features/splash/splash_state.dart';

import '../../services/secure_storage.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage _service;

  SplashController(this._service);

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  // Faz a verificação se o usuário está logado
  void isUserLogged() async {
    final result = await _service.readOne(key: "CURRENT_USER");
    if (result != null) {
      _changeState(SplashStateSuccess()); // Caso o user esteja logado ir para a tela home
    } else {
      _changeState(SplashStateError()); // Caso aconteça algum erro, ir para a tela de login
    }
  }
}