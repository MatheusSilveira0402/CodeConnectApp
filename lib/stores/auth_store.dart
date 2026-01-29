import 'package:mobx/mobx.dart';
import '../core/exceptions/api_exception.dart';
import '../core/utils/app_logger.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

part 'auth_store.g.dart';

/// Store para gerenciar autenticação do usuário
// ignore: library_private_types_in_public_api
class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final IUserRepository _userRepository;

  _AuthStore(this._userRepository);

  @observable
  UserModel? currentUser;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isAuthenticated = false;

  @computed
  bool get hasError => errorMessage != null;

  @action
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;

    try {
      currentUser = await _userRepository.login(email, password);
      isAuthenticated = true;
      AppLogger.info('Login realizado: ${currentUser?.email}', 'AuthStore');
      return true;
    } on ApiException catch (e, stackTrace) {
      errorMessage = e.message;
      AppLogger.error('Falha no login', e, stackTrace, 'AuthStore');
      return false;
    } catch (e, stackTrace) {
      const message = 'Erro ao fazer login. Tente novamente.';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'AuthStore');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    errorMessage = null;

    try {
      currentUser = await _userRepository.register(name, email, password);
      isAuthenticated = true;
      AppLogger.info('Registro realizado: ${currentUser?.email}', 'AuthStore');
      return true;
    } on ApiException catch (e, stackTrace) {
      errorMessage = e.message;
      AppLogger.error('Falha no registro', e, stackTrace, 'AuthStore');
      return false;
    } catch (e, stackTrace) {
      const message = 'Erro ao criar conta. Tente novamente.';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'AuthStore');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _userRepository.logout();
      currentUser = null;
      isAuthenticated = false;
      AppLogger.info('Logout realizado', 'AuthStore');
    } on ApiException catch (e, stackTrace) {
      errorMessage = e.message;
      AppLogger.error('Falha no logout', e, stackTrace, 'AuthStore');
    } catch (e, stackTrace) {
      const message = 'Erro ao fazer logout.';
      errorMessage = message;
      AppLogger.error(message, e, stackTrace, 'AuthStore');
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  @action
  void reset() {
    currentUser = null;
    isAuthenticated = false;
    errorMessage = null;
    isLoading = false;
  }
}
