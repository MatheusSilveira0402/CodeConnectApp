import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../core/location/location_service.dart';
import '../../core/utils/app_logger.dart';
import '../../repositories/user_repository.dart';
import 'nearby_devs_state.dart';

class NearbyDevsCubit extends Cubit<NearbyDevsState> {
  final IUserRepository _repository;
  final LocationService _locationService;

  NearbyDevsCubit(this._repository, [LocationService? locationService])
    : _locationService = locationService ?? LocationService(),
      super(const NearbyDevsInitial());

  Future<void> loadNearbyDevs({double radiusKm = 10}) async {
    emit(const NearbyDevsLoading());
    try {
      final position = await _locationService.getCurrentPosition();
      final devs = await _repository.getNearbyUsers(
        latitude: position.latitude,
        longitude: position.longitude,
        radiusKm: radiusKm,
      );
      AppLogger.info(
        '${devs.length} devs próximos carregados',
        'NearbyDevsCubit',
      );
      emit(
        NearbyDevsLoaded(
          latitude: position.latitude,
          longitude: position.longitude,
          devs: devs,
        ),
      );
    } on LocationException catch (e) {
      final message = switch (e.type) {
        LocationErrorType.permissionDenied =>
          l10n.locationPermissionDeniedMessage,
        LocationErrorType.serviceDisabled =>
          l10n.locationServiceDisabledMessage,
        LocationErrorType.unknown => l10n.errorGettingLocation,
      };
      AppLogger.error(message, e, null, 'NearbyDevsCubit');
      emit(NearbyDevsError(message));
    } catch (e, stackTrace) {
      final message = l10n.errorLoadingNearbyDevs;
      AppLogger.error(message, e, stackTrace, 'NearbyDevsCubit');
      emit(NearbyDevsError(message));
    }
  }
}
