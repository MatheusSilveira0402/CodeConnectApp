import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'local_storage.dart';

/// Implementação de [ILocalStorage] para dados sensíveis (ex: token JWT),
/// usando Keychain no iOS e KeyStore no Android via flutter_secure_storage.
class SecureLocalStorage implements ILocalStorage {
  final FlutterSecureStorage _storage;

  SecureLocalStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> save(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }
}
