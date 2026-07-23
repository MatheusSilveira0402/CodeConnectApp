import '../storage/local_storage.dart';
import '../storage/secure_local_storage.dart';

/// Fachada de conveniência para o token de autenticação.
///
/// Não sabe *como* os dados são persistidos — só delega pra um
/// [ILocalStorage]. Pra trocar flutter_secure_storage por outra lib no
/// futuro, só [SecureLocalStorage] precisa mudar; esta classe e todos os
/// seus consumidores (repositórios, interceptors) continuam iguais.
class SecureStorage {
  static ILocalStorage _storage = SecureLocalStorage();
  static const _tokenKey = 'auth_token';

  /// Permite injetar outra implementação de [ILocalStorage] (ex: em testes).
  static void setStorage(ILocalStorage storage) {
    _storage = storage;
  }

  /// Salva o token de autenticação de forma segura
  static Future<void> saveToken(String token) {
    return _storage.save(_tokenKey, token);
  }

  /// Recupera o token de autenticação armazenado
  static Future<String?> getToken() {
    return _storage.read(_tokenKey);
  }

  /// Remove o token de autenticação do armazenamento
  static Future<void> deleteToken() {
    return _storage.delete(_tokenKey);
  }

  /// Verifica se existe um token armazenado
  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }
}
