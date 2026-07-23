import 'package:json_annotation/json_annotation.dart';

part 'public_user_model.g.dart';

/// Perfil público de um usuário, retornado por `GET /users/:id`
/// (usado ao tocar no marcador de um dev no mapa)
@JsonSerializable()
class PublicUserModel {
  final String id;
  final String name;
  final String? username;
  final String? avatar;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  PublicUserModel({
    required this.id,
    required this.name,
    this.username,
    this.avatar,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  factory PublicUserModel.fromJson(Map<String, dynamic> json) =>
      _$PublicUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicUserModelToJson(this);
}
