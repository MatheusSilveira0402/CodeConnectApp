import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cache/user_local_data_source.dart';
import '../../core/exceptions/api_exception.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/storage/local_storage.dart';
import '../../core/storage/secure_local_storage.dart';
import '../../core/utils/app_logger.dart';
import '../../repositories/user_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static const _tokenKey = 'auth_token';

  final IUserRepository _userRepository;
  final ILocalStorage _tokenStorage;
  final UserLocalDataSource _userLocalDataSource;

  AuthCubit(
    this._userRepository, [
    ILocalStorage? tokenStorage,
    UserLocalDataSource? userLocalDataSource,
  ]) : _tokenStorage = tokenStorage ?? SecureLocalStorage(),
       _userLocalDataSource = userLocalDataSource ?? UserLocalDataSource(),
       super(const AuthInitial());

  /// Usado pela SplashScreen: verifica de forma assíncrona se existe um
  /// token salvo e se ele ainda é válido, sem depender de nenhum storage
  /// real fora de [_tokenStorage] (testável com um `MockLocalStorage`).
  ///
  /// Resiliente a falhas de rede: se não der pra confirmar com o servidor
  /// (ex: sem internet), mantém a sessão com os dados salvos localmente
  /// em vez de forçar logout — só desloga de fato quando o servidor
  /// confirma que o token é inválido/expirado (401).
  Future<void> checkAuthStatus() async {
    emit(const AuthLoading());

    final token = await _tokenStorage.read(_tokenKey);
    if (token == null || token.isEmpty) {
      emit(const AuthUnauthenticated());
      return;
    }

    try {
      final user = await _userRepository.getMe();
      AppLogger.info('Sessão válida: ${user.email}', 'AuthCubit');
      emit(AuthAuthenticated(user));
    } on UnauthorizedException catch (e, stackTrace) {
      AppLogger.error('Sessão expirada ou inválida', e, stackTrace, 'AuthCubit');
      await _tokenStorage.delete(_tokenKey);
      emit(const AuthUnauthenticated());
    } catch (e, stackTrace) {
      AppLogger.error(
        'Não foi possível validar a sessão com o servidor agora',
        e,
        stackTrace,
        'AuthCubit',
      );
      final cachedUser = _userLocalDataSource.getUser();
      if (cachedUser != null) {
        AppLogger.info('Sessão mantida com dados em cache', 'AuthCubit');
        emit(AuthAuthenticated(cachedUser));
      } else {
        emit(const AuthUnauthenticated());
      }
    }
  }

  Future<bool> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await _userRepository.login(email, password);
      AppLogger.info('Login realizado: ${user.email}', 'AuthCubit');
      emit(AuthAuthenticated(user));
      return true;
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Falha no login', e, stackTrace, 'AuthCubit');
      emit(AuthError(e.message));
      return false;
    } catch (e, stackTrace) {
      final message = l10n.errorLogin;
      AppLogger.error(message, e, stackTrace, 'AuthCubit');
      emit(AuthError(message));
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await _userRepository.register(name, email, password);
      AppLogger.info('Registro realizado: ${user.email}', 'AuthCubit');
      emit(AuthAuthenticated(user));
      return true;
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Falha no registro', e, stackTrace, 'AuthCubit');
      emit(AuthError(e.message));
      return false;
    } catch (e, stackTrace) {
      final message = l10n.errorRegister;
      AppLogger.error(message, e, stackTrace, 'AuthCubit');
      emit(AuthError(message));
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _userRepository.logout();
      AppLogger.info('Logout realizado', 'AuthCubit');
      emit(const AuthUnauthenticated());
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Falha no logout', e, stackTrace, 'AuthCubit');
      emit(AuthError(e.message));
    }
  }
}
