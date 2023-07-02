import 'package:minha_estante/commom/constants/api_key.dart';
import 'package:minha_estante/commom/constants/books_api_error.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class BooksApi {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const String apiKey = ApiKeys.booksApiKey;

  static Future<dynamic> search(String query) async {
    final url = '$_baseUrl?q=$query&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body;
  }

  // Função responsável por buscar as imagens dos livros com base na categoria e na quantidade especificada.
  static Future<List<Map<String, dynamic>>> fetchBookImages(
      String categoria, int quantidade) async {
    final encodedCategoria = Uri.encodeQueryComponent(categoria);
    final url =
        '$_baseUrl?q=$encodedCategoria&key=$apiKey&orderBy=newest&maxResults=$quantidade';

    final String cacheKey =
        'book_images_$categoria'; // Define a chave de cache única para as imagens dos livros da categoria

    // Obter o diretório de armazenamento temporário para o cache
    final String cacheDirectory = (await getTemporaryDirectory()).path;

    // Construir o caminho do arquivo de cache usando o cacheKey
    final cacheFilePath = '$cacheDirectory/$cacheKey.json';

    // Criar um objeto File com o caminho do arquivo de cache
    final File cacheFile = File(cacheFilePath);

    // Verifica se o arquivo de cache existe
    if (cacheFile.existsSync()) {
      // Se o arquivo existir, lê os dados em cache
      final String cachedData = await cacheFile.readAsString();

      // Decodifica os dados JSON em uma lista de mapas
      final List<Map<String, dynamic>> cachedImages =
          List<Map<String, dynamic>>.from(jsonDecode(cachedData));

      // Retorna os dados em cache
      return cachedImages;
    }

    final response = await http.get(Uri.parse(url));
    _handleError(response);

    final body = jsonDecode(response.body);
    final items = body['items'];

    // Verifica se há itens na resposta e se não estão vazios
    if (items != null && items.isNotEmpty) {
      final List<Map<String, dynamic>> bookImages = [];
      final Set<String> selectedIds = {};

      items.forEach((item) {
        final volumeInfo = item['volumeInfo'];
        final id = item['id'];

        // Verifica se o ID do livro já foi selecionado, ignorando livros duplicados
        if (selectedIds.contains(id)) {
          return; // Ignora livros já selecionados
        }

        final imageLinks = volumeInfo['imageLinks'];

        // Verifica se o livro possui uma miniatura disponível
        if (imageLinks != null && imageLinks.containsKey('smallThumbnail')) {
          final thumbnailUrl = imageLinks['smallThumbnail'];

          // Cria um mapa com a URL da miniatura e o ID do livro
          final bookData = {
            'thumbnailUrl': thumbnailUrl,
            'id': id,
          };

          // Adiciona o mapa à lista de imagens de livros
          bookImages.add(bookData);

          // Adiciona o ID do livro aos IDs selecionados
          selectedIds.add(id);
        }

        // Interrompe o loop quando a quantidade desejada de imagens de livros é atingida
        if (bookImages.length == quantidade) {
          return;
        }
      });

      // Verifica se não foram encontrados livros correspondentes à categoria
      if (bookImages.isEmpty) {
        throw Exception(BooksApiError.noBooksFound);
      }

      // Salva os dados em cache
      cacheFile.writeAsString(jsonEncode(bookImages));

      // Retorna os dados buscados na API
      return bookImages;
    } else {
      // Lança uma exceção caso não sejam encontrados itens na resposta
      throw Exception(BooksApiError.noBooksFound);
    }
  }

  static Future<BookModel> fetchBookDetails(String bookId) async {
    final url = '$_baseUrl/$bookId?key=$apiKey';
    final response = await http.get(Uri.parse(url));
    _handleError(response);

    final body = jsonDecode(response.body);

    // Cria um objeto BookModel a partir do mapa retornado na resposta
    return BookModel.fromMap(body);
  }

  static void _handleError(http.Response response) {
    if (response.statusCode == 200) {
      return;
    }

    // Verifica o código de status da resposta
    if (response.statusCode == 404) {
      // Lança uma exceção caso nenhum livro seja encontrado
      throw Exception(BooksApiError.noBooksFound);
    } else if (response.statusCode == 500) {
      // Lança uma exceção caso haja falha ao carregar as imagens dos livros
      throw Exception(BooksApiError.failedToLoadImages);
    } else {
      // Lança uma exceção com uma mensagem de erro desconhecido
      throw Exception('${BooksApiError.unknownError}: ${response.statusCode}');
    }
  }
}
