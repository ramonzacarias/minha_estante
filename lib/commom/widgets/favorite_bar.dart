import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

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
            'Lendo',
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.wantToRead,
          label: Text(
            'Quero Ler',
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.read,
          label: Text(
            'Lidos',
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.abandoned,
          label: Text(
            'Abandonei',
            style: AppTextStyles.extraSmallText,
          ),
        ),
        ButtonSegment<FavoriteStatus>(
          value: FavoriteStatus.all,
          label: Text(
            'Todos',
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
