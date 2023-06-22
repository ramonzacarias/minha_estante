import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

// Widget criado para reaproveitar a barra de pesquisa em outras telas

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controllerText;
  final Function(String) onTextChanged;
  final VoidCallback searchPressed;

  CustomSearchBar({
    required this.controllerText,
    required this.onTextChanged,
    required this.searchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 19.0,
        right: 19.0,
        top: 28.0,
        bottom: 4.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: AppColors.graffite,
                  ),
                ),
                filled:
                    true, // Define que o campo será preenchido com cor interna
                fillColor:
                    AppColors.otherGreylight, // Define a cor interna do campo
                prefixIcon: GestureDetector(
                  onTap: searchPressed,
                  child: Icon(Icons.search),
                ),
                hintText: 'Digite o título do livro',
              ),
              onChanged: onTextChanged,
            ),
          ),
        ],
      ),
    );
  }
}
