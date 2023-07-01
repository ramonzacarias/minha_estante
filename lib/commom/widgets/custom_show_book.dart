import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/buttomAddBook.dart';

class CustomShowBook extends StatelessWidget {
final BookModel book;

  const CustomShowBook({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.green,
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.only(left: 15.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        book.imageUrl,
                        fit: BoxFit.cover,
                        width: 120.0,
                        height: 150.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150.0,
                    left: 140.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 180.0,
                      child: Text(
                        book.titulo,
                        style: AppTextStyles.mediumText16.copyWith(
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240.0,
                    left: 140.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 180.0,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Auto: ",
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: book.autor,
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 260.0,
                    left: 140.0,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Gênero: ",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: book.categoria,
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280.0,
                    left: 140.0,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Nº de páginas: ",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: book.qtdPaginas.toString(),
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350.0,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Status: ",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Não lido",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 350.0,
                    right: 20.0,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Páginas: ",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: "--/ " + book.qtdPaginas.toString(),
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 370.0,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sua nota: ",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextSpan(
                            text: "5",
                            style: AppTextStyles.boldText.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 0,
            top: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.popAndPushNamed(context, NamedRoute.home),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25.0,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(width: 40.0),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.52,
            left: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 40.0,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.otherGrey,
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                'Descrição',
                style: AppTextStyles.mediumBoldText20.copyWith(
                  color: AppColors.otherGrey,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.56,
            left: 20.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 40.0,
              child: Wrap(
                children: [
                  Text(
                    book.descricao,
                    style: AppTextStyles.extraSmallText.copyWith(
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: buttomAddBook(),
    );
  }
}
