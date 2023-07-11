import 'package:flutter/material.dart';
import 'package:minha_estante/services/user_library_service.dart';

abstract class ProfileState<T extends StatefulWidget> extends State<T> {
  final UserLibraryService _userLibraryService = UserLibraryService();
  Stream<int>? booksReadCountStream;
  Stream<int>? booksToReadCountStream;
  Stream<int>? booksAbandonedCountStream;
  Stream<int>? booksBeingReadCountStream;
  Stream<int>? totalBooksCountStream;

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      String userId = await _userLibraryService.getUserId();
      booksReadCountStream =
          _userLibraryService.getBooksReadCountStream(userId);
      booksToReadCountStream =
          _userLibraryService.getBooksToReadCountStream(userId);
      booksAbandonedCountStream =
          _userLibraryService.getBooksAbandonedCountStream(userId);
      booksBeingReadCountStream =
          _userLibraryService.getBooksBeingReadCountStream(userId);
      totalBooksCountStream =
          _userLibraryService.getTotalBooksCountStream(userId);
      setState(() {});
    } catch (e) {
      print('Erro ao carregar as estatísticas: $e');
    }
  }
}
