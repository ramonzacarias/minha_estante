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

  Future<void> addBookToLibrary(String userID, BookModel book) async {
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
        'statusLeitura': book.statusLeitura, // Exemplo de atributo específico
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

  Future<void> updateBookInLibrary(String userID, BookModel book) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(book.id)
          .update({
        'titulo': book.titulo,
        'autor': book.autor,
        'qtdpaginas': book.qtdPaginas,
        'descricao': book.descricao,
        'imageUrl': book.imageUrl,
        'textSnippet': book.textSnippet,
        'genero': book.genero,
        'statusLeitura': book.statusLeitura,
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

  Future<void> updateBookStatus(
      String userID, String bookID, String status) async {
    try {
      await _firestore
          .collection('users')
          .doc(userID)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(bookID)
          .update({
        'statusLeitura': status,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkBookExists(String userId, String bookId) async {
    try {
      final DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('biblioteca')
          .doc('livros')
          .collection('livros')
          .doc(bookId)
          .get();

      return snapshot.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<String> getBookStatus(String userID, String bookID) async {
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
        return data['statusLeitura'] ?? 'Não Lido';
      } else {
        throw Exception('Livro não encontrado na biblioteca do usuário.');
      }
    } catch (e) {
      throw 'teste';
    }
  }
}
