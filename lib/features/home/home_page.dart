import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/widgets/custom_search_bar.dart';
import 'package:minha_estante/commom/widgets/category_bar.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/features/book_detail/book_detail.dart';

import '../search/search_result.dart';

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
    // Mostra uma mensagem na parte inferior da tela informando que é necessário digitar um título para a pesquisa
    final snackBar = SnackBar(
      content: Text('Digite algum título para ser pesquisado'),
      backgroundColor: AppColors.graffite,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> _searchBooks() async {
    // Verifica se o campo de pesquisa está vazio
    if (_searchQuery.isEmpty) {
      _showSnackBarMessage();
      return null;
    }
    // Realiza a pesquisa de livros com base na query fornecida
    final result = await BooksApi.search(_searchQuery);
    setState(() {
      _searchResult = result;
    });
    // Abre a tela de Resultados de Pesquisa se houver algum resultado
    if (_searchResult != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResults(
            searchResult: result,
            context: context,
          ),
        ),
      );
    }
  }

  Future<List<Map<String, dynamic>>> _fetchBookImages(
      String category, int quantity) async {
    try {
      // Obtém uma lista de imagens de livros para a categoria fornecida
      final bookDataList = await BooksApi.fetchBookImages(category, quantity);
      return bookDataList;
    } catch (e) {
      print('Erro ao carregar as imagens dos livros: $e');
      return [];
    }
  }

  void _navigateToBookDetail(String bookId) {
    // Navega para a tela de detalhes do livro com base no ID fornecido
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetail(bookId: bookId),
      ),
    );
  }

  // Função para tratar o botão nativo do aparelho, volta para a página Splash
  Future<bool> _onWillPop() async {
    Navigator.popAndPushNamed(context, NamedRoute.splash);
    return false;
  }

  Widget buildCategorySection(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              category,
              style: AppTextStyles.categoriesText,
            ),
          ),
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchBookImages(category, 15),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Exibe um indicador de progresso enquanto as imagens dos livros estão sendo carregadas
              return Container(
                height: 200,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              final bookDataList = snapshot.data!;
              final bookImages = bookDataList.map((bookData) {
                final imageUrl = bookData['thumbnailUrl'] as String;
                // Faça o que for necessário com o bookId
                return imageUrl;
              }).toList();
              return Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookImages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = bookImages[index];
                    final bookData = bookDataList[index];
                    final bookId = bookData['id'] as String;
                    return GestureDetector(
                      onTap: () {
                        // Navega para a tela de detalhes do livro ao tocar na imagem
                        _navigateToBookDetail(bookId);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: Container(
                              color: Colors.grey[150],
                              child: Image(
                                // Utiliza o armazenamento do dispositivo para guardar as imagens em cache
                                image: CachedNetworkImageProvider(
                                  imageUrl,
                                ),
                                fit: BoxFit.fill,
                                width: 128.0,
                                height: 204.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              // Exibe uma mensagem de erro caso ocorra algum problema ao carregar as imagens dos livros
              return const Text('Erro ao carregar as imagens dos livros');
            } else {
              // Exibe um indicador de progresso caso nenhum dado seja recebido
              return Container(
                height: 200,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ],
    );
  }

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

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 10.0, bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Categorias',
                      style: AppTextStyles.categoriesText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                ...categories.map(buildCategorySection).toList(),
              ],
            ),
          ),
        ));
  }
}
