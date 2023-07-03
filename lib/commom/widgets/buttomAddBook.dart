import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/already_dialog.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/anbandoned_dialog.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/future_page_dialog.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/page_number_dialog.dart';

class buttomAddBook extends StatelessWidget {
  final BookModel book; // Adicione essa linha para declarar a variável book

  const buttomAddBook({
    Key? key, // Corrija o nome do parâmetro key para Key
    required this.book, // Adicione esse parâmetro e marque-o como required
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
                        'Lendo',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPageNumberDialog(context))
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
                        'Quero Ler',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            futurePageDialog(context, book, 'Quero Ler'),
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
                        'Já li',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                alreadyReadPageDialog(context))
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
                        'Abandonei',
                        style: AppTextStyles.mediumText18
                            .copyWith(color: AppColors.green),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                abandonedPageDialog(context))
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
