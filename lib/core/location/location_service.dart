import 'package:geolocator/geolocator.dart';

/// Erros específicos de obtenção de localização, para a UI poder
/// diferenciar "permissão negada" de "serviço desligado" de outros erros.
enum LocationErrorType { permissionDenied, serviceDisabled, unknown }

class LocationException implements Exception {
  final LocationErrorType type;
  LocationException(this.type);
}

/// Encapsula o acesso à localização do dispositivo via `geolocator`.
class LocationService {
  /// Retorna a posição atual do dispositivo, pedindo permissão se
  /// necessário. Lança [LocationException] se o usuário negar a
  /// permissão ou o serviço de localização estiver desligado.
  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException(LocationErrorType.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationException(LocationErrorType.permissionDenied);
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}
