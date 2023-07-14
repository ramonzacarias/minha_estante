
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';

class FavoriteBar extends StatefulWidget {
  final void Function(String) onStatusSelected;

  const FavoriteBar({Key? key, required this.onStatusSelected});

  @override
  State<FavoriteBar> createState() => _FavoriteBarState();
}

class _FavoriteBarState extends State<FavoriteBar> {
  late String selectedFavorite = BookReadingStatus.lendo; // Status inicial
  
  // Lista de favoritos
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
            return AppColors.greenTwo;
          },
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: AppColors.greenTwo,
            width: 1.0,
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
          // Atualiza o estado do status favorito selecionado e chama a função de retorno
          selectedFavorite = newSelection.first;
          widget.onStatusSelected(selectedFavorite);
        });
      },
    );
  }
}