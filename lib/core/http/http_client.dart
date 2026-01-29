import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:code_connect/core/secure/secure_storage.dart';
import 'package:code_connect/core/utils/app_logger.dart';

/// Cliente HTTP singleton para comunicação com a API
///
/// Implementa padrão Singleton para garantir uma única instância
/// do cliente HTTP em toda a aplicação. Configurado com:
/// - Timeout de 30 segundos
/// - Headers padrão JSON
/// - Interceptor de autenticação automática
/// - Logging de requisições em desenvolvimento
class HttpClient {
  HttpClient._();

  static final instance = HttpClient._();

  /// URL base da API - carregada do arquivo .env
  /// Configure no .env: API_BASE_URL=http://seu-servidor:3000
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://192.168.1.233:3000';

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      // Força usar a baseUrl sem proxy
      followRedirects: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  )..interceptors.addAll([_LoggingInterceptor(), _AuthInterceptor()]);
}

/// Interceptor customizado para logging de requisições
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final uri = options.uri.toString();
    AppLogger.http(options.method, uri);
    AppLogger.debug('Headers: ${options.headers}', 'HTTP');
    if (options.data != null) {
      AppLogger.debug('Body: ${options.data}', 'HTTP');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final uri = response.requestOptions.uri.toString();
    AppLogger.http(response.requestOptions.method, uri, response.statusCode);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final uri = err.requestOptions.uri.toString();
    AppLogger.error('HTTP Error: ${err.message}', err, err.stackTrace, 'HTTP');
    AppLogger.debug('URL tentada: $uri', 'HTTP');
    handler.next(err);
  }
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
      // Nota: Redirecionamento para login deve ser tratado pela aplicação
      // via listeners de estado de autenticação
    }
    handler.next(err);
  }
}
