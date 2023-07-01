import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final dynamic searchResult;

  const SearchResults({Key? key, this.searchResult});

  @override
  Widget build(BuildContext context) {
    if (searchResult != null) {
      final items = searchResult['items'];
      if (items != null && items.isNotEmpty) {
        return Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final book = items[index];
              final volumeInfo = book['volumeInfo'];
              final title = volumeInfo['title'];
              final authors = volumeInfo['authors'];
              final imageLinks = volumeInfo['imageLinks'];

              return ListTile(
                leading: Container(
                  width: 56.0,
                  child: imageLinks != null && imageLinks['thumbnail'] != null
                      ? Image.network(imageLinks['thumbnail'])
                      : FadeInImage.assetNetwork(
                          placeholder:
                              'https://www.pngplay.com/wp-content/uploads/4/Book-Transparent-Free-PNG.png',
                          image:
                              'https://www.pngplay.com/wp-content/uploads/4/Book-Transparent-Free-PNG.png',
                        ),
                ),
                title: Text(title ?? 'Título desconhecido'),
                subtitle: Text(authors?.join(', ') ?? 'Autor desconhecido'),
              );
            },
          ),
        );
      } else {
        return Expanded(
          child: Center(child: Text('Nenhum resultado encontrado')),
        );
      }
    } else {
      return Container();
    }
  }
}
