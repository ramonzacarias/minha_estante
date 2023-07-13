import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/constants/firestore_colletions.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLibraryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _users = FirestoreCollections.users;
  final String _biblioteca = FirestoreCollections.biblioteca;
  final String _livros = FirestoreCollections.livros;

  // Captura o id do usuário
  String getUserId() {
    final User? user = _auth.currentUser;
    final String userId = user?.uid ?? '';
    return userId;
  }

  // Retorna a referência para a coleção de livros do usuário
  CollectionReference _getBooksCollection(String userId) {
    return _firestore
        .collection(_users)
        .doc(userId)
        .collection(_biblioteca)
        .doc(_livros)
        .collection(_livros);
  }

  // Retorna a referência para um documento específico de livro
  DocumentReference _getBookDocumentRef(String userId, String bookId) {
    return _getBooksCollection(userId).doc(bookId);
  }

  // Retorna a consulta de livros com base no usuário e status de leitura
  Query _getBooksQuery(String userId, String status) {
    return _getBooksCollection(userId)
        .where('statusLeitura', isEqualTo: status);
  }

  // Adiciona um livro à biblioteca do usuário
  Future<void> addBookToLibrary(BookModel book, String readingStatus) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    try {
      await bookRef.set(book.toMap()
        ..addAll({
          'statusLeitura': readingStatus,
          'pgLidas': book.pgLidas,
          'nota': book.nota,
        }));
    } catch (e) {
      throw e;
    }
  }

  // Atualiza o status de leitura de um livro com o número de páginas lidas
  Future<void> updateReadingStatus(
      BookModel book, String readingStatus, int pagesRead) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    try {
      await bookRef.set(book.toMap()
        ..addAll({
          'statusLeitura': readingStatus,
          'pgLidas': pagesRead,
        }));
    } catch (e) {
      throw e;
    }
  }

  // Obtém a página atual de leitura de um livro
  Future<int> getReadingPages(BookModel book) async {
    final String userId = getUserId();
    final DocumentSnapshot doc =
        await _getBookDocumentRef(userId, book.id).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return data['pgLidas'];
    } else {
      return book.pgLidas;
    }
  }

  // Atualiza a nota de um livro
  Future<void> updateRating(
      BookModel book, String readingStatus, int pagesRead, int rating) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    try {
      await bookRef.set(book.toMap()
        ..addAll({
          'statusLeitura': readingStatus,
          'pgLidas': pagesRead,
          'nota': rating,
        }));
    } catch (e) {
      throw e;
    }
  }

  // Obtém a nota de um livro
  Future<int?> getRating(BookModel book) async {
    final String userId = getUserId();
    final DocumentSnapshot doc =
        await _getBookDocumentRef(userId, book.id).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return data['nota'];
    } else {
      return book.nota;
    }
  }

  // Atualiza o status e a nota de um livro
  Future<void> updateBookStatus(
      BookModel book, String readingStatus, int rating) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    try {
      await bookRef.set(book.toMap()
        ..addAll({
          'statusLeitura': readingStatus,
          'pgLidas': book.pgLidas,
          'nota': rating,
        }));
    } catch (e) {
      throw e;
    }
  }

  // Obtém o status de um livro na biblioteca do usuário
  Future<String> getBookStatus(BookModel book) async {
    final String userId = getUserId();
    final DocumentSnapshot doc =
        await _getBookDocumentRef(userId, book.id).get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return data['statusLeitura'];
    } else {
      return book.statusLeitura;
    }
  }

  // Remove um livro da biblioteca do usuário
  Future<void> removeBookFromLibrary(String bookId) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, bookId);

    try {
      await bookRef.delete();
    } catch (e) {
      throw e;
    }
  }

  // Retorna a quantidade de livros lidos por um usuário
  Stream<int> getBooksReadCountStream() {
    final String userId = getUserId();
    return _getBooksQuery(userId, BookReadingStatus.lido)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  // Retorna a quantidade de livros que um usuário deseja ler
  Stream<int> getBooksToReadCountStream() {
    final String userId = getUserId();
    return _getBooksQuery(userId, BookReadingStatus.queroLer)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  // Retorna a quantidade de livros abandonados por um usuário
  Stream<int> getBooksAbandonedCountStream() {
    final String userId = getUserId();
    return _getBooksQuery(userId, BookReadingStatus.abandonei)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  // Retorna a quantidade de livros sendo lidos por um usuário
  Stream<int> getBooksBeingReadCountStream() {
    final String userId = getUserId();
    return _getBooksQuery(userId, BookReadingStatus.lendo)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  // Retorna o total de livros na biblioteca de um usuário
  Stream<int> getTotalBooksCountStream() {
    final String userId = getUserId();
    return _getBooksCollection(userId)
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  // Obtém todos os livros com o mesmo status de leitura da biblioteca do usuário
  Future<List<BookModel>> getBooksByStatus(String status) async {
    final String userId = getUserId();
    final QuerySnapshot snapshot = await _getBooksQuery(userId, status).get();
    final List<BookModel> books = [];

    for (final DocumentSnapshot doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final book = BookModel.fromMap(data);
      books.add(book);
    }

    return books;
  }
}
