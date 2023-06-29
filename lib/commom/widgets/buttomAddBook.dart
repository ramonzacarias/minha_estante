import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

class buttomAddBook extends StatelessWidget {
  const buttomAddBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.green,
      onPressed: () {
        _addBookToList(context);
      },
      child: const Icon(Icons.menu_book),
    );
  }
}

void _addBookToList(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.otherGrey,
                          width: 1.0, // Largura da linha
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: new Text(
                        'Lendo',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.otherGrey,
                          width: 1.0, // Largura da linha
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: new Text(
                        'Quero Ler',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.otherGrey,
                          width: 1.0, // Largura da linha
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: new Text(
                        'Já li',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.otherGrey,
                          width: 1.0, // Largura da linha
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: new Text(
                        'Abandonei',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}