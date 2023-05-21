import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final dynamic searchResult;

  const SearchResults({super.key, this.searchResult});

  @override
  Widget build(BuildContext context) {
    return searchResult != null
      ? searchResult['items'] != null && searchResult['items'].isNotEmpty
        ? Expanded(
                child: ListView.builder(
                  itemCount: searchResult['items'].length,
                  itemBuilder: (context, index) {
                    final book = searchResult['items'][index];
                    return ListTile(
                      leading: Container(
                        width: 56.0,
                        child: book['volumeInfo']['imageLinks'] != null &&
                              book['volumeInfo']['imageLinks']['thumbnail'] !=
                                  null
                          ? Image.network(
                              book['volumeInfo']['imageLinks']['thumbnail'],
                            )
                          : FadeInImage.assetNetwork(
                              placeholder: 'https://www.pngplay.com/wp-content/uploads/4/Book-Transparent-Free-PNG.png',
                              image: 'https://www.pngplay.com/wp-content/uploads/4/Book-Transparent-Free-PNG.png',
                            ),
                      ),
                      title: Text(book['volumeInfo']['title']),
                      subtitle: Text(
                          book['volumeInfo']['authors']?.join(', ') ??
                              'Autor desconhecido'),
                    );
                  },
                ),
              )
          : Expanded(child: Center(child: Text('Nenhum resultado encontrado')))
      : Container();
  }
}