import 'package:flutter/foundation.dart';
import 'package:minha_estante/features/splash/splash_state.dart';

import 'package:minha_estante/services/secure_storage.dart';

class SplashController extends ChangeNotifier {
  final SecureStorage _service; // Serviço de armazenamento seguro

  SplashController(this._service);

  SplashState _state = SplashStateInitial(); // Estado inicial do Splash

  SplashState get state => _state; // Obtém o estado atual do Splash

  void _changeState(SplashState newState) {
    _state = newState; // Atualiza o estado do Splash
    notifyListeners(); // Notifica os ouvintes (listeners) sobre a modificação do estado
  }

  // Verifica se o usuário está logado
  void isUserLogged() async {
    await Future.delayed(const Duration(seconds: 1)); // Aguarda 1 segundo para simular uma verificação assíncrona
    final result = await _service.readOne(key: "CURRENT_USER"); // Lê o valor armazenado para a chave "CURRENT_USER"
    if (result != null) {
      _changeState(SplashStateSuccess()); // Caso o usuário esteja logado, altera o estado para SplashStateSuccess() para ir para a tela inicial (home)
    } else {
      _changeState(SplashStateError()); // Caso contrário, altera o estado para SplashStateError() para ir para a tela de login
    }
  }
}
