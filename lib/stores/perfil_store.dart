import 'package:mobx/mobx.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

part 'perfil_store.g.dart';

/// Store para gerenciar o estado do perfil do usuário
class PerfilStore = _PerfilStore with _$PerfilStore;

abstract class _PerfilStore with Store {
  final IUserRepository repository;

  _PerfilStore(this.repository);

  @observable
  UserModel? user;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get hasUser => user != null;

  @action
  Future<void> loadUserProfile() async {
    isLoading = true;
    errorMessage = null;
    try {
      user = await repository.getMe();
    } catch (e) {
      errorMessage = e.toString();
      user = _getMockUser(); // Mock para desenvolvimento
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateAvatar(String path) async {
    isLoading = true;
    errorMessage = null;
    try {
      user = await repository.updateAvatar(path);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  // Mock para desenvolvimento enquanto API não está pronta
  UserModel _getMockUser() {
    return UserModel(
      id: '1',
      name: 'Júlio Oliveira',
      email: 'julio@codeconnect.com',
      avatar: 'lib/assets/icon_logo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
