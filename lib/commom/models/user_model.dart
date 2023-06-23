// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  // Converte o objeto BookModel em um mapa
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Constrói um objeto UserModel a partir de um mapa
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  // Converte o objeto userModel em uma string JSON
  String toJson() => json.encode(toMap());
  // Constrói um objeto UserModel a partir de uma string JSON
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
