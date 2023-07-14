import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/constants/books_api.dart';

import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/custom_search_bar.dart';
import 'package:minha_estante/commom/widgets/favorite_bar.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';
import 'package:minha_estante/features/book_detail/book_detail.dart';
import 'package:minha_estante/services/user_library_service.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  UserLibraryService _userLibraryService = UserLibraryService();
  late String listaAtual = BookReadingStatus.lendo;

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

  Future<dynamic> _searchBooks() async {
    if (_searchQuery.isEmpty) {
      _showSnackBarMessage();
      return null;
    }
    final dynamic result = await BooksApi.search(_searchQuery);
    setState(() {
      _searchResult = result;
    });
    // Abre a tela de Resultados de Pesquisa
    if (_searchResult != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchResults(
                    searchResult: result,
                    context: context,
                  )));
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

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, NamedRoute.splash);
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                CustomSearchBar(
                    controllerText: _controllerSearch,
                    onTextChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    searchPressed: _searchBooks),
                SizedBox(height: 10.0),
                FavoriteBar(
                  onStatusSelected: (status) {
                    setState(() {
                      listaAtual = status;
                    });
                  },
                ),
                SizedBox(height: 5.0),
                FutureBuilder<List<BookModel>>(
                  future: listaAtual == BookReadingStatus.todos
                      ? _userLibraryService.getAllBooks()
                      : _userLibraryService.getBooksByStatusLibrary(listaAtual),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final bookList = snapshot.data!;
                      final displayedBooks = bookList.toList();

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: displayedBooks.length,
                          itemBuilder: (context, index) {
                            final bookData = displayedBooks[index];
                            final imageUrl = bookData.imageUrl;
                            final bookId = bookData.id;
                            return GestureDetector(
                              onTap: () {
                                _navigateToBookDetail(bookId);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  color: Colors.grey[200],
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                      imageUrl,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                          'Erro ao carregar as imagens dos livros');
                    } else {
                      return Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      );
}
