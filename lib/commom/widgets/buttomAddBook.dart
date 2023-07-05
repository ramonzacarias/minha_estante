import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/models/book_model.dart';

import 'package:minha_estante/commom/widgets/widgetsDialog/already_dialog.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/anbandoned_dialog.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/future_page_dialog.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/page_number_dialog.dart';

class buttomAddBook extends StatelessWidget {
  final BookModel book; // Declara a variável book

  const buttomAddBook({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.green,
      onPressed: () {
        _addBookToList(context, book);
      },
      child: const Icon(Icons.menu_book),
    );
  }
}

void _addBookToList(context, BookModel book) {
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
                        BookReadingStatus.lendo,
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPageNumberDialog(
                                    context, book, BookReadingStatus.lendo))
                      },
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
                        BookReadingStatus.queroLer,
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => futurePageDialog(
                            context, book, BookReadingStatus.queroLer),
                      ),
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
                        BookReadingStatus.lido,
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                alreadyReadPageDialog(
                                    context, book, BookReadingStatus.lido))
                      },
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
                        BookReadingStatus.abandonei,
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                abandonedPageDialog(
                                    context, book, BookReadingStatus.abandonei))
                      },
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
