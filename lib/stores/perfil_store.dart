import 'package:mobx/mobx.dart';
import '../core/utils/app_logger.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

part 'perfil_store.g.dart';

/// Store para gerenciar o estado do perfil do usuário
// ignore: library_private_types_in_public_api
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
      AppLogger.info('Perfil carregado: ${user?.name}', 'PerfilStore');
    } catch (e, stackTrace) {
      const message = 'Erro ao carregar perfil';
      errorMessage = message;
      user = null;
      AppLogger.error(message, e, stackTrace, 'PerfilStore');
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
      AppLogger.info('Avatar atualizado', 'PerfilStore');
    } catch (e, stackTrace) {
      const message = 'Erro ao atualizar avatar';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'PerfilStore');
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }
}
