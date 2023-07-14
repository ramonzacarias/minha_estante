import 'package:flutter/material.dart';
import 'package:minha_estante/services/user_library_service.dart';

abstract class ProfileState<T extends StatefulWidget> extends State<T> {
  final UserLibraryService _userLibraryService = UserLibraryService();
  Stream<int>? booksReadCountStream;
  Stream<int>? booksToReadCountStream;
  Stream<int>? booksAbandonedCountStream;
  Stream<int>? booksBeingReadCountStream;
  Stream<int>? totalBooksCountStream;

  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    loadStatistics();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    userName = await _userLibraryService.getUserName();
    userEmail = await _userLibraryService.getUserEmail();
    setState(() {});
  }

  Future<void> loadStatistics() async {
    try {
      booksReadCountStream = _userLibraryService.getBooksReadCountStream();
      booksToReadCountStream = _userLibraryService.getBooksToReadCountStream();
      booksAbandonedCountStream =
          _userLibraryService.getBooksAbandonedCountStream();
      booksBeingReadCountStream =
          _userLibraryService.getBooksBeingReadCountStream();
      totalBooksCountStream = _userLibraryService.getTotalBooksCountStream();
      setState(() {});
    } catch (e) {
      print('Erro ao carregar as estatísticas: $e');
    }
  }
}
