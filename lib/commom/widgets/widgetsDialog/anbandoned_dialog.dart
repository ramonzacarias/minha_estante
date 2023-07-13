import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';

import 'package:minha_estante/commom/constants/app_colors.dart';

Widget abandonedPageDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  int _rating = BookReadingStatus.nota;
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
          if (_rating >= 1 && _rating <= 10) {
            print('Nota: $_rating');
            userLibraryService.updateBookStatus(book, statusLeitura, _rating);
            Navigator.of(context).pop(); // Fecha o dialog

            SuccessDialog.show(context, book.id); // Exibe o dialog de sucesso
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Erro',
                    style: AppTextStyles.mediumText18
                        .copyWith(color: AppColors.red),
                  ),
                  content: Text(
                    'Por favor, digite uma nota válida de 1 a 10.',
                    style: AppTextStyles.smallText,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Fecha o dialog de nota inválida
                      },
                      child: Text(
                        'OK',
                        style: AppTextStyles.smallText
                            .copyWith(color: AppColors.greenOne),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    ],
  );
}
