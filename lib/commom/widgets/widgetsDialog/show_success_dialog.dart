import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

class SuccessDialog {
  static void show(BuildContext context, String bookId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading =
            false; // Variável para controlar o estado de carregamento

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(16),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading) // Exibe o CircularProgressIndicator somente quando isLoading for verdadeiro
                    CircularProgressIndicator(),
                  Text(
                    isLoading
                        ? "Atualizando biblioteca.."
                        : "Leitura Atualizada",
                    style: AppTextStyles.mediumText18.copyWith(
                      color: AppColors.greenTwo,
                    ),
                  ),
                  SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true; // Inicia o estado de carregamento
                      });

                      await Future.delayed(Duration(seconds: 1));

                      setState(() {
                        isLoading = false; // Finaliza o estado de carregamento
                      });

                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        "OK",
                        style: AppTextStyles.smallText.copyWith(
                          color: AppColors.greenTwo,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
