import 'package:code_connect/core/storage/local_storage.dart';

/// Implementação em memória de [ILocalStorage] para testes — não toca em
/// nenhum storage real (nem secure_storage, nem shared_preferences).
class MockLocalStorage implements ILocalStorage {
  final Map<String, String> _store = {};

  @override
  Future<void> save(String key, String value) async {
    _store[key] = value;
  }

  @override
  Future<String?> read(String key) async {
    return _store[key];
  }

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }
}
