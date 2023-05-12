import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/search_bar.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';

import '../../commom/constants/books_api.dart';
import '../../commom/widgets/category_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _searchQuery = '';
  dynamic _searchResult;
  TextEditingController _controllerSearch = TextEditingController();

  void _showSnackBarMessage() { //aparece uma barra de aviso para digitar algo a ser pesquisado
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
      body: Column(
        children: [
          const SizedBox(height: 34.0),
          SearchBar(
            controllerText: _controllerSearch,
            onTextChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },

            searchPressed: _searchBooks,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
                child: Text(
                  'Categorias',
                  style: AppTextStyles.categoriesText
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CategoryBar(
              selectCategoryIndex: 1,
              categorySelected: (index) {
                Center(
                  child: Text('Testando')
                );
              },
           )
          ),
          //Lista os livros encontrados na busca via API
          SearchResults(searchResult: _searchResult)
        ],
      ),
    );
  }
}