import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

Widget buildPageNumberDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  int _numberPag = 0;
  final UserLibraryService userLibraryService = UserLibraryService();

  return AlertDialog(
    title: Text(
      'Insira o número da página:',
      style: AppTextStyles.mediumText18.copyWith(color: AppColors.green),
    ),
    content: TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _numberPag = int.tryParse(value) ?? 0;
      },
      decoration: InputDecoration(hintText: 'Número da página'),
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
          // Aqui você pode usar o número da página selecionado
          print('Número da página: $_numberPag');
          userLibraryService.updateReadingStatus(
              book, statusLeitura, _numberPag);
          Navigator.of(context).pop(); // Fecha o dialog

          SuccessDialog.show(context, book.id); // Exibe o dialog de sucesso
        },
      ),
    ],
  );
}
