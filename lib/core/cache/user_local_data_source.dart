import 'package:hive_flutter/hive_flutter.dart';
import '../../models/user_model.dart';
import 'hive_boxes.dart';

/// Cache local do perfil do usuário logado, usado quando não há conexão
class UserLocalDataSource {
  static const _currentUserKey = 'current_user';

  Box get _box => Hive.box(HiveBoxes.userProfile);

  Future<void> saveUser(UserModel user) async {
    await _box.put(_currentUserKey, user.toJson());
  }

  UserModel? getUser() {
    final data = _box.get(_currentUserKey);
    if (data == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<void> clear() async {
    await _box.delete(_currentUserKey);
  }
}