import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class BooksApi {
  //classe de conexão e comunicação com a API do Google Livros

  static const _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const apiKey = 'AIzaSyA6X1mgYYAu_eTMegHgUX55E0Untsyqrao'; //

  static Future<dynamic> search(String query) async {
    final url = '$_baseUrl?q=$query&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body;
  }

  Future<List<String>> fetchBookImages(String categoria, int quantidade) async {
    final encodedCategoria = Uri.encodeQueryComponent(categoria);
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$encodedCategoria&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final items = body['items'];
      if (items != null && items.isNotEmpty) {
        final random = Random();
        final bookImages = <String>[];
        final selectedIndices =
            Set<int>(); // Usamos um conjunto para garantir valores únicos
        int totalItems = items.length;

        // Verificar se há mais itens disponíveis do que a quantidade solicitada
        if (quantidade > totalItems) {
          throw Exception(
              'Quantidade solicitada maior do que a quantidade de itens disponíveis');
        }

        while (bookImages.length < quantidade) {
          int index;
          do {
            index = random.nextInt(totalItems); // Gerar um novo índice
          } while (selectedIndices
              .contains(index)); // Verificar se o índice já foi selecionado

          selectedIndices
              .add(index); // Adicionar o índice ao conjunto de selecionados

          final item = items[index];
          final volumeInfo = item['volumeInfo'];
          final imageLinks = volumeInfo['imageLinks'];
          if (imageLinks != null && imageLinks.containsKey('thumbnail')) {
            final thumbnailUrl = imageLinks['thumbnail'];
            bookImages.add(thumbnailUrl);
          }

          // Se não há mais itens únicos suficientes, reiniciar o conjunto de selecionados
          if (selectedIndices.length == totalItems) {
            selectedIndices.clear();
          }
        }
        return bookImages;
      } else {
        throw Exception('Nenhum livro encontrado');
      }
    } else {
      throw Exception('Falha ao carregar as imagens dos livros');
    }
  }
}
