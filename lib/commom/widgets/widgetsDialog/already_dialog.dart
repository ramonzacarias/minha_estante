import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';

Widget alreadyReadPageDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  int _rating = 0;
  final UserLibraryService userLibraryService = UserLibraryService();
  final String userId = userLibraryService.getUserId();

  return AlertDialog(
    title: Text(
      'Insira a nota de 1 a 10:',
      style: TextStyle(
        color: AppColors.green,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
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
          'Cancelar',
          style: TextStyle(color: AppColors.green),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Fecha o dialog
        },
      ),
      TextButton(
        child: Text(
          'Confirmar',
          style: TextStyle(color: AppColors.green),
        ),
        onPressed: () {
          print('Nota: $_rating');
          userLibraryService.updateRating(
              userId, book, statusLeitura, book.qtdPaginas, _rating);
          Navigator.of(context).pop(); // Fecha o dialog

          SuccessDialog.show(context); // Exibe o dialog de sucesso
        },
      ),
    ],
  );
}


