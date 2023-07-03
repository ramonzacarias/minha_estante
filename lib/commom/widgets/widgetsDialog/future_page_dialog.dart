import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/services/user_library_service.dart';

Widget futurePageDialog(BuildContext context, BookModel book, String statusLeitura) {
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
          // Verificar se o livro já está presente na biblioteca
          final bool bookExists =
              await userLibraryService.checkBookExists(userId, book.id);

          if (bookExists) {
            // Atualizar o status do livro
            await userLibraryService.updateBookStatus(userId, book.id, statusLeitura);
          } else {
            // Adicionar o livro à biblioteca
            await userLibraryService.addBookToLibrary(userId, book);
            await userLibraryService.updateBookStatus(userId, book.id, statusLeitura);
          }

          Navigator.of(context).pop(); // Fechar o diálogo
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
