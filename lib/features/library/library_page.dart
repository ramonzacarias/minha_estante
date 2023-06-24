import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/commom/widgets/custom_search_bar.dart';
import 'package:minha_estante/commom/widgets/favorite_bar.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  String _searchQuery = '';
  dynamic _searchResult;
  TextEditingController _controllerSearch = TextEditingController();

  void _showSnackBarMessage() {
    //aparece uma barra de aviso para digitar algo a ser pesquisado
    final snackBar = SnackBar(
      content: Text('Digite algum título para que seja pesquisado'),
      backgroundColor: AppColors.graffite,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _searchBooks() async {
    if (_searchQuery.isEmpty) {
      _showSnackBarMessage();
      return null;
    }
    final result = await BooksApi.search(_searchQuery);
    setState(() {
      _searchResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 34.0),
        CustomSearchBar(
          controllerText: _controllerSearch,
          onTextChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          searchPressed: _searchBooks,
        ),
        FavoriteBar(),
        /*
>>>>>>> 1a4cc81ee4ba512cb909645ee5fe9fab03c981c3
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CategoryBar(
              categories: ['Lendo', 'Quero Ler', 'Lidos', 'Abandonei', 'Todos'],
              selectCategoryIndex: _selectCategoryIndex,
              categorySelected: (index) {
                setState(() {
                  _selectCategoryIndex = index;
                });
              },
           )
          ),
          */
        //Lista os livros encontrados na busca via API
        SearchResults(searchResult: _searchResult)
      ]),
    );
  }
}
