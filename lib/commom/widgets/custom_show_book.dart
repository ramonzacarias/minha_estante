import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/widgets/buttomAddBook.dart';

class CustomShowBook extends StatefulWidget {
  final String? title;
  const CustomShowBook({
    super.key,
    this.title,
  });

  @override
  State<CustomShowBook> createState() => _CustomShowBookState();
}

class _CustomShowBookState extends State<CustomShowBook> {
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
              height: 430,
              padding: EdgeInsets.only(left: 15.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'http://books.google.com/books/content?id=2VK3EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                        fit: BoxFit.cover,
                        width: 120.0,
                        height: 150.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150.0, // Ajuste essa altura para alinhar corretamente
                    left:
                        140.0, // Ajuste a posição horizontal conforme necessário
                    child: Container(
                      width: MediaQuery.of(context).size.width -
                          180.0, // Largura igual à largura da tela - 40 (espaçamento lateral)
                      child: Wrap(
                        children: [
                          Text(
                            'Afeto Amor Fantasia',
                            style: AppTextStyles.mediumText16
                                .copyWith(color: AppColors.white),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240.0, // Ajuste essa altura para alinhar corretamente
                    left:
                        140.0, // Ajuste a posição horizontal conforme necessário
                    child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Auto: ",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.black)),
                            TextSpan(
                                text: "H.P Lovecraft",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.white)),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 260.0, // Ajuste essa altura para alinhar corretamente
                    left:
                        140.0, // Ajuste a posição horizontal conforme necessário
                    child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Gênero: ",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.black)),
                            TextSpan(
                                text: "Terror",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.white)),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 280.0, // Ajuste essa altura para alinhar corretamente
                    left:
                        140.0, // Ajuste a posição horizontal conforme necessário
                    child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Nº de páginas: ",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.black)),
                            TextSpan(
                                text: "836",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.white)),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 350.0, // Ajuste essa altura para alinhar corretamente
                    child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Status: ",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.black)),
                            TextSpan(
                                text: "Não lido",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.white)),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 350.0, // Ajuste essa altura para alinhar corretamente
                    right:
                        20.0, // Alinha o texto à direita com um espaçamento de 20px do final da tela
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Páginas: ",
                            style: AppTextStyles.boldText
                                .copyWith(color: AppColors.black),
                          ),
                          TextSpan(
                            text: "--/836",
                            style: AppTextStyles.boldText
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 380.0, // Ajuste essa altura para alinhar corretamente
                    child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: "Sua nota: ",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.black)),
                            TextSpan(
                                text: "5",
                                style: AppTextStyles.boldText
                                    .copyWith(color: AppColors.white)),
                          ]),
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
            top: 460.0, // Ajuste essa altura para alinhar corretamente
            left: 20.0, // Ajuste a posição horizontal conforme necessário
            child: Container(
              width: MediaQuery.of(context).size.width -
                  40.0, // Largura igual à largura da tela - 40 (espaçamento lateral)
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.otherGrey,
                    width: 1.0, // Largura da linha
                  ),
                ),
              ),
              child: Text(
                'Descrição',
                style: AppTextStyles.mediumBoldText20
                    .copyWith(color: AppColors.otherGrey),
              ),
            ),
          ),
          Positioned(
            top: 500.0, // Ajuste essa altura para alinhar corretamente
            left: 20.0, // Ajuste a posição horizontal conforme necessário
            child: Container(
              width: MediaQuery.of(context).size.width -
                  40.0, // Largura igual à largura da tela - 40 (espaçamento lateral)
              child: Wrap(
                children: [
                  Text(
                    '"Grandes Contos de H.P. Lovecraft" é uma coletânea que reúne alguns dos mais icônicos contos do famoso escritor de terror cósmico. O livro apresenta histórias que exploram o desconhecido, o inexplicável e o sobrenatural, criando um universo sombrio e inquietante que envolve o leitor em uma atmosfera de horror e mistério. Entre os contos selecionados estão "O Chamado de Cthulhu", "Nas Montanhas da Loucura", "A Sombra Vinda do Tempo" e outros clássicos que consolidaram H.P. Lovecraft como um dos maiores nomes da literatura de horror. Com sua escrita envolvente e perturbadora, Lovecraft é capaz de transportar o leitor para um mundo onde as fronteiras da razão são constantemente desafiadas, deixando-o cativado até a última página.',
                    style: AppTextStyles.smallText
                        .copyWith(color: AppColors.black),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Botão para abrir as opções de adicionar o livros na biblioteca
      floatingActionButton: buttomAddBook(),
    );
  }
}
