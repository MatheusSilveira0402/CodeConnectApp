import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cache/user_local_data_source.dart';
import '../../core/exceptions/api_exception.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/location/location_service.dart';
import '../../core/utils/app_logger.dart';
import '../../repositories/user_repository.dart';
import 'perfil_state.dart';

class PerfilCubit extends Cubit<PerfilState> {
  final IUserRepository _repository;
  final UserLocalDataSource _localDataSource;
  final LocationService _locationService;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  PerfilCubit(
    this._repository, [
    UserLocalDataSource? localDataSource,
    LocationService? locationService,
    Stream<List<ConnectivityResult>>? connectivityStream,
  ]) : _localDataSource = localDataSource ?? UserLocalDataSource(),
       _locationService = locationService ?? LocationService(),
       super(const PerfilInitial()) {
    _connectivitySubscription =
        (connectivityStream ?? Connectivity().onConnectivityChanged).listen(
          _onConnectivityChanged,
        );
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final isOnline = results.any((r) => r != ConnectivityResult.none);
    final currentState = state;
    if (isOnline && currentState is PerfilLoaded && currentState.isOffline) {
      AppLogger.info('Conexão restaurada, sincronizando perfil', 'PerfilCubit');
      loadUserProfile();
    }
  }

  Future<void> loadUserProfile() async {
    emit(const PerfilLoading());
    try {
      final user = await _repository.getMe();
      await _localDataSource.saveUser(user);
      AppLogger.info('Perfil carregado: ${user.name}', 'PerfilCubit');
      emit(PerfilLoaded(user));
    } on NetworkException catch (e, stackTrace) {
      AppLogger.error(
        'Sem conexão, tentando cache local',
        e,
        stackTrace,
        'PerfilCubit',
      );
      final cachedUser = _localDataSource.getUser();
      if (cachedUser != null) {
        AppLogger.info('Perfil carregado do cache local', 'PerfilCubit');
        emit(PerfilLoaded(cachedUser, isOffline: true));
      } else {
        emit(PerfilError(l10n.errorOfflineNoCache));
      }
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Erro ao carregar perfil', e, stackTrace, 'PerfilCubit');
      emit(PerfilError(e.message));
    } catch (e, stackTrace) {
      final message = l10n.errorLoadingProfile;
      AppLogger.error(message, e, stackTrace, 'PerfilCubit');
      emit(PerfilError(message));
    }
  }

  Future<void> updateAvatar(String path) async {
    emit(const PerfilLoading());
    try {
      final user = await _repository.updateAvatar(path);
      await _localDataSource.saveUser(user);
      AppLogger.info('Avatar atualizado', 'PerfilCubit');
      emit(PerfilLoaded(user));
    } on ApiException catch (e, stackTrace) {
      AppLogger.error('Erro ao atualizar avatar', e, stackTrace, 'PerfilCubit');
      emit(PerfilError(e.message));
    } catch (e, stackTrace) {
      final message = l10n.errorUpdateAvatar;
      AppLogger.error(message, e, stackTrace, 'PerfilCubit');
      emit(PerfilError(message));
    }
  }

  /// Captura a localização atual do dispositivo e salva no perfil do
  /// usuário logado (usado pela feature "Devs Near You").
  /// Retorna null em caso de sucesso, ou uma mensagem de erro localizada.
  Future<String?> shareLocation() async {
    try {
      final position = await _locationService.getCurrentPosition();
      final user = await _repository.updateLocation(
        position.latitude,
        position.longitude,
      );
      await _localDataSource.saveUser(user);
      AppLogger.info('Localização compartilhada', 'PerfilCubit');
      emit(PerfilLoaded(user));
      return null;
    } on LocationException catch (e) {
      final message = switch (e.type) {
        LocationErrorType.permissionDenied =>
          l10n.locationPermissionDeniedMessage,
        LocationErrorType.serviceDisabled =>
          l10n.locationServiceDisabledMessage,
        LocationErrorType.unknown => l10n.errorGettingLocation,
      };
      AppLogger.error(message, e, null, 'PerfilCubit');
      return message;
    } on ApiException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao compartilhar localização',
        e,
        stackTrace,
        'PerfilCubit',
      );
      return e.message;
    } catch (e, stackTrace) {
      final message = l10n.errorSharingLocation;
      AppLogger.error(message, e, stackTrace, 'PerfilCubit');
      return message;
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
