import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/commom/constants/firestore_colletions.dart';

import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/custom_search_bar.dart';
import 'package:minha_estante/commom/widgets/search_result.dart';
import 'package:minha_estante/features/book_detail/book_detail.dart';
import 'package:minha_estante/services/user_library_service.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserLibraryService _userLibraryService = UserLibraryService();
  final String _users = FirestoreCollections.users;
  final String _biblioteca = FirestoreCollections.biblioteca;
  final String _livros = FirestoreCollections.livros;
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

  Future<List<BookModel>> getBooksByStatus(String status) async {
    try {
      String userId = await _userLibraryService.getUserId();
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .where('statusLeitura', isEqualTo: status)
          .get();

      final List<BookModel> books = [];

      for (final DocumentSnapshot doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final book = BookModel(
          id: data['id'],
          titulo: data['titulo'],
          autor: data['autor'],
          qtdPaginas: data['qtdpaginas'] as int? ?? 0,
          descricao: data['descricao'],
          imageUrl: data['imageUrl'],
          textSnippet: data['textSnippet'],
          genero: data['genero'],
          statusLeitura: data['statusLeitura'],
          pgLidas: data['pgLidas'] as int? ?? 0,
          nota: data['nota'] as int? ?? 0,
        );
        books.add(book);
      }

      return books;
    } catch (e) {
      throw e;
    }
  }

  Future<List<BookModel>> getAllBooks() async {
    try {
      String userId = await _userLibraryService.getUserId();
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .get();

      final List<BookModel> books = [];

      for (final DocumentSnapshot doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final book = BookModel(
          id: data['id'],
          titulo: data['titulo'],
          autor: data['autor'],
          qtdPaginas: data['qtdpaginas'] as int? ?? 0,
          descricao: data['descricao'],
          imageUrl: data['imageUrl'],
          textSnippet: data['textSnippet'],
          genero: data['genero'],
          statusLeitura: data['statusLeitura'],
          pgLidas: data['pgLidas'] as int? ?? 0,
          nota: data['nota'] as int? ?? 0,
        );
        books.add(book);
      }

      return books;
    } catch (e) {
      throw e;
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
                  searchPressed: _searchBooks,
                ),
                SearchResults(searchResult: _searchResult),
                SizedBox(height: 15.0),
                FavoriteBar(
                  onStatusSelected: (status) {
                    setState(() {
                      listaAtual = status;
                    });
                  },
                ),
                SizedBox(height: 5.0),
                FutureBuilder<List<BookModel>>(
                  future: listaAtual == BookReadingStatus.todos ? getAllBooks() : getBooksByStatus(listaAtual),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final bookList = snapshot.data!;
                      final displayedBooks = bookList.take(30).toList();

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

class FavoriteBar extends StatefulWidget {
  final void Function(String) onStatusSelected;

  const FavoriteBar({Key? key, required this.onStatusSelected});

  @override
  State<FavoriteBar> createState() => _FavoriteBarState();
}

class _FavoriteBarState extends State<FavoriteBar> {
  late String selectedFavorite = BookReadingStatus.lendo;
  final List<String> favoriteStatusList = [
    BookReadingStatus.lendo,
    BookReadingStatus.queroLer,
    BookReadingStatus.lido,
    BookReadingStatus.abandonei,
    BookReadingStatus.todos,
  ];

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      showSelectedIcon: false,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.greenTwo;
            }
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return AppColors.greenTwo;
          },
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: AppColors.greenTwo,
            width: 1.0,
          ),
        ),
      ),
      segments: favoriteStatusList.map((status) {
        return ButtonSegment<String>(
          value: status,
          label: Text(
            status,
            style: AppTextStyles.extraSmallText,
          ),
        );
      }).toList(),
      selected: {selectedFavorite},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          selectedFavorite = newSelection.first;
          widget.onStatusSelected(selectedFavorite);
        });
      },
    );
  }
}
