import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  const SecureStorage();

  final _secureStorage = const FlutterSecureStorage();

  // Escreve um valor no armazenamento seguro
  Future<void> write({required String key, String? value,}) async {
    await _secureStorage.write(
      key: key,
      value: value,
    );
  }

  // Lê um valor específico do armazenamento seguro
  Future<String?> readOne({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // Lê todos os valores do armazenamento seguro
  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll();
  }

  // Exclui um valor específico do armazenamento seguro
  Future<void> deleteOne({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  // Exclui todos os valores do armazenamento seguro
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  // Atualiza um valor específico no armazenamento seguro
  Future<void> update({required String key, required String newValue}) async {
    await _secureStorage.write(
      key: key, 
      value: newValue
    );
  }

}
