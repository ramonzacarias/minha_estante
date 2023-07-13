import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';

Widget futurePageDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  final UserLibraryService userLibraryService = UserLibraryService();

  return AlertDialog(
    title: Text(
      'Adicionar à Biblioteca',
      textAlign: TextAlign.center,
      style: AppTextStyles.mediumText18.copyWith(color: AppColors.green),
    ),
    content: Text(
      'Deseja adicionar esse livro em sua Biblioteca para ler futuramente?',
      style: AppTextStyles.smallText,
    ),
    actions: [
      TextButton(
        onPressed: () async {
          // Adicionar o livro à biblioteca
          userLibraryService.addBookToLibrary(book, statusLeitura);
          Navigator.of(context).pop(); // Fechar o dialog

          SuccessDialog.show(context, book.id); // Exibe o dialog de sucesso
        },
        child: Text(
          'SIM',
          style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Fechar o diálogo
        },
        child: Text('NÃO',
            style: AppTextStyles.smallText.copyWith(
              color: AppColors.greenOne,
            )),
      ),
    ],
  );
}
