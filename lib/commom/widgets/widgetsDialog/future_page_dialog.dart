import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';

Widget futurePageDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  final UserLibraryService userLibraryService = UserLibraryService();
  final String userId = userLibraryService.getUserId();

  return AlertDialog(
    title: Text(
      'Adicionar à Biblioteca',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Text(
      'Deseja adicionar esse livro em sua Biblioteca para ler futuramente?',
      style: TextStyle(
        color: AppColors.green,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () async {
          // Adicionar o livro à biblioteca
          userLibraryService.addBookToLibrary(userId, book, statusLeitura);
          Navigator.of(context).pop(); // Fechar o dialog

          SuccessDialog.show(context); // Exibe o dialog de sucesso
        },
        child: Text(
          'Sim',
          style: TextStyle(color: AppColors.greenOne),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Fechar o diálogo
        },
        child: Text('Não', style: TextStyle(color: AppColors.greenOne)),
      ),
    ],
  );
}
