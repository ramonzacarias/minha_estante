import 'dart:convert';

import 'package:http/http.dart' as http;

class BooksApi {
  //classe de conexão e comunicação com a API do Google Livros

  static const _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  static Future<dynamic> search(String query) async {
    
    final url = '$_baseUrl?q=$query&key=AIzaSyA6X1mgYYAu_eTMegHgUX55E0Untsyqrao';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    return body; 
  }

}