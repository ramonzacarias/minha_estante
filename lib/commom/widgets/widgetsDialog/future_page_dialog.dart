import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

Widget futurePageDialog(BuildContext context) {
  return AlertDialog(
    title: Text('Adicionar à Biblioteca',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: AppColors.green,
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),),
    content: Text(
      'Deseja adicionar esse livro em sua Biblioteca para ler futuramente?',
      style: TextStyle(
          color: AppColors.green, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    actions: [
      TextButton(
        onPressed: () {
          // Lógica para adicionar o livro à biblioteca de leitura futura
          Navigator.of(context).pop(); // Fechar o diálogo
        },
        child: Text('Sim', style: TextStyle(color: AppColors.greenOne),),
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
