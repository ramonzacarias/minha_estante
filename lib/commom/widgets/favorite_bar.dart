/*
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';

class FavoriteBar extends StatefulWidget {
  const FavoriteBar({Key? key});

  @override
  State<FavoriteBar> createState() => _FavoriteBarState();
}

class _FavoriteBarState extends State<FavoriteBar> {
  late String selectedFavorite = BookReadingStatus.lendo;
  final List<String> favoriteStatusList = [
    BookReadingStatus.lendo,
    BookReadingStatus.queroLer,
    BookReadingStatus.lido,
    BookReadingStatus.abandonei,
    BookReadingStatus.todos,
  ];

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.greenTwo;
            }
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return AppColors
                .greenTwo; // Defina a cor desejada para o texto não selecionado
          },
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: AppColors.greenTwo, // Defina a cor desejada para as bordas
            width: 1.0, // Defina a largura das bordas
          ),
        ),
      ),
      segments: favoriteStatusList.map((status) {
        return ButtonSegment<String>(
          value: status,
          label: Text(
            status,
            style: AppTextStyles.extraSmallText,
          ),
        );
      }).toList(),
      selected: {selectedFavorite},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          selectedFavorite = newSelection.first;
          // Exibir no console qual classe selecionada para auxiliar na construção do widget da lista de livros
          print(selectedFavorite);
        });
      },
    );
  }
}
*/