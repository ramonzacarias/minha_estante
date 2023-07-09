import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/services/secure_storage.dart';

class ProfileController {
  const ProfileController();
  final _secureStorage = const SecureStorage();

  void navigateToSplash(BuildContext context) {
    Navigator.popAndPushNamed(context, NamedRoute.splash);
  }

  void navigateToProfileEdit(BuildContext context) {
    Navigator.popAndPushNamed(context, NamedRoute.profileEdit);
  }

  void navigateToTermsOfUse(BuildContext context) {
    Navigator.popAndPushNamed(context, NamedRoute.useTherms);
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir conta'),
          content: Text(
              'Clique em "Apagar" para confirmar a exclusão da sua conta.'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Apagar'),
              onPressed: () {
                // Chama o método para excluir o usuário atual
                deleteCurrentUser(context);
              },
            ),
          ],
        );
      },
    );
  }
  
  void deleteCurrentUser(BuildContext context) {
    // Obtém a instância do usuário atualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Exclui o usuário autenticado
      user.delete().then((_) {
        // Após excluir o usuário, navega para a tela inicial
        Navigator.popAndPushNamed(context, NamedRoute.initial);
      }).catchError((error) {
        // Trata possíveis erros durante a exclusão do usuário
        print('Erro ao excluir o usuário: $error');
      });
    }
  }

  void toDoLogout(BuildContext context) {
    // Deleta a "sessão" de acesso do usuário
    _secureStorage.deleteOne(key: "CURRENT_USER").then(
          (_) => Navigator.popAndPushNamed(context, NamedRoute.initial),
        );
  }
}
