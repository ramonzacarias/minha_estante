import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minha_estante/commom/constants/api_key.dart';
import 'package:minha_estante/commom/models/book_model.dart';

class BooksApi {
  static const _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const apiKey = ApiKeys.booksApiKey;

  static Future<dynamic> search(String query) async {
    final url = '$_baseUrl?q=$query&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body;
  }

  static Future<List<Map<String, dynamic>>> fetchBookImages(
      String categoria, int quantidade) async {
    final encodedCategoria = Uri.encodeQueryComponent(categoria);
    final url =
        '$_baseUrl?q=$encodedCategoria&key=$apiKey&orderBy=newest&maxResults=$quantidade';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final items = body['items'];
      if (items != null && items.isNotEmpty) {
        final bookImages = <Map<String, dynamic>>[];
        final selectedIds = <String>{};

        for (int i = 0; i < items.length; i++) {
          final item = items[i];
          final volumeInfo = item['volumeInfo'];
          final id = item['id']; // Obtém o ID do livro

          if (selectedIds.contains(id)) {
            continue; // Ignora livros já selecionados
          }

          final imageLinks = volumeInfo['imageLinks'];
          if (imageLinks != null && imageLinks.containsKey('smallThumbnail')) {
            final thumbnailUrl = imageLinks['smallThumbnail'];
            final bookData = {
              'thumbnailUrl': thumbnailUrl,
              'id': id,
            };
            bookImages.add(bookData);
            selectedIds.add(id);
          }

          if (bookImages.length == quantidade) {
            break; // Interrompe o loop quando a quantidade desejada é atingida
          }
        }

        if (bookImages.isEmpty) {
          throw Exception('Nenhum livro encontrado');
        }

        return bookImages;
      } else {
        throw Exception('Nenhum livro encontrado');
      }
    } else {
      throw Exception('Falha ao carregar as imagens dos livros');
    }
  }

  static Future<BookModel> fetchBookDetails(String bookId) async {
    final url = '$_baseUrl/$bookId?key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final volumeInfo = body['volumeInfo'];
      final searchInfo = body['searchInfo'];

      final book = BookModel(
        id: bookId,
        titulo: volumeInfo['title'] ?? 'Título desconhecido',
        autor: volumeInfo['authors'] != null
            ? volumeInfo['authors'][0]
            : 'Autor desconhecido',
        qtdPaginas: volumeInfo['pageCount'],
        descricao: volumeInfo['description'] ?? 'Descrição indisponível',
        textSnippet: searchInfo != null
            ? searchInfo['textSnippet'] ?? 'Trecho indisponível'
            : 'Trecho indisponível',
        imageUrl: volumeInfo['imageLinks']?['thumbnail'] ??
            'URL da imagem indisponível',
        categoria: volumeInfo['categories'] != null
            ? volumeInfo['categories'][0] ?? 'Categoria desconhecida'
            : 'Categoria desconhecida',
      );
      return book;
    } else {
      throw Exception('Falha ao carregar os detalhes do livro');
    }
  }
}
