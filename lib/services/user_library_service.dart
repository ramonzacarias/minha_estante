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
      await bookRef.set(
        {
          ...book.toMap(),
          'statusLeitura': readingStatus,
          'pgLidas': book.pgLidas,
          'nota': book.nota,
        },
        SetOptions(merge: true),
      );
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
      await bookRef.set(
        {
          'statusLeitura': readingStatus,
          'pgLidas': pagesRead,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      throw e;
    }
  }

  // Obtém a página atual de leitura de um livro
  Stream<int> getReadingPages(BookModel book) {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    return bookRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['pgLidas'];
      } else {
        return book.pgLidas;
      }
    });
  }

// Atualiza a nota de um livro
  Future<void> updateRating(
      BookModel book, String readingStatus, int pagesRead, int rating) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    try {
      await bookRef.set(
        book.toMap()
          ..addAll({
            'statusLeitura': readingStatus,
            'pgLidas': pagesRead,
            'nota': rating,
          }),
        SetOptions(merge: true), // Adicione esta linha
      );
    } catch (e) {
      throw e;
    }
  }

  // Obtém a nota de um livro
  Stream<int?> getRating(BookModel book) {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    return bookRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['nota'];
      } else {
        return book.nota;
      }
    });
  }

// Atualiza o status e a nota de um livro
  Future<void> updateBookStatus(
      BookModel book, String readingStatus, int rating) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    try {
      final Map<String, dynamic> bookData = {
        'statusLeitura': readingStatus,
        'nota': rating,
      };

      if (readingStatus != BookReadingStatus.abandonei) {
        bookData['pgLidas'] = book.pgLidas;
      }

      await bookRef.set(
        bookData,
        SetOptions(merge: true), // Adicione esta linha
      );
    } catch (e) {
      throw e;
    }
  }

  // Obtém o status de um livro na biblioteca do usuário
  Stream<String> getBookStatus(BookModel book) {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, book.id);

    return bookRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        return data['statusLeitura'];
      } else {
        return book.statusLeitura;
      }
    });
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

  // Obtém os livros do banco por seu status de leitura
  Future<List<BookModel>> getBooksByStatusLibrary(String status) async {
    try {
      final String userId = getUserId();
      final QuerySnapshot snapshot = await _getBooksCollection(userId)
          .where('statusLeitura', isEqualTo: status)
          .get(
              GetOptions(source: Source.serverAndCache)); // Adicione esta linha

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

  // Obtém todos os livros do banco
  Future<List<BookModel>> getAllBooks() async {
    try {
      final String userId = getUserId();
      final QuerySnapshot snapshot = await _getBooksCollection(userId).get(
          GetOptions(source: Source.serverAndCache)); // Adicione esta linha

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

  // Obtém as informações de um livro com base na ID
  Future<BookModel?> getBookById(String bookId) async {
    final String userId = getUserId();
    final DocumentReference bookRef = _getBookDocumentRef(userId, bookId);

    try {
      final DocumentSnapshot snapshot =
          await bookRef.get(GetOptions(source: Source.cache));

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final book = BookModel.fromMap(data);
        return book;
      }

      return null;
    } catch (e) {
      throw e;
    }
  }

// Obtém o nome do usuário atual
  Future<String> getUserName() async {
    final String userId = getUserId();
    final DocumentReference userRef = _firestore.collection(_users).doc(userId);
    final DocumentSnapshot snapshot = await userRef.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final String name = data['nome'] ?? '';
      return name;
    }

    return '';
  }

// Obtém o email do usuário atual
  Future<String> getUserEmail() async {
    final User? user = _auth.currentUser;
    final String userId = user?.uid ?? '';
    final DocumentReference userRef = _firestore.collection(_users).doc(userId);
    final DocumentSnapshot snapshot = await userRef.get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final String email = data['email'] ?? '';
      return email;
    }

    return '';
  }
}
