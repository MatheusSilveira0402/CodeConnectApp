import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

/// Implementação de [ILocalStorage] para configurações não sensíveis de UI
/// (ex: tema claro/escuro, idioma preferido), usando shared_preferences.
class SharedPreferencesLocalStorage implements ILocalStorage {
  @override
  Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
