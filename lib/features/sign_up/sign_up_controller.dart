import 'package:flutter/foundation.dart';
import 'package:minha_estante/features/sign_up/sign_up_state.dart';
import 'package:minha_estante/services/auth_service.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _service;

  SignUpController(this._service);

  SignUpState state = SignUpInitialState();

  void changeState(SignUpState newState) {
    state = newState; // Atualiza o estado
    notifyListeners(); // Notifica a modificação para a classe que está escutando
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    changeState(SignUpLoadingState());

    try {
      await _service.signUp(
        name: name,
        email: email,
        password: password,
      );

      changeState(SignUpSuccessState());
    } catch (e) {
      changeState(SignUpErrorState(e.toString()));
    }
  }
}
