import 'package:flutter/foundation.dart';

/// Logger centralizado para o aplicativo
/// Facilita debug e rastreamento de erros em produção
class AppLogger {
  AppLogger._();

  static const String _prefix = '[CodeConnect]';

  /// Log de informação
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      print('$_prefix ${tag != null ? "[$tag]" : ""} INFO: $message');
    }
  }

  /// Log de erro
  static void error(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  ]) {
    if (kDebugMode) {
      print('$_prefix ${tag != null ? "[$tag]" : ""} ERROR: $message');
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }

  /// Log de aviso
  static void warning(String message, [String? tag]) {
    if (kDebugMode) {
      print('$_prefix ${tag != null ? "[$tag]" : ""} WARNING: $message');
    }
  }

  /// Log de debug (apenas em modo debug)
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      print('$_prefix ${tag != null ? "[$tag]" : ""} DEBUG: $message');
    }
  }

  /// Log de requisição HTTP
  static void http(String method, String url, [int? statusCode]) {
    if (kDebugMode) {
      final status = statusCode != null ? ' - Status: $statusCode' : '';
      print('$_prefix [HTTP] $method $url$status');
    }
  }
}
