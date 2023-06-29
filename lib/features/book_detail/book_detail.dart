import 'package:flutter/material.dart';
import 'package:minha_estante/commom/widgets/custom_show_book.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomShowBook(
          ),
        ],
      ),
    );
  }
}
