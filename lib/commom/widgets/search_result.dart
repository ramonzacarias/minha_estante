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
                      leading: Image.network(
                        book['volumeInfo']['imageLinks']['thumbnail'],
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