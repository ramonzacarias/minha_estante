import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/features/sign_in/sign_in_state.dart';
import 'package:minha_estante/services/auth_service.dart';
import 'package:minha_estante/services/secure_storage.dart';

class SignInController extends ChangeNotifier {
  final AuthService _service;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInController(this._service);

  SignInState _state = SignInStateInitial();

  SignInState get state => _state;

  void _changeState(SignInState newState) {
    _state = newState; // Atualiza o estado
    notifyListeners(); // Notifica a modificação para a classe que está escutando
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    const secureStorage = SecureStorage();

    _changeState(SignInStateLoading());

    try {
      final user = await _service.signIn(
        email: email,
        password: password,
      );
      //Verifica se o usuário existe
      if (user.id != null) {
        await secureStorage.write(key: "CURRENT_USER", value: user.toJson());
        _changeState(SignInStateSuccess());
      } else {

      }
    } catch (e) {
      _changeState(SignInStateError(e.toString()));
    }
  }

  // Fazendo update de futuros usuários nesse método
  Future<void> updateUserName(String name, String newValue) async {
      const secureStorage = SecureStorage();

      await secureStorage.update(key: name, newValue: newValue);
  }

  // Atualização de senha de futuros usuários utilizando o próprio Firebase
  Future<void> updatePassword({required String newPassword}) async {
    try {

      await _auth.currentUser!.updatePassword(newPassword);
      print('Senha atualizada com suceeso!');

    } catch (e) {

      print('Erro ao solicitar atualização da senha: $e');

    }

  }

}
