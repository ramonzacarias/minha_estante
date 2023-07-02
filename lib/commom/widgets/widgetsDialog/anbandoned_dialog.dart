import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

Widget abandonedPageDialog(BuildContext context) {
  double _rating = 0.0;

  return AlertDialog(
    title: Text(
      'Insira a nota de 1 a 5:',
      style: TextStyle(
        color: AppColors.green,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    content: TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        _rating = double.tryParse(value) ?? 0.0;
      },
      decoration: InputDecoration(
        hintText: 'Nota de 1 a 5',
      ),
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
          print('Nota: $_rating');
          Navigator.of(context).pop(); // Fecha o diálogo
        },
      ),
    ],
  );
}
