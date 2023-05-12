import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controllerText;
  final Function(String) onTextChanged;
  final VoidCallback searchPressed;

  SearchBar({
    required this.controllerText,
    required this.onTextChanged,
    required this.searchPressed
  });

  //Essa classe é utilizada para reaproveitar a barra de pesquisa em outras telas

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
                        )
                      ),
                      hintText: 'Digite o título do livro',
                    ),
                    onChanged: onTextChanged,
                  ),
                ),
                InkWell(
                  onTap: searchPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                )
              ],
            ),
    );
  }
}