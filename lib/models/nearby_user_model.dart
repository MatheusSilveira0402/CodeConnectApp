import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nearby_user_model.g.dart';

/// Modelo de um dev próximo, retornado por `GET /users/nearby`
@JsonSerializable()
class NearbyUserModel extends Equatable {
  final String id;
  final String name;
  final String? username;
  final String? avatar;
  final double latitude;
  final double longitude;
  final double distanceKm;

  const NearbyUserModel({
    required this.id,
    required this.name,
    this.username,
    this.avatar,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
  });

  factory NearbyUserModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyUserModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    avatar,
    latitude,
    longitude,
    distanceKm,
  ];
}
