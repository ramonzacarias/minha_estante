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
  int _selectCategoryIndex = -1;

  void _showSnackBarMessage() { //aparece uma barra de aviso para digitar algo a ser pesquisado
    final snackBar = SnackBar(
      content: Text('Digite algum título para que seja pesquisado'),
      backgroundColor: AppColors.graffite,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _searchBooks() async { //faz busca dos livros na API
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
      body: SingleChildScrollView(
        child: Column(
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
              categories: ['Tecnologia', 'Contos', 'Ficção Científica', 'Terror/Horror', 'Drama', 'Educação'],
              selectCategoryIndex: _selectCategoryIndex,
              categorySelected: (index) {
                setState(() {
                  _selectCategoryIndex = index;
                });
              },
           )
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
                child: Text(
                  'Fantasias',
                  style: AppTextStyles.categoriesText
              ),
            )
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final booksResultsURL = [
                  'http://books.google.com/books/content?id=SqjxBDkL0dEC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=iQdcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=2VK3EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=naVIEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=0dlUAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'
                ];

                return Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        booksResultsURL[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
                child: Text(
                  'Terror',
                  style: AppTextStyles.categoriesText
              ),
            )
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final booksResultsURL = [
                  'http://books.google.com/books/content?id=BJ-moBFnCKgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=0zykDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=TKEwBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=sl5CDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=y1NYEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'
                ];

                return Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        booksResultsURL[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
                child: Text(
                  'Contos',
                  style: AppTextStyles.categoriesText
              ),
            )
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final booksResultsURL = [
                  'http://books.google.com/books/content?id=SO8jyAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api',
                  'http://books.google.com/books/content?id=-KlvMBX0L-EC&printsec=frontcover&img=1&zoom=1&source=gbs_api',
                  'http://books.google.com/books/content?id=hY2OF0Yj3cQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=mBHdAgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
                  'http://books.google.com/books/content?id=t6QwCgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'
                ];

                return Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        booksResultsURL[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                );
              },
            ),
          ),
          //Lista os livros encontrados na busca via API
          SearchResults(searchResult: _searchResult)
        ],
      ),
      ) 
    );
  }
}