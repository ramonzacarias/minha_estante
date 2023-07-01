import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/books_api.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/custom_show_book.dart';

class BookDetail extends StatelessWidget {
  final String bookId;

  const BookDetail({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookModel>(
      future: BooksApi.fetchBookDetails(bookId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final book = snapshot.data!;

          return Scaffold(
            body: Stack(
              children: [
                CustomShowBook(book: book),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Erro ao carregar os detalhes do livro'),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}