import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';

sealed class PerfilState extends Equatable {
  const PerfilState();

  @override
  List<Object?> get props => [];
}

class PerfilInitial extends PerfilState {
  const PerfilInitial();
}

class PerfilLoading extends PerfilState {
  const PerfilLoading();
}

class PerfilLoaded extends PerfilState {
  final UserModel user;

  /// true quando os dados vieram do cache local por falta de conexão
  final bool isOffline;

  const PerfilLoaded(this.user, {this.isOffline = false});

  @override
  List<Object?> get props => [user, isOffline];
}

class PerfilError extends PerfilState {
  final String message;
  const PerfilError(this.message);

  @override
  List<Object?> get props => [message];
}
