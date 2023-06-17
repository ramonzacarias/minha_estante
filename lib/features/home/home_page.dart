import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/search_bar.dart';
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

  void _showSnackBarMessage() {
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

  Future<List<String>> _fetchBookImages(
      String categoria, int quantidade) async {
    try {
      final bookImages =
          await BooksApi().fetchBookImages(categoria, quantidade);
      return bookImages;
    } catch (e) {
      print('Erro ao carregar as imagens dos livros: $e');
      return [];
    }
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
                  style: AppTextStyles.categoriesText,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CategoryBar(
                categories: [
                  'Tecnologia',
                  'Contos',
                  'Ficção Científica',
                  'Terror/Horror',
                  'Drama',
                  'Educação'
                ],
                selectCategoryIndex: _selectCategoryIndex,
                categorySelected: (index) {
                  setState(() {
                    _selectCategoryIndex = index;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fantasias',
                  style: AppTextStyles.categoriesText,
                ),
              ),
            ),
            FutureBuilder<List<String>>(
              future: _fetchBookImages('Fantasias',
                  8), // Obtém uma lista com 5 imagens de livros de fantasia
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final bookImages = snapshot.data!;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookImages.length,
                      itemBuilder: (context, index) {
                        final imageUrl = bookImages[index];
                        return Padding(
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
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as imagens dos livros');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Terror',
                  style: AppTextStyles.categoriesText,
                ),
              ),
            ),
            // Adicione as outras categorias e trechos de código semelhantes aqui...
            FutureBuilder<List<String>>(
              future: _fetchBookImages('Terror',
                  8), // Obtém uma lista com 5 imagens de livros de fantasia
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final bookImages = snapshot.data!;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookImages.length,
                      itemBuilder: (context, index) {
                        final imageUrl = bookImages[index];
                        return Padding(
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
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as imagens dos livros');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contos',
                  style: AppTextStyles.categoriesText,
                ),
              ),
            ),
            // Adicione as outras categorias e trechos de código semelhantes aqui...
            FutureBuilder<List<String>>(
              future: _fetchBookImages('Contos',
                  8), // Obtém uma lista com 5 imagens de livros de fantasia
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final bookImages = snapshot.data!;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookImages.length,
                      itemBuilder: (context, index) {
                        final imageUrl = bookImages[index];
                        return Padding(
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
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as imagens dos livros');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Drama',
                  style: AppTextStyles.categoriesText,
                ),
              ),
            ),
            // Adicione as outras categorias e trechos de código semelhantes aqui...
            FutureBuilder<List<String>>(
              future: _fetchBookImages('Drama',
                  8), // Obtém uma lista com 5 imagens de livros de fantasia
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final bookImages = snapshot.data!;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookImages.length,
                      itemBuilder: (context, index) {
                        final imageUrl = bookImages[index];
                        return Padding(
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
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as imagens dos livros');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SearchResults(searchResult: _searchResult),
          ],
        ),
      ),
    );
  }
}
