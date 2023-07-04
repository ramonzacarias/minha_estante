import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';

enum FavoriteStatus { reading, wantToRead, read, abandoned, all }

class FavoriteBar extends StatefulWidget {
  const FavoriteBar({Key? key});

  @override
  State<FavoriteBar> createState() => _FavoriteBarState();
}

class _FavoriteBarState extends State<FavoriteBar> {
  late FavoriteStatus selectedFavorite = FavoriteStatus.reading;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<FavoriteStatus>(
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
      segments: const <ButtonSegment<FavoriteStatus>>[
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.reading,
          label: Text(
            BookReadingStatus.lendo,
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.wantToRead,
          label: Text(
            BookReadingStatus.queroLer,
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.read,
          label: Text(
            BookReadingStatus.lido,
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.abandoned,
          label: Text(
            BookReadingStatus.abandonei,
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.all,
          label: Text(
            BookReadingStatus.todos,
            style: AppTextStyles.extraSmallText,
          ),
        ),
      ],
      selected: {selectedFavorite},
      onSelectionChanged: (Set<FavoriteStatus> newSelection) {
        setState(() {
          selectedFavorite = newSelection.first;
        });
      },
    );
  }
}
