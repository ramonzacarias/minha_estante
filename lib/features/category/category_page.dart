import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/features/book_detail/book_detail.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> _fetchBookImagesCategory(
        String category, int quantity) async {
      try {
        final bookDataList =
            await BooksApi.fetchBookImagesCategory(category, quantity);
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, NamedRoute.splash);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.white,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, NamedRoute.home);
            },
          ),
          title: Text(
            categoryName,
            style: AppTextStyles.mediumText18.copyWith(color: AppColors.white),
          ),
          backgroundColor: AppColors.greenTwo,
          centerTitle: true,
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchBookImagesCategory(categoryName, 40),
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
              final displayedBooks = bookDataList.take(30).toList();

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: displayedBooks.length,
                  itemBuilder: (context, index) {
                    final bookData = displayedBooks[index];
                    final imageUrl = bookData['thumbnailUrl'] as String;
                    final bookId = bookData['id'] as String;
                    return GestureDetector(
                      onTap: () {
                        _navigateToBookDetail(bookId);
                      },
                      child: Container(
                        height: 800, // Defina a altura desejada aqui
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
      ),
    );
  }
}
