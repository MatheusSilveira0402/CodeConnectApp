/// Abstração genérica de persistência local.
///
/// O resto do app depende só desta interface — nunca de um pacote de
/// storage específico (flutter_secure_storage, shared_preferences, etc).
/// Trocar a implementação por outra lib no futuro deve exigir mudar
/// apenas a classe que implementa [ILocalStorage], nada mais.
abstract class ILocalStorage {
  Future<void> save(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
}
