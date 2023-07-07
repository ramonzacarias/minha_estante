import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/features/book_detail/book_detail.dart';

// Classe para retornar um widget exibindo que o livro foi adicionado com sucesso a biblioteca
class SuccessDialog {
  static void show(BuildContext context, String bookId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Leitura Atualizada",
                style: AppTextStyles.mediumText18
                    .copyWith(color: AppColors.greenTwo),
              ),
              SizedBox(height: 40),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetail(
                        bookId: bookId, // Passe o bookId novamente
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "OK",
                    style: AppTextStyles.smallText
                        .copyWith(color: AppColors.greenTwo),
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
  }
}