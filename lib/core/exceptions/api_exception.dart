/// Exception base para erros da API
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

/// Exception para erros de rede
class NetworkException extends ApiException {
  NetworkException([String message = 'Erro de conexão'])
    : super(message: message);
}

/// Exception para erros de autenticação
class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = 'Não autorizado'])
    : super(message: message, statusCode: 401);
}
