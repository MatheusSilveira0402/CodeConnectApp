import 'package:equatable/equatable.dart';
import '../../models/nearby_user_model.dart';

sealed class NearbyDevsState extends Equatable {
  const NearbyDevsState();

  @override
  List<Object?> get props => [];
}

class NearbyDevsInitial extends NearbyDevsState {
  const NearbyDevsInitial();
}

class NearbyDevsLoading extends NearbyDevsState {
  const NearbyDevsLoading();
}

class NearbyDevsLoaded extends NearbyDevsState {
  final double latitude;
  final double longitude;
  final List<NearbyUserModel> devs;

  const NearbyDevsLoaded({
    required this.latitude,
    required this.longitude,
    required this.devs,
  });

  @override
  List<Object?> get props => [latitude, longitude, devs];
}

class NearbyDevsError extends NearbyDevsState {
  final String message;
  const NearbyDevsError(this.message);

  @override
  List<Object?> get props => [message];
}
