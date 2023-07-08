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

  // Adiciona um livro à biblioteca do usuário
  Future<void> addBookToLibrary(
      String userId, BookModel book, String readingStatus) async {
    try {
      await _firestore
          .collection(_users)
          .doc()
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .set({
        'id': book.id,
        'titulo': book.titulo,
        'autor': book.autor,
        'qtdpaginas': book.qtdPaginas,
        'descricao': book.descricao,
        'imageUrl': book.imageUrl,
        'textSnippet': book.textSnippet,
        'genero': book.genero,
        'statusLeitura': readingStatus,
        'pgLidas': book.pgLidas,
        'nota': book.nota,
      });
    } catch (e) {
      throw e;
    }
  }

  // Obtém um livro da biblioteca do usuário
  Future<BookModel> getBookFromLibrary(String userId, String bookId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(bookId)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return BookModel.fromMap(data);
      } else {
        throw Exception('Livro não encontrado na biblioteca do usuário.');
      }
    } catch (e) {
      throw e;
    }
  }

  // Atualiza o status de leitura de um livro com o número de páginas lidas
  Future<void> updateReadingStatus(String userId, BookModel book,
      String readingStatus, int pagesRead) async {
    try {
      await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .set({
        'id': book.id,
        'titulo': book.titulo,
        'autor': book.autor,
        'qtdpaginas': book.qtdPaginas,
        'descricao': book.descricao,
        'imageUrl': book.imageUrl,
        'textSnippet': book.textSnippet,
        'genero': book.genero,
        'statusLeitura': readingStatus,
        'pgLidas': pagesRead,
      });
    } catch (e) {
      throw e;
    }
  }

  // Obtém a página atual de leitura de um livro
  Future<int> getReadingPages(BookModel book) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_users)
          .doc(getUserId())
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['pgLidas'];
      } else {
        return book.pgLidas;
      }
    } catch (e) {
      return book.pgLidas;
    }
  }

  // Atualiza a nota de um livro
  Future<void> updateRating(String userId, BookModel book, String readingStatus,
      int pagesRead, int rating) async {
    try {
      await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .set({
        'id': book.id,
        'titulo': book.titulo,
        'autor': book.autor,
        'qtdpaginas': book.qtdPaginas,
        'descricao': book.descricao,
        'imageUrl': book.imageUrl,
        'textSnippet': book.textSnippet,
        'genero': book.genero,
        'statusLeitura': readingStatus,
        'pgLidas': pagesRead,
        'nota': rating,
      });
    } catch (e) {
      throw e;
    }
  }

  // Obtém a nota de um livro
  Future<int> getRating(BookModel book) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_users)
          .doc(getUserId())
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['nota'];
      } else {
        return book.nota;
      }
    } catch (e) {
      return book.nota;
    }
  }

  // Atualiza o status e a nota de um livro
  Future<void> updateBookStatus(
      String userId, BookModel book, String readingStatus, int rating) async {
    try {
      await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .set({
        'id': book.id,
        'titulo': book.titulo,
        'autor': book.autor,
        'qtdpaginas': book.qtdPaginas,
        'descricao': book.descricao,
        'imageUrl': book.imageUrl,
        'textSnippet': book.textSnippet,
        'genero': book.genero,
        'statusLeitura': readingStatus,
        'pgLidas': book.pgLidas,
        'nota': rating,
      });
    } catch (e) {
      throw e;
    }
  }

  // Obtém o status de um livro na biblioteca do usuário
  Future<String> getBookStatus(BookModel book) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection(_users)
          .doc(getUserId())
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(book.id)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['statusLeitura'];
      } else {
        return book.statusLeitura;
      }
    } catch (e) {
      return book.statusLeitura;
    }
  }

  // Remove um livro da biblioteca do usuário
  Future<void> removeBookFromLibrary(String userId, String bookId) async {
    try {
      await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .doc(bookId)
          .delete();
    } catch (e) {
      throw e;
    }
  }

  // Retorna a quantidade de livros lidos por um usuário
  Future<int> getBooksReadCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .where('statusLeitura', isEqualTo: BookReadingStatus.lido)
          .get();

      return snapshot.size;
    } catch (e) {
      throw e;
    }
  }

  // Retorna a quantidade de livros que um usuário deseja ler
  Future<int> getBooksToReadCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .where('statusLeitura', isEqualTo: BookReadingStatus.queroLer)
          .get();

      return snapshot.size;
    } catch (e) {
      throw e;
    }
  }

  // Retorna a quantidade de livros abandonados por um usuário
  Future<int> getBooksAbandonedCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .where('statusLeitura', isEqualTo: BookReadingStatus.abandonei)
          .get();

      return snapshot.size;
    } catch (e) {
      throw e;
    }
  }

  // Retorna a quantidade de livros sendo lidos por um usuário
  Future<int> getBooksBeingReadCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .where('statusLeitura', isEqualTo: BookReadingStatus.lendo)
          .get();

      return snapshot.size;
    } catch (e) {
      throw e;
    }
  }

  // Retorna o total de livros na biblioteca de um usuário
  Future<int> getTotalBooksCount(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_users)
          .doc(userId)
          .collection(_biblioteca)
          .doc(_livros)
          .collection(_livros)
          .get();

      return snapshot.size;
    } catch (e) {
      throw e;
    }
  }
}
