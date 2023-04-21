import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:minha_estante/features/sign_up/sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  SignUpState state = SignUpInitialState();

  void changeState(SignUpState newState) {
    state = newState; // Atualiza o estado
    notifyListeners(); // Notifica a modificação para a classe que está escutando
  }

  Future<bool> doSignUp() async {
    changeState(SignUpLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    log("Usuario Logado");

    changeState(SignUpSuccessState());

    return true;
  }
}
