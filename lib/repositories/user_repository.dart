import 'package:code_connect/core/secure/secure_storage.dart';
import 'package:dio/dio.dart';
import '../core/exceptions/api_exception.dart';
import '../core/http/http_client.dart';
import '../models/user_model.dart';
import '../models/auth_response_model.dart';

/// Interface do repositório de usuário
abstract class IUserRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> getMe();
  Future<UserModel> updateAvatar(String avatarPath);
  Future<void> logout();
}

/// Implementação do repositório de usuário
class UserRepository implements IUserRepository {
  final Dio _dio = HttpClient.instance.dio;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await SecureStorage.saveToken(authResponse.accessToken);

      return authResponse.user;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      final authResponse = AuthResponseModel.fromJson(response.data);
      await SecureStorage.saveToken(authResponse.accessToken);

      return authResponse.user;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get('/auth/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
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
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await SecureStorage.deleteToken();
      // Opcional: chamar endpoint de logout no backend se existir
      // await _dio.post('/auth/logout');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ApiException _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('Timeout na conexão');
    }
    if (e.response?.statusCode == 401) {
      return UnauthorizedException();
    }
    return ApiException(
      message: e.response?.data['message'] ?? 'Erro desconhecido',
      statusCode: e.response?.statusCode,
      data: e.response?.data,
    );
  }
}
