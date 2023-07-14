import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

import '../../features/book_detail/book_detail.dart';

class SearchResults extends StatelessWidget {
  final dynamic searchResult;
  final BuildContext context;

  const SearchResults({Key? key, this.searchResult, required this.context})
      : super(key: key);

  // Função que navega para a aba de detalhes do livro
  void _navigateToBookDetail(String bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetail(bookId: bookId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenTwo,
        title: Text(
          'Resultados de Pesquisa',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (searchResult != null) {
      final items = searchResult['items'];
      if (items != null && items.isNotEmpty) {
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final book = items[index];
            final volumeInfo = book['volumeInfo'];
            final title = volumeInfo['title'];
            final authors = volumeInfo['authors'];
            final imageLinks = volumeInfo['imageLinks'];
            final bookId = book['id'];

            return GestureDetector(
              // Abre a tela de detalhes do livro ao clicar sobre o resultado
              onTap: () {
                _navigateToBookDetail(bookId);
              },
              child: ListTile(
                leading: Container(
                  width: 56.0,
                  child: imageLinks != null && imageLinks['thumbnail'] != null
                      ? CachedNetworkImage(
                          imageUrl: imageLinks['thumbnail'],
                          placeholder: (context, url) =>
                              Image.asset('assets/images/placeholder.png'),
                        )
                      : Image.asset('assets/images/placeholder.png'),
                ),
                title: Text(title ?? 'Título desconhecido'),
                subtitle: Text(authors?.join(', ') ?? 'Autor desconhecido'),
              ),
            );
          },
        );
      } else {
        return Center(child: Text('Nenhum resultado encontrado'));
      }
    } else {
      return Container();
    }
  }
}
