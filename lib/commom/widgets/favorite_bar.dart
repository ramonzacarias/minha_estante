import 'package:flutter/material.dart';
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

/*
enum Color { lendo, queroLer, lidos, abandonei, todos }

class FavoriteBar extends StatefulWidget {
  const FavoriteBar({super.key});

  @override
  State<FavoriteBar> createState() => _FavoriteBarState();
}

class _FavoriteBarState extends State<FavoriteBar> {
  Color selectedColor = Color.lidos;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Color>(
      segments: const <ButtonSegment<Color>>[
        ButtonSegment<Color>(
          value: Color.lendo,
          label: Text('Lendo'),
        ),
        ButtonSegment<Color>(
          value: Color.queroLer,
          label: Text('Quero Ler'),
        ),
        ButtonSegment<Color>(
          value: Color.lidos,
          label: Text('Lidos'),
        ),
        ButtonSegment<Color>(
          value: Color.abandonei,
          label: Text('Abandonei'),
        ),
        ButtonSegment<Color>(
          value: Color.todos,
          label: Text('Todos'),
        ),
      ],
      selected: <Color>{selectedColor},
    );
  }
}
*/