import 'package:dio/dio.dart';
import 'package:code_connect/core/secure/secure_storage.dart';

/// Cliente HTTP singleton para comunicação com a API
class HttpClient {
  HttpClient._();

  static final instance = HttpClient._();

  late final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: 'http://192.168.1.233:3000',
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.addAll([
          LogInterceptor(requestBody: true, responseBody: true, error: true),
          _AuthInterceptor(),
        ]);
}

/// Interceptor para adicionar token de autenticação
class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Adiciona o token nas requisições autenticadas
    final token = await SecureStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expirado ou inválido - limpar token
      SecureStorage.deleteToken();
      // TODO: Redirecionar para tela de login
    }
    handler.next(err);
  }
}
