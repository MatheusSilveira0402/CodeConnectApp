import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Gerenciador de armazenamento seguro para dados sensíveis
///
/// Utiliza flutter_secure_storage para armazenar tokens de autenticação
/// de forma segura no dispositivo (Keychain no iOS, KeyStore no Android)
class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  /// Salva o token de autenticação de forma segura
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Recupera o token de autenticação armazenado
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Remove o token de autenticação do armazenamento
  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// Verifica se existe um token armazenado
  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }
}
