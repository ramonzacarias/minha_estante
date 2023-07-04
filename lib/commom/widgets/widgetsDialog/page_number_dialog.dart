import 'package:flutter/material.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/services/user_library_service.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

Widget buildPageNumberDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  int _numberPag = 0;
  final UserLibraryService userLibraryService = UserLibraryService();
  final String userId = userLibraryService.getUserId();

  return AlertDialog(
    title: Text(
      'Insira o número da página:',
      style: TextStyle(
          color: AppColors.green, fontSize: 18, fontWeight: FontWeight.bold),
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
          'Cancelar',
          style: TextStyle(color: AppColors.green),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Fecha o diálogo
        },
      ),
      TextButton(
        child: Text(
          'Confirmar',
          style: TextStyle(color: AppColors.green),
        ),
        onPressed: () {
          // Aqui você pode usar o número da página selecionado
          print('Número da página: $_numberPag');
          userLibraryService.updateReading(userId, book, statusLeitura, _numberPag);
          Navigator.of(context).pop(); // Fecha o diálogo
        },
      ),
    ],
  );
}
