import 'package:code_connect/core/secure/secure_storage.dart';
import 'package:dio/dio.dart';
import '../core/exceptions/api_exception.dart';
import '../core/http/http_client.dart';
import '../core/localization/app_localizations_context.dart';
import '../core/utils/app_logger.dart';
import '../models/user_model.dart';
import '../models/auth_response_model.dart';
import '../models/nearby_user_model.dart';
import '../models/public_user_model.dart';

/// Interface do repositório de usuário
abstract class IUserRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> getMe();
  Future<UserModel> updateAvatar(String avatarPath);
  Future<void> logout();
  Future<UserModel> updateLocation(double latitude, double longitude);
  Future<List<NearbyUserModel>> getNearbyUsers({
    required double latitude,
    required double longitude,
    double radiusKm,
  });
  Future<PublicUserModel> getUserById(String id);
}

/// Implementação do repositório de usuário
class UserRepository implements IUserRepository {
  final Dio _dio = HttpClient.instance.dio;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      AppLogger.debug('Tentando fazer login: $email', 'UserRepository');

      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await SecureStorage.saveToken(authResponse.accessToken);

      AppLogger.info('Login realizado com sucesso', 'UserRepository');
      return authResponse.user;
    } on DioException catch (e) {
      AppLogger.error('Erro no login', e, null, 'UserRepository');
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      AppLogger.debug('Tentando registrar usuário: $email', 'UserRepository');

      final response = await _dio.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await SecureStorage.saveToken(authResponse.accessToken);

      AppLogger.info('Registro realizado com sucesso', 'UserRepository');
      return authResponse.user;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('Erro no registro', e, stackTrace, 'UserRepository');
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get('/auth/me');
      AppLogger.debug('Perfil do usuário obtido', 'UserRepository');
      return UserModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('Erro ao obter perfil', e, stackTrace, 'UserRepository');
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> updateAvatar(String avatarPath) async {
    try {
      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(avatarPath),
      });
      final response = await _dio.put('/users/avatar', data: formData);
      AppLogger.info('Avatar atualizado com sucesso', 'UserRepository');
      return UserModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao atualizar avatar',
        e,
        stackTrace,
        'UserRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await SecureStorage.deleteToken();
      AppLogger.info('Token removido com sucesso', 'UserRepository');
      // Opcional: chamar endpoint de logout no backend se existir
      // await _dio.post('/auth/logout');
    } on DioException catch (e, stackTrace) {
      AppLogger.error('Erro ao fazer logout', e, stackTrace, 'UserRepository');
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> updateLocation(double latitude, double longitude) async {
    try {
      final response = await _dio.patch(
        '/users/location',
        data: {'latitude': latitude, 'longitude': longitude},
      );
      AppLogger.info('Localização atualizada com sucesso', 'UserRepository');
      return UserModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao atualizar localização',
        e,
        stackTrace,
        'UserRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<List<NearbyUserModel>> getNearbyUsers({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/users/nearby',
        queryParameters: {
          'lat': latitude,
          'lng': longitude,
          'radiusKm': radiusKm,
        },
      );
      final users = (response.data as List)
          .map((e) => NearbyUserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      AppLogger.debug('${users.length} devs próximos encontrados', 'UserRepository');
      return users;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao buscar devs próximos',
        e,
        stackTrace,
        'UserRepository',
      );
      throw _handleError(e);
    }
  }

  @override
  Future<PublicUserModel> getUserById(String id) async {
    try {
      final response = await _dio.get('/users/$id');
      return PublicUserModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'Erro ao buscar perfil público #$id',
        e,
        stackTrace,
        'UserRepository',
      );
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException e) {
    // Erros de rede/conexão
    if (e.type == DioExceptionType.connectionTimeout) {
      return NetworkException(l10n.errorConnectionTimeout);
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return NetworkException(l10n.errorReceiveTimeout);
    }
    if (e.type == DioExceptionType.connectionError) {
      return NetworkException(l10n.errorConnection);
    }

    // Erros HTTP
    final statusCode = e.response?.statusCode;
    final message = e.response?.data is Map
        ? (e.response?.data['message'] ?? e.response?.data['error'])
        : null;

    switch (statusCode) {
      case 400:
        return ApiException(
          message: message ?? l10n.errorInvalidData,
          statusCode: 400,
          data: e.response?.data,
        );
      case 401:
        return UnauthorizedException(message ?? l10n.errorWrongCredentials);
      case 403:
        return ApiException(
          message: message ?? l10n.errorAccessDenied,
          statusCode: 403,
          data: e.response?.data,
        );
      case 409:
        return ApiException(
          message: message ?? l10n.errorEmailAlreadyUsed,
          statusCode: 409,
          data: e.response?.data,
        );
      case 422:
        return ApiException(
          message: message ?? l10n.errorInvalidDataShort,
          statusCode: 422,
          data: e.response?.data,
        );
      case 500:
        return ApiException(
          message: l10n.errorServer,
          statusCode: 500,
          data: e.response?.data,
        );
      default:
        return ApiException(
          message: message ?? l10n.errorGeneric,
          statusCode: statusCode,
          data: e.response?.data,
        );
    }
  }
}
