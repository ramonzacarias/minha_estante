import 'package:flutter/material.dart';

import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/widgets/custom_search_bar.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/commom/widgets/category_bar.dart';

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

  // Exibe uma mensagem em forma de SnackBar
  void _showSnackBarMessage() {
    final snackBar = SnackBar(
      content: Text('Digite algum título para que seja pesquisado'),
      backgroundColor: AppColors.graffite,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Realiza a busca de livros com base na consulta de pesquisa
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

  // Obtém as imagens dos livros para uma determinada categoria
  Future<List<String>> _fetchBookImages(String category, int quantity) async {
    try {
      final bookImages = await BooksApi().fetchBookImages(category, quantity);
      return bookImages;
    } catch (e) {
      print('Erro ao carregar as imagens dos livros: $e');
      return [];
    }
  }

  // Constrói a seção de categorias com base em uma determinada categoria
  Widget buildCategorySection(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              category,
              style: AppTextStyles.categoriesText,
            ),
          ),
        ),
        FutureBuilder<List<String>>(
          future: _fetchBookImages(category, 8),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Exibe um indicador de loading enquanto as imagens são carregadas
              return Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              final bookImages = snapshot.data!;
              // Exibe uma lista horizontal de imagens dos livros
              return Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookImages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = bookImages[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, NamedRoute.bookDetail);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, top: 15.0, bottom: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              // Exibe uma mensagem de erro caso ocorra um erro ao carregar as imagens
              return Text('Erro ao carregar as imagens dos livros');
            } else {
              // Exibe um indicador de progresso caso nenhuma imagem seja encontrada
              return Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  // Lista de categorias para a tela de home
  @override
  Widget build(BuildContext context) {
    final categories = [
      'Fantasia',
      'Terror',
      'Contos',
      'Drama',
      'História',
      'Romance',
      'Sci-fi'
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categorias',
                  style: AppTextStyles.categoriesText,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CategoryBar(
                categories: categories,
                selectCategoryIndex: _selectCategoryIndex,
                categorySelected: (index) {
                  setState(() {
                    _selectCategoryIndex = index;
                  });
                },
              ),
            ),
            // Mapeia as categorias para a construção das seções de categorias
            ...categories.map(buildCategorySection).toList(),
            // Exibe os resultados da pesquisa
            SearchResults(searchResult: _searchResult),
          ],
        ),
      ),
    );
  }
}
