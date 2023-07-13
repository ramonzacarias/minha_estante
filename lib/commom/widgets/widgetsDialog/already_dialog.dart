import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';

Widget alreadyReadPageDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  int _rating = 0;
  final UserLibraryService userLibraryService = UserLibraryService();

  return AlertDialog(
    title: Text(
      'Insira a nota de 1 a 10:',
      style: AppTextStyles.mediumText18.copyWith(color: AppColors.green),
    ),
    content: TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        _rating = int.tryParse(value) ?? 0;
      },
      decoration: InputDecoration(
        hintText: 'Nota de 1 a 10',
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: Text(
          'CANCELAR',
          style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Fecha o dialog
        },
      ),
      TextButton(
        child: Text(
          'CONFIRMAR',
          style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
        ),
        onPressed: () {
          print('Nota: $_rating');
          userLibraryService.updateRating(
              book, statusLeitura, book.qtdPaginas, _rating);
          Navigator.of(context).pop(); // Fecha o dialog

          SuccessDialog.show(context, book.id); // Exibe o dialog de sucesso
        },
      ),
    ],
  );
}
