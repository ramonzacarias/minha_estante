import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/widgets/custom_search_bar.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';
import 'package:minha_estante/commom/widgets/category_bar.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/features/book_detail/book_detail.dart';

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
      content: Text('Digite algum título para ser pesquisado'),
      backgroundColor: AppColors.graffite,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _searchBooks(String bookId) async {
    if (bookId.isEmpty) {
      _showSnackBarMessage();
      return null;
    }
    final result = await BooksApi.fetchBookDetails(bookId);
    setState(() {
      _searchResult = result;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchBookImages(
      String category, int quantity) async {
    try {
      final bookDataList = await BooksApi.fetchBookImages(category, quantity);
      return bookDataList;
    } catch (e) {
      print('Erro ao carregar as imagens dos livros: $e');
      return [];
    }
  }

  void _navigateToBookDetail(String bookId) {
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
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.fill,
                              width: 128.0,
                              height: 204.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar as imagens dos livros');
            } else {
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
                  searchPressed: () {
                    _searchBooks(_searchQuery);
                  },
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
                SearchResults(searchResult: _searchResult),
              ],
            ),
          ),
        ));
  }
}
