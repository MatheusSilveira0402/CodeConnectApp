import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/exceptions/api_exception.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/utils/app_logger.dart';
import '../../repositories/user_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IUserRepository _userRepository;

  AuthCubit(this._userRepository) : super(const AuthInitial());

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
