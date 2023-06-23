import 'dart:convert';

class BookModel {
  final String? id; // ID único do livro
  final String? titulo; // Título do livro
  final String? autor; // Autor do livro
  final int? qtdPaginas; // Número de páginas do livro
  final String? descricao; // Descrição do livro
  final String? imageUrl; // URL da imagem do livro
  final int? anoPublicacao; // Ano de publicação do livro

  BookModel({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.qtdPaginas,
    required this.descricao,
    required this.imageUrl,
    required this.anoPublicacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'qtdPaginas': qtdPaginas,
      'descricao': descricao,
      'imageUrl': imageUrl,
      'anoPublicacao': anoPublicacao,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      titulo: map['titulo'],
      autor: map['autor'],
      qtdPaginas: map['qtdPaginas'],
      descricao: map['descricao'],
      imageUrl: map['imageUrl'],
      anoPublicacao: map['anoPublicacao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));
}