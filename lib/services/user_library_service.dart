import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLibraryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getUserId() {
    final User? user = _auth.currentUser;
    final String userId = user?.uid ?? '';
    return userId;
  }

  Future<void> addBookToLibrary(
      String userID, BookModel book, String statusLeitura) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
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
        'statusLeitura': statusLeitura,
        'pgLidas': book.pgLidas,
        'nota': book.nota,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<BookModel> getBookFromLibrary(String userID, String bookID) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(bookID)
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

  Future<void> updateReading(
      String userID, BookModel book, String statusLeitura, int pgLidas) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
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
        'statusLeitura': statusLeitura,
        'pgLidas': pgLidas,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateRating(String userID, BookModel book, String statusLeitura,
      int pgLidas, int nota) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
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
        'statusLeitura': statusLeitura,
        'pgLidas': pgLidas,
        'nota': nota,
      });
    } catch (e) {
      throw e;
    }
  }

    Future<void> updateBookStatus(String userID, BookModel book, String statusLeitura, int nota) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
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
        'statusLeitura': statusLeitura,
        'pgLidas': book.pgLidas,
        'nota': nota,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeBookFromLibrary(String userID, String bookID) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(bookID)
          .delete();
    } catch (e) {
      throw e;
    }
  }


  Future<String> getBookStatus(BookModel book) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(getUserId())
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(book.id)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['statusLeitura'];
      } else {
        return book.statusLeitura;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<int> getReadingPg(BookModel book) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(getUserId())
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(book.id)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['pgLidas'];
      } else {
        return book.pgLidas;
      }
    } catch (e) {
      return book.nota;
    }
  }

  Future<int> getNota(BookModel book) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(getUserId())
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
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
}
