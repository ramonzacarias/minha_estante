import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';

class RemoveBook extends StatelessWidget {
  final BookModel book;

  const RemoveBook({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Função de callback para o TextButton
        removeBookDialog(context, book);
      },
      child: Text(
        'Remover da biblioteca',
        style: AppTextStyles.extraSmallText.copyWith(color: AppColors.blue),
      ),
    );
  }
}

void removeBookDialog(BuildContext context, BookModel book) {
  final UserLibraryService _userLibraryService = UserLibraryService();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Remover da Biblioteca",
          style: AppTextStyles.mediumText18.copyWith(color: AppColors.green),
        ),
        content: Text('Clique em "Remover" para remover o livro da sua biblioteca'),
        actions: [
          TextButton(
            child: Text(
              'SAIR',
              style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o dialog
            },
          ),
          TextButton(
            child: Text(
              'REMOVER',
              style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
            ),
            onPressed: () {
              _userLibraryService.removeBookFromLibrary(book.id);
              Navigator.of(context).pop(); // Fecha o dialog

              SuccessDialog.show(context, book.id);
            },
          ),
        ],
      );
    },
  );
}
