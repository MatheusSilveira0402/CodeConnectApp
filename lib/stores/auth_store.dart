import 'package:mobx/mobx.dart';
import '../core/exceptions/api_exception.dart';
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
      print(currentUser);
      isAuthenticated = true;
      return true;
    } on ApiException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (e) {
      errorMessage = 'Erro ao fazer login. Tente novamente.';
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
      return true;
    } on ApiException catch (e) {
      errorMessage = e.message;
      return false;
    } catch (e) {
      errorMessage = 'Erro ao criar conta. Tente novamente.';
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
    } on ApiException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = 'Erro ao fazer logout.';
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
